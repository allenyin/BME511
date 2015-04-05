TITLE
    '2D Head Model Homo'   { the problem identification }

COORDINATES
    CARTESIAN2          { coordinate system }

VARIABLES
	V

DEFINITIONS
    R = 9               { Total radius = 9cm }
    rsk = 8.3           { Skull radius = 8.3cm }
    rbr = 7.8           { Brain radius = 7.8cm }
    sigma
    sigma_sc = 4.5      { Scalp conductivity = 4.5mS/cm }
    sigma_sk = 0.072    { Skull conductivity = 0.072mS/cm }
    sigma_br = 1.7      { Brain conductivity = 1.7mS/cm }
    Vsurface = 169            { Electrode voltage = 169 V }
    alpha = 0.28        { Angular coverage of the electrodes }
    ang = arcsin(y/sqrt(x*x+y*y))
	cd = -sigma*grad(V)

EQUATIONS
    div(-sigma*grad(V)) = 0

BOUNDARIES
    { Make sure the bigger region is defined first }
    REGION 1 'scalp'
        sigma = sigma_sc
        START "scalp_boundary" (R,0)
		natural(V) = 0
		ARC(CENTER=0,0) ANGLE=16
		point load(V) = 1
		ARC(CENTER=0,0) ANGLE=37
		point value(V) = 0
		ARC(CENTER=0,0) ANGLE=53
		point load(V) = -1
		ARC(CENTER=0,0) ANGLE=270
		line to close

	REGION 2 'skull'
        sigma = sigma_sk
		START(rsk, 0)
        ARC(CENTER=0,0) ANGLE=360
        LINE TO CLOSE

    REGION 3 'brain'
       sigma = sigma_br
        START(rbr,0)
        ARC(CENTER=0,0) ANGLE=360
        LINE TO CLOSE
	
    feature 'circ'
            START (R,0) ARC(CENTER=0,0) to (0,R)
	!feature
	!	START 'electrode' (R,0) ARC(CENTER=0,0) ANGLE=16

PLOTS

	CONTOUR(V)	{ contour of the potentials}

end
