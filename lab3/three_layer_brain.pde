TITLE
    'Three layer BVP'   { the problem identification }

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
        START "scalp_boundary" (0,0)
        natural(V) = 0
        LINE TO (R, 0)
        value(V) = -Vsurface/2
        ARC(CENTER=0,0) ANGLE=16
        natural(V) = 0
        ARC(CENTER=0,0) ANGLE=74
        value(V) = 0
        LINE TO CLOSE       

	REGION 2 'skull'
        sigma = sigma_sk
!		sigma = sigma_sc
		START(0, 0)
        LINE TO (rsk, 0)
        ARC(CENTER=0,0) TO (0, rsk)
        LINE TO CLOSE

    REGION 3 'brain'
       sigma = sigma_br
!		sigma = sigma_sc
        START(0,0)
        LINE TO (rbr, 0)
        ARC(CENTER=0,0) TO (0, rbr)
        LINE TO CLOSE
	
    feature 'circ'
            START (R,0) ARC(CENTER=0,0) to (0,R)
	feature
		START 'electrode' (R,0) ARC(CENTER=0,0) ANGLE=16

PLOTS

	CONTOUR(V)	{ contour of the potentials}
	VECTOR(cd) as 'Current density'		{ -sigma*grad(V), instead of sigma*V like in 1D Ohm's law, because in V=IR, V is already the negative gradient of potential }
	{ magnitude(cd) and normal(cd) available }
	
	{ Plots to be exported }

	ELEVATION(V) from (0,0) to (R,0) as 'Potential along x-axis' export file 'pot_along_x.txt' format '#x,#1' noheader		{ Potential along OE }
	ELEVATION(tangential(-grad(V))) from (0,0) to (R,0) as 'Tangential E-field along x-axis' export file 'eField_tan_along_x.txt' format '#x,#1' noheader  { Tangential field along OE }
	ELEVATION(tangential(cd)) from (0,0) to (R,0) as 'Tangential current density along x-axis' export file 'j_tan_along_x.txt' format '#x,#1' noheader {Tangential current density along OE }
	ELEVATION(normal(cd)) from (0,0) to (0,R) as 'Normal current density along y-axis' export file 'j_norm_along_y.txt' format '#y,#1' noheader {Normal current density along OC }
	ELEVATION(normal(cd)) on 'circ' as 'Normal current density along circumference' export file 'j_norm_along_circ.txt' format '#x,#1' noheader REPORT sintegral(normal(cd), 'electrode') as 'Total current'
	
    ELEVATION(normal(cd)) from (0,0) to (R,0) as 'Normal current density along x-axis'
	ELEVATION(tangential(cd)) from (0,0) to (0,R) as 'Tangential current density along y-axis'


{
	ELEVATION(V) from (0,0) to (R,0) as 'Homo Potential along x-axis' export file 'homo_pot_along_x.txt' format '#x,#1' noheader		{ Potential along OE }
	ELEVATION(tangential(-grad(V))) from (0,0) to (R,0) as 'Homo Tangential E-field along x-axis' export file 'homo_eField_tan_along_x.txt' format '#x,#1' noheader  { Tangential field along OE }
	ELEVATION(tangential(cd)) from (0,0) to (R,0) as 'Homo Tangential current density along x-axis' export file 'homo_j_tan_along_x.txt' format '#x,#1' noheader {Tangential current density along OE }
	ELEVATION(normal(cd)) from (0,0) to (0,R) as 'Homo Normal current density along y-axis' export file 'homo_j_norm_along_y.txt' format '#y,#1' noheader {Normal current density along OC }
	ELEVATION(normal(cd)) on 'circ' as 'Homo Normal current density along circumference' export file 'homo_j_norm_along_circ.txt' format '#x,#1' noheader REPORT sintegral(normal(cd), 'electrode') as 'Total current'
}
end
