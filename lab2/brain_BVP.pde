TITLE 
	'Brain BVP'     { the problem identification }

COORDINATES 
	CARTESIAN2  { coordinate system, 1D,2D,3D, etc }

VARIABLES  { system variables }
  	V                { Potential}

DEFINITIONS
	R = 9 		  		{ Radius = 9cm}
	sigma = 4.5		{ Homogenous conductivity, 4.5mS/cm }
    Js = 80			{ Current density, 80uA/cm^2 }
	alpha = 0.28	{ Angular coverage of the electrodes }
	ang = arcsin(y/sqrt(x*x+y*y))
	cd = -sigma*grad(V)	{ current density vector}

EQUATIONS        
  div(-sigma*grad(V))=0 { one possibility }

BOUNDARIES       { The domain definition }
  REGION 1 'head'       { For each material region }
	START(0,0)
	natural(V) = 0
	LINE TO (R, 0)
	natural(V) = Js    
	ARC(CENTER=0,0) ANGLE=16
	natural(V) = 0	
	ARC(CENTER=0,0) ANGLE=74
	value(V) = 0	
	LINE TO (0,0) TO CLOSE

	feature 'circ'
		START (R,0) ARC(CENTER=0,0) to (0,R)
	
MONITORS         { show progress }
	CONTOUR(V) as 'Potential'

PLOTS 
	CONTOUR(V)	{ contour of the potentials}
	VECTOR(cd) as 'Current density'		{ -sigma*grad(V), instead of sigma*V like in 1D Ohm's law, because in V=IR, V is already the negative gradient of potential }
	{ magnitude(cd) and normal(cd) available }
	
	{ Plots to be exported }
	ELEVATION(V) from (0,0) to (R,0) as 'Potential along x-axis' export file 'pot_along_x.txt' format '#x,#1' noheader
	ELEVATION(V) ON 'circ' as 'Potential along circumference' export file 'pot_along_circ.txt' format '#x,#1' noheader
	ELEVATION(magnitude(-grad(V))) from (0,0) to (R,0) as 'E-field magnitude along x-axis' export file 'e_mag_along_x.txt' format '#x,#1' noheader
	ELEVATION(magnitude(-grad(V))) ON 'circ' as 'E-field magnitude along circumference' export file 'e_mag_along_circ.txt' format '#x,#1' noheader
	ELEVATION(normal(cd)) from (0,0) to (R,0) as 'Angular current density along x-axis' export file 'j_ang_along_x.txt' format '#x,#1' noheader
	ELEVATION(normal(cd)) ON 'circ' as 'Normal current density along circumference' export file 'j_norm_along_circ.txt' format '#x,#1' noheader
	
END
