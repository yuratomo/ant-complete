 call antcore#namespace('')

call antcore#class('selector', '', [
  \ antcore#attr('contains', ''),
  \ antcore#attr('date', ''),
  \ antcore#attr('depend', ''),
  \ antcore#attr('depth', ''),
  \ antcore#attr('filename', ''),
  \ antcore#attr('present', ''),
  \ antcore#attr('size', ''),
  \ ])

call antcore#class('contains', '', [
  \ antcore#attr('text', ''),
  \ antcore#attr('casesensitive', ''),
  \ antcore#attr('refid', ''),
  \ ])

call antcore#class('date', '', [
  \ antcore#attr('datetime', ''),
  \ antcore#attr('millis', ''),
  \ antcore#attr('guranularity', ''),
  \ antcore#attr('when', ''),
  \ antcore#attr('refid', ''),
  \ ])

call antcore#class('depend', '', [
  \ antcore#attr('targetdir', ''),
  \ antcore#attr('guranularity', ''),
  \ antcore#attr('refid', ''),
  \ ])

call antcore#class('depth', '', [
  \ antcore#attr('min', ''),
  \ antcore#attr('max', ''),
  \ antcore#attr('refid', ''),
  \ ])

call antcore#class('filename', '', [
  \ antcore#attr('name', ''),
  \ antcore#attr('casesensitive', ''),
  \ antcore#attr('negate', ''),
  \ antcore#attr('refid', ''),
  \ ])

call antcore#class('size', '', [
  \ antcore#attr('value', ''),
  \ antcore#attr('units', ''),
  \ antcore#attr('when', ''),
  \ antcore#attr('refid', ''),
  \ ])

call antcore#class('and', '', [
  \ antcore#attr('id', ''),
  \ antcore#attr('refid', ''),
  \ antcore#attr('description', ''),
  \ ])

call antcore#class('or', '', [
  \ antcore#attr('id', ''),
  \ antcore#attr('refid', ''),
  \ antcore#attr('description', ''),
  \ ])

call antcore#class('none', '', [
  \ antcore#attr('id', ''),
  \ antcore#attr('refid', ''),
  \ antcore#attr('description', ''),
  \ ])

call antcore#class('not', '', [
  \ antcore#attr('id', ''),
  \ antcore#attr('refid', ''),
  \ antcore#attr('description', ''),
  \ ])

call antcore#class('majority', '', [
  \ antcore#attr('id', ''),
  \ antcore#attr('refid', ''),
  \ antcore#attr('description', ''),
  \ ])

call antcore#class('custom', '', [
  \ antcore#attr('classname', ''),
  \ antcore#attr('classpath', ''),
  \ antcore#attr('classpathref', ''),
  \ ])

