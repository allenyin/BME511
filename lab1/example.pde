
{ BME 511, Spring 2015, example.pde: Inhomog. rect. region with mixed BC }

title
  'rectangular region'		{ will be printed on all graphs }

variables
  V		{ dependent variable: potential }

definitions
  sigma1 = 1	{ conductivity in region 1 }
  sigma2 = 10	{ conductivity in region 2 }
  len1 = 1	{ length of region 1 }
  len2 = 5	{ overall length }
  cden = - 20	{ applied current density }
  w = len2/5	{ region width, assume length/5 }
  sigma		{ conductivity, variable, so no value but must be defined }

equations
  V:	div(-sigma*grad(V)) = 0		{ equation for potential }

boundaries
  region 1		{ over entire model }
    sigma = sigma1	{ assign conductivity for region 1 }
    start (0,0)		{ define geometry and all BC }
    natural(V) = 0
    line to (len2,0)
    natural(V) = cden
    line to (len2,w)
    natural(V) = 0
    line to (0,w)
    value(V) =0
    line to close
  region 2
    sigma = sigma2	{ assign conductivity for region 2 }
    start (len1,0)	{ define geometry only }
    line to (len2,0) to (len2,w) to (len1,w) to close

monitors
  contour(V) as 'Potential'	{ will be seen during solution process }

plots				{ will be plotted after solution obtained }
  contour(V) as 'Potential'
  elevation(V) from (0,0) to (len2,0) as 'Potential' export file 'pot.txt' format '#x #1' noheader
  elevation(dx(V)) from (0,0) to (len2,0) as 'dV/dx'
  vector(-dx(V),-dy(V)) as 'Electric Field'

end

