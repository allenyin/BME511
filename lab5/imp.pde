
title 'importing data to FlexPDE'

coordinates
  cartesian1

definitions
    len = 0.6	{ should have the same value as in exporting script! }
    u1 = table("junk.tbl")	{ read exported data }
    u2 = x^2	{ make up some other function of x }
    uu = u1*u2	{ now you can do operations using imported u1 and defined u2 } 

boundaries
    Region 1	{ note that geometry here is 1D, it was 2D in exporting script }
      start(-len)
      line to (len)

plots
    elevation(u1) as "imported"
    elevation(u2) as "defined"
    elevation(uu) as "product"
end

 
