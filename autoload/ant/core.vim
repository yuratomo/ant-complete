 call antcore#namespace('')

 call antcore#class('project', '', [ 
  \ antcore#attr('name', ''),
  \ antcore#attr('default', ''),
  \ antcore#attr('basedir', ''),
  \ ])

 call antcore#class('target', '', [ 
  \ antcore#attr('name', ''),
  \ antcore#attr('depends', ''),
  \ antcore#attr('if', ''),
  \ antcore#attr('unless', ''),
  \ antcore#attr('description', ''),
  \ ])

 call antcore#class('task', '', [ 
  \ antcore#attr('id', ''),
  \ antcore#attr('taskname', ''),
  \ antcore#attr('description', ''),
  \ ])

call antcore#class('filelset', '', [
  \ antcore#attr('dir',''),
  \ antcore#attr('file',''),
  \ antcore#attr('defaultexcludes',''),
  \ antcore#attr('includes',''),
  \ antcore#attr('includesfile',''),
  \ antcore#attr('excludes',''),
  \ antcore#attr('excludesfile',''),
  \ ])

call antcore#class('mapper', '', [
  \ antcore#attr('type',''),
  \ antcore#attr('classname',''),
  \ antcore#attr('classpath',''),
  \ antcore#attr('classpathref',''),
  \ antcore#attr('from',''),
  \ antcore#attr('to',''),
  \ antcore#attr('refid',''),
  \ ])

call antcore#class('patternset', '', [
  \ antcore#attr('includes', ''),
  \ antcore#attr('includesfile', ''),
  \ antcore#attr('excludes', ''),
  \ antcore#attr('excludesfile', ''),
  \ antcore#attr('refid', ''),
  \ ])

call antcore#class('patternset', '', [
  \ antcore#attr('dir', ''),
  \ antcore#attr('defaultexcludes', ''),
  \ antcore#attr('includes', ''),
  \ antcore#attr('includesfile', ''),
  \ antcore#attr('excludes', ''),
  \ antcore#attr('excludesfile', ''),
  \ antcore#attr('casesensitive', ''),
  \ antcore#attr('followsymlinks', ''),
  \ ])

call antcore#class('path', '', [
  \ antcore#attr('path', ''),
  \ antcore#attr('location', ''),
  \ antcore#attr('refid', ''),
  \ ])

call antcore#class('classpath', '', [
  \ antcore#attr('path', ''),
  \ antcore#attr('location', ''),
  \ antcore#attr('refid', ''),
  \ ])

call antcore#class('Pathelement', '', [
  \ antcore#attr('path', ''),
  \ antcore#attr('location', ''),
  \ antcore#attr('refid', ''),
  \ ])

