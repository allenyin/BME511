TITLE 
	'Lead-field in 2D region'     { the problem identification }
COORDINATES 
	cartesian2  { coordinate system, 1D,2D,3D, etc }

VARIABLES        
  	 V                    { static voltage }

DEFINITIONS
	L = 0.6				{ cm, length of the fiber }
	c = 0.1				{ cm, placement of electrodes }
    d = 0.1				{ cm, width of the 2D region }
	sigma_o = 20	{ mS/cm, extracellular conductivity }
    rA = sqrt((x+c)^2+(y-d)^2)
    rB = sqrt((x-c)^2+(y-d)^2)
    phi_semi = -1/(pi*sigma_o)*ln(rA) +1/(pi*sigma_o)*ln(rB)

EQUATIONS        
  div(-sigma_o*grad(V))=0 { one possibility }
  

BOUNDARIES       
  REGION 1       
    START(-L, -d)
	natural(V) = 0
	LINE TO (L, -d)
	LINE TO (L, d)
	LINE TO (c, d) point load(V)=1	{ electrode B }
	LINE TO (0,d) point value(V)=0
	LINE TO (-c, d) point load(V)=-1 { electrode A }
	LINE TO (-L, d) TO CLOSE
  FEATURE 'pathx' 	{ path along the fiber }
	start (-L, 0) line to (L,0)

PLOTS           
  CONTOUR(V) as 'Contour due to electrodes'
  ELEVATION(V) on 'pathx' as 'Lead potential'
  ELEVATION(dx(V)) on 'pathx' as 'Lead field'
  ELEVATION(phi_semi, V) on 'pathx' as 'Semi-infinite and finite Lead potential'
  ELEVATION(dx(phi_semi), dx(V)) on 'pathx' as 'Semi-infinite and finite Lead Field (x)'
  ELEVATION(dy(phi_semi), dy(V)) on 'pathx' as 'Semi-infinite and finite Lead Field (y)'

  { export x component of lead field }
  ELEVATION(dx(phi_semi)) from (-L,0) to (L,0) as 'Semi-infinite X Lead Field' export (51) file='dphi_semi.tbl'
  ELEVATION(dx(V)) from (-L,0) to (L,0) as 'Finite X Lead Field' export(51) file='dV.tbl'
	

END
