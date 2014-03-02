let [ s:MODE_TAG, s:MODE_ENDTAG  , s:MODE_ATTR, s:MODE_VALUE, s:MODE_BINDING ] = range(5)
let [ s:TAG_KIND_NORMAL, s:TAG_KIND_BRACE ] = range(2)
let s:complete_mode = s:MODE_TAG

let s:namespace = ''
let s:tag = ''
let s:tag_kind = ''
let s:property = ''

function! ant#complete(findstart, base)
  if a:findstart
    let line = getline('.')
    let start = col('.') - 1

    " find start of word
    while start > 0 && line[start - 1] !~ '[< :/.={ \t"]'
      let start -= 1
    endwhile

    " resolve complete mode [TAG/VALUE/BINDING/ATTR]
    if line[start - 1] =~ '[<:]'
      let s:complete_mode = s:MODE_TAG
    elseif line[start - 1] =~ '/'
      let s:complete_mode = s:MODE_ENDTAG
    elseif line[start - 1] =~ '["=]'
      let s:complete_mode = s:MODE_VALUE
    elseif line[start - 1] == '{'
      let s:complete_mode = s:MODE_BINDING
    elseif line[start - 1] == '>'
      return
    else
      let s:complete_mode = s:MODE_ATTR
    endif

    if start > 0 && s:complete_mode == s:MODE_ATTR 
      " Resolve TagName for Attribute
      let s:tag = s:find_tag_name()
    elseif start > 2 && s:complete_mode == s:MODE_VALUE
      let eq = strridx(line, '=', start-1)
      let next_dq = strridx(line, '"', start-2)
      if next_dq > eq
        return -3
      endif
      " start-1   --> "
      if eq != -1
        let prop_end = eq - 1
        let tag_end = -1
        let idx = prop_end
        while idx >= 0 && line[idx] !~ '[ \t]'
          if line[idx] == '.'
            let prop_start = idx + 1
            let tag_end = idx - 1
          endif
          let idx -= 1
        endwhile
        if idx >= 0
          if tag_end != -1
            let tag_start = idx + 1
            let s:tag = line[tag_start : tag_end]
          else
            let prop_start = idx + 1
            let s:tag = s:find_tag_name()
          endif
          let s:property = line[prop_start : prop_end]
        endif
      endif
    elseif s:complete_mode == s:MODE_ENDTAG
      return  xmlcomplete#CompleteTags(a:findstart, a:base)
    endif
    return start

  else
    let res = []
    if s:complete_mode == s:MODE_TAG
      call antcore#class_completion(a:base, res)

    elseif s:complete_mode == s:MODE_ENDTAG
      return xmlcomplete#CompleteTags(a:findstart, a:base)

    elseif s:complete_mode == s:MODE_ATTR
      if s:tag_kind == s:TAG_KIND_NORMAL
        call ant#attr_completion(s:tag, a:base, res, "=")

      elseif s:tag_kind == s:TAG_KIND_BRACE
        call s:property_completion(a:base, res)
      endif

    elseif s:complete_mode == s:MODE_VALUE
      call s:value_completion(s:tag, s:property, a:base, res)

    elseif s:complete_mode == s:MODE_BINDING
      call s:property_completion(a:base, res)
    endif
    return res
  endif

endfunction

function! s:find_tag_name()
  let tag = ''
  let l = line('.')
  let idx = col('.') - 2
  let line = getline(l)
  let tag_end = idx
  let coron = - 1
  let brace_count = 0

  while l >= 0
    " find first tagstart(<)
    while idx >= 0 && line[idx] != '<'
      if line[idx] == ' ' || line[idx] == '.'
        let tag_end = idx - 1
      elseif line[idx] == ':'
        let coron = idx
      elseif line[idx] == '{'
        let brace_count += 1
        if brace_count > 0
          break
        endif
      elseif line[idx] == '}'
        let brace_count -= 1
      elseif line[idx] == '>'
        return ''
      endif
      let idx -= 1
    endwhile
    if line[idx] =~ '[<{]'
      " Resolve Namespace for Attribute
      if coron != -1
        let namespace_end = coron - 1
        let namespace_start = idx + 1
        let s:namespace = line[namespace_start : namespace_end]
      endif
      " Resolve TagName for Attribute
      let tag_start = idx+1
      let tag = line[tag_start : tag_end]
      if line[idx] == '{'
        let s:tag_kind = s:TAG_KIND_BRACE
      else
        let s:tag_kind = s:TAG_KIND_NORMAL
      endif
      break
    endif

    while l >= 0
      let l -= 1
      let line = getline(l)
      let idx = len(line) - 1
      if idx >= 0
        break
      endif
    endwhile
  endwhile
  return substitute(tag, '.*:', '', '')
endfunction

function! ant#attr_completion(tag, base, res, append)
  if !antcore#isClassExist(a:tag)
    return
  endif

  let item = antcore#getClass(a:tag)
  for member in item.members
    if member.name =~ '^' . a:base && ( antcore#isAttr(member) || antcore#isEvent(member) )
      let m = copy(member)
      if m.name[-1] != '-'
        let m.name = m.name . a:append
      endif
      call add(a:res, antcore#member_to_compitem(item.name, m))
    endif
  endfor

  " find super class member
  if item.extend != ''
    call ant#attr_completion(item.extend, a:base, a:res, a:append)
  endif
endfunction

function! s:property_completion(base, res)
  " find x:Name and Name and x:Key
  for member in s:properties()
    call insert(a:res, antcore#member_to_compitem('', member), 0)
  endfor
endfunction

function! s:value_completion(tag, prop, base, res)
  if s:tag_kind == s:TAG_KIND_NORMAL
    let mtype = s:find_member_type(s:class, a:tag, a:prop)
  else
    let mtype = s:find_member_type(s:binding, a:tag, a:prop)
  endif
  if !exists('mtype.class') || mtype.class == ''
    return
  endif

  if antcore#isEnumExist(mtype.class)
    let enum = antcore#getEnum(mtype.class)
    for member in enum.members
      if member.name =~ '^' . a:base
        let m = copy(member)
        let m.name = m.name . '"'
        call add(a:res, antcore#member_to_compitem(member.name, m))
      endif
    endfor
  endif

  " if no exists member then append type
  if len(a:res) == 0
    if antcore#isEvent(mtype)
      call add(a:res, a:tag . '_' . a:prop . '()"')
    else
      call add(a:res, mtype.class)
    endif
  endif
endfunction

function! s:find_member_type(src, tag, prop)
  if !exists('a:src[ a:tag ]')
    return
  endif

  let item = a:src[ a:tag ]
  for member in item.members
    if member.name == a:prop
      return member
    endif
  endfor

  " find super class member
  if item.extend != ''
    return s:find_member_type(a:src, item.extend, a:prop)
  endif
  return antcore#prop('', '')
endfunction

function! s:properties()
  let names = []
  let lines = getline(1, line('$'))
  let class = ''
  for line in lines
    if line =~ '<property\>.*\<name\>='
      let start = matchstr(line, "\<name\>=")
      let class = 'property'
    else
      continue
    endif
    let start = stridx(line, '"', start+1)
    let end   = stridx(line, '"', start+1)
    call add(names, antcore#prop(line[ start+1 : end-1 ], class))
  endfor
  return names
endfun

function! ant#showRef()
  call antcore#showRef()
endfun

let [ s:class, s:enum, s:binding ] = antcore#classes()
