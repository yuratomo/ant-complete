call antcore#namespace('')

call antcore#enum('_classpath', [
  \ antcore#attr('org.apache.tools.ant.filters.ClassConstants', ''),
  \ antcore#attr('org.apache.tools.ant.filters.ExpandProperties', ''),
  \ antcore#attr('org.apache.tools.ant.filters.HeadFilter', ''),
  \ antcore#attr('org.apache.tools.ant.filters.LineContains', ''),
  \ antcore#attr('org.apache.tools.ant.filters.LineContainsRegExp', ''),
  \ antcore#attr('org.apache.tools.ant.filters.PrefixLines', ''),
  \ antcore#attr('org.apache.tools.ant.filters.ReplaceTokens', ''),
  \ antcore#attr('org.apache.tools.ant.filters.StripJavaComments', ''),
  \ antcore#attr('org.apache.tools.ant.filters.StripLineBreaks', ''),
  \ antcore#attr('org.apache.tools.ant.filters.StripLineComments', ''),
  \ antcore#attr('org.apache.tools.ant.filters.TabToSpaces', ''),
  \ antcore#attr('org.apache.tools.ant.filters.TailFilter', ''),
  \ ])

