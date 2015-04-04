TITLE 
    'Head Model - Concentric Shells'

COORDINATES
    cartesian3

VARIABLES
    V

DEFINITIONS
    sigma_br = 4.5    { Brain conductivity, mS/cm }
    sigma_sk = 0.056  { Skull conductivity, mS/cm }
    sigma_sc = 4.5    { scalp conductivity, mS/cm }
	sigma = sigma_sc
    R_br = 6          { Brain radius, cm }
    R_sk = 8        { Skull radius, cm }
    R_sc = 9.2       { Scalp radius, cm }
    r = sqrt(x^2+y^2)
	zt = SPHERE ((0,0,0), R_sc)

EQUATIONS
    div(-sigma*grad(V)) = 0

EXTRUSION
    { z from low to high }
    surface 'SB1' z = -SPHERE ((0,0,0), R_sc)      { bottom of scalp shell }
        layer 'LB1'
    surface 'SB2' z = -SPHERE ((0,0,0), R_sk)      { bottom of skull shell }
        layer 'LB2'
    surface 'SB3' z = -SPHERE ((0,0,0), R_br)      { bottom of brain shell }
        layer 'L3'
    surface 'ST3' z = SPHERE ((0,0,0), R_br)       { top of brain shell }
        layer 'LT2'
    surface 'ST2' z = SPHERE ((0,0,0), R_sk)
        layer 'LT1'
    surface 'ST1' z = zt

BOUNDARIES
    
    surface 'ST1' natural(V) = 0
    surface 'SB1' natural(V) = 0

	Limited Region 1 { electrodes 1}
		zt = R_sc
		surface 'ST1'
 		start(0,0) point load(V) = 1 { Cz, 1mA }
		line to close
	
	Limited Region 2 { electrodes 2 }
		zt = 6.44
		surface 'ST1'
		start(6.578, 0) point load(V) = -1 { Fz, -1mA }
		line to close	

	Limited Region 3 { arbitrary ground point as a test }
		zt = 6
		surface 'ST1'
		start(6, 6) point value(V) = 0	{ ground }
		line to close

    Region 4    { the scalp }
        layer 'LB1' sigma = sigma_sc
        layer 'LT1' sigma = sigma_sc
        start(R_sc, 0)
        arc(center=0, 0) angle=360
        line to close


    Limited Region 5 { the skull }
        layer 'LB2' sigma = sigma_sk
        layer 'LT2' sigma = sigma_sk
            { include region that's to be merged out }
            layer 'L3'
        start(R_sk, 0)
        arc(center=0, 0) angle=360
        line to close

    Limited Region 6 { the brain }
        layer 'L3' sigma = sigma_br
        start(R_br, 0)
        arc(center=0, 0) angle=360
        line to close

PLOTS
	grid(x,y,z)
	contour(V) on x=0 	as 'Potential on YZ plane through diameter'
	contour(V) on z=9	as 'Potential on z=9'
end
