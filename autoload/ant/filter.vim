call antcore#namespace('')

call antcore#class('filter', '', [
  \ antcore#attr('token', ''),
  \ antcore#attr('value', ''),
  \ antcore#attr('filtersfile', ''),
  \ ])

call antcore#class('filterset', '', [
  \ antcore#attr('begintoken', ''),
  \ antcore#attr('endtoken', ''),
  \ antcore#attr('refid', ''),
  \ ])

call antcore#class('filterchain', '', [
  \ antcore#attr('refid', ''),
  \ ])

call antcore#class('filterreader', '', [
  \ antcore#attr('classname', ''),
  \ antcore#attr('classpath', '_classpath'),
  \ antcore#attr('classpathref', ''),
  \ ])

call antcore#class('param', '', [
  \ antcore#attr('name', ''),
  \ antcore#attr('type', ''),
  \ antcore#attr('value', ''),
  \ ])
