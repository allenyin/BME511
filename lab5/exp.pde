title 'exporting data from FlexPDE'

definitions
   len = 0.6
   u = exp(-16*(x^2))	{ make up some function }

boundaries
  Region 1	{ need to define a geometry, note that it is 2D }
      start(-len,0)
      line to (len,0) to (len,len) to (-len,len) to close

plots
	{ export 51 values of u for x from -len to len }
  elevation(u) from (-len,0) to (len,0) export(51) file='junk.tbl'
end
