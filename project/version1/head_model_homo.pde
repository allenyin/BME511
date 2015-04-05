TITLE 
    'Head Model - 1 spherical shell'

COORDINATES
    cartesian3

VARIABLES
    V

DEFINITIONS
    sigma_br = 4.5   
	sigma = sigma_br
    R_sc = 9.2       { Scalp radius, cm }
    r = sqrt(x^2+y^2)
	zt = SPHERE ((0,0,0), R_sc)

EQUATIONS
    div(-sigma*grad(V)) = 0

EXTRUSION
    { z from low to high }
    surface 'SB1' z = -SPHERE ((0,0,0), R_sc)      { bottom of scalp shell }
        !layer 'L1'
    surface 'ST1' z = zt

BOUNDARIES
    
    surface 'ST1' value(V) = 0
    surface 'SB1' value(V) = 0
	Region 1
		start(R_sc, 0)
		arc(center=0,0) angle=360

{
	Limited Region 2 { electrodes 1}
		zt = R_sc
		surface 'ST1'
 		start(0,0) point load(V) = 1 { Cz, 1mA }
		line to close
}
	Limited Region 2 { electrodes 2 }
		zt = sqrt(9.2^2-x^2-y^2)
		surface 'ST1'
		start(6.836, 0) 
		point load(V) = -1 { Fz, -1mA }
		natural(V) = 0
			arc(center=0,0) angle=360
		LINE TO CLOSE

	Limited Region 3 { arbitrary ground point as a test }
		zt = sqrt(9.2^2-x^2-y^2)
		surface 'ST1'
		start(0, 6.578) 
		point value(V) = 0	{ ground }
		natural(V) = 0
		arc(center=0,0) angle=360
		line to close


PLOTS
	grid(x,y,z)
	contour(V) on x=0 	as 'Potential on YZ plane through diameter'
	contour(V) on z=9	as 'Potential on z=9'
end
