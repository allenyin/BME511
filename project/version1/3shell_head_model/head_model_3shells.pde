TITLE 
    'Head Model - 3 concentric spheres'

COORDINATES
    cartesian3

VARIABLES
    V

DEFINITIONS
    sigma_br = 4.5   { mS/cm }
	sigma_sk = 0.056
	sigma_sc = 4.5
	sigma = sigma_br
    R_sc = 9.2       { Scalp radius, cm }
	R_sk = 8.5
	R_br = 8
    r = sqrt(x^2+y^2)	
	{ electrode positions }
	{ Fc1 }
	x_Fc1 = 3.511
	y_Fc1 = 3.502
	{ Fc2 }
	x_Fc2 = 3.511
	y_Fc2 = -3.502
	{ Cp1 }
	x_Cp1 = -3.510
	y_Cp1 = 3.502
	{ Cp2 }
	x_Cp2 = -3.510
	y_Cp2 = -3.502
	{ C3 }
	x_C3 = 0
	y_C3 = 6.837
	{ C4 }
	x_C4 = 0
	y_C4 = -6.837
	{ electrode location }
	x_e1 = x_C3
	y_e1 = y_C3
	x_e2 = x_C4
	y_e2 = y_C4
	x_g = (x_e1+x_e2)/2
	y_g = (y_e1+y_e2)/2
	{ electrode patch radius }
	r_e = 0.5	 { 1cm diameter electrode }

EQUATIONS
    div(-sigma*grad(V)) = 0

EXTRUSION
    { z from low to high }
    surface 'SB1' z = -SPHERE ((0,0,0), R_sc)      { bottom of scalp shell }
        layer 'LB1'
	surface 'SB2' z = -SPHERE ((0,0,0), R_sk)
		layer 'LB2'
	surface 'SB3' z = -SPHERE ((0,0,0), R_br)
		layer 'L3'
	surface 'ST3' z = SPHERE ((0,0,0), R_br)
		layer 'LT2'
	surface 'ST2' z = SPHERE ((0,0,0), R_sk)
		layer 'LT1'
    surface 'ST1' z = SPHERE ((0,0,0), R_sc)

BOUNDARIES
    
    surface 'ST1' natural(V) = 0
    surface 'SB1' natural(V) = 0
	
	Region 1
		layer 'LT1' sigma=sigma_sc
		layer 'LB1' sigma=sigma_sc
		start(R_sc, 0)
		arc(center=0,0) angle=360
		line to close

{ Electrode 1 }
	Limited Region  'ELECTRODE1'
		surface 'ST1'
		natural(V) = 1/(PI*(r_e^2))
 		start(x_e1, y_e1+r_e) arc(center=x_e1, y_e1) ANGLE=360 
		line to close

{ Electrode 2 }
	Limited Region 'ELECTRODE2'
		surface 'ST1'
		natural(V) = -1/(PI*(r_e^2))
		start(x_e2, y_e2+r_e) arc(center=x_e2, y_e2) ANGLE=360 
		LINE TO CLOSE


{ 'Ground electrode' }
	Limited Region 3 { arbitrary ground point as a test }
		{ Ground voltage value between the electrodes }
		surface 'ST1'
		value(V) = 0
		start(x_g, y_g+r_e) arc(center=x_g, y_g) ANGLE=360	{Ground}
		line to close

	Limited Region 4 { the skull region }
		layer 'LT2' sigma = sigma_sk
		layer 'LB2' sigma = sigma_sk
			! region in all layers that must merge out:
			layer 'L3'
		start(R_sk, 0) arc(center=0, 0) ANGLE=360
		line to close

	Limited Region 5 { the brain region }
		layer 'L3' sigma = sigma_br
		start(R_br, 0) arc(center=0,0) ANGLE=360
		line to close


PLOTS
	grid(x,y,z)
	contour(V) on x=0 as 'Potentail on YZ plane through diameter'
	contour(V) on y=0 	as 'Potential on XZ plane through diameter'
	contour(V) on z=0	as 'Potential on XY plane through diameter'
	contour(V) on SURFACE 'ST1'
	!elevation(V) on y=0 on SURFACE 'ST1' as 'Potential along y=0 on top surface'
	elevation(V) FROM (0, R_sc) to (0, -R_sc) on SURFACE 'ST1' as 'Potential along x=0 on top surface'
	vector(dx(V), dz(V)) on y=0 as '(dx, dz) on XZ plane at y=0'


	vector(dx(V), dy(V)) on z=2.8284 as '(dx, dy) on XY plane at z=2.8284'
{	contour(dy(V)) on z=2.8284 as 'dV/dy on XY plane at z=2.8284' 
	contour(dz(V)) on z=2.8284 as 'dV/dz on XY plane at z=2.8284'

	contour(dx(V)) on z=-2.8284 as 'dV/dx on XY plane at z=-2.8284'
	contour(dy(V)) on z=-2.8284 as 'dV/dy on XY plane at z=-2.8284'
	contour(dz(V)) on z=-2.8284 as 'dV/dz on XY plane at z=-2.8284' 
}

	{ export top dipoles data }
	elevation(dx(V)) FROM (-2, 2) to (2, -2) on z=2.8284 as 'dV/dx FROM (-2, 2) to (2, -2) on z=2.8284' export (20) file='Pair13_dx_z=2_8284.txt' format '#x, #y, #1'
	elevation(dy(V)) FROM (-2, 2) to (2, -2) on z=2.8284 as 'dV/dy FROM (-2, 2) to (2, -2) on z=2.8284' export (20) file='Pair13_dy_z=2_8284.txt' format '#x, #y, #1'
	elevation(dz(V)) FROM (-2, 2) to (2, -2) on z=2.8284 as 'dV/dz FROM (-2, 2) to (2, -2) on z=2.8284' export (20) file='Pair13_dz_z=2_8284.txt' format '#x, #y, #1'

	elevation(dx(V)) FROM (-2, -2) to (2, 2) on z=-2.8284 as 'dV/dx FROM (-2, -2) to (2, 2) on z=2.8284' export (20) file='Pair13_dx_z=-2_8284.txt' format '#x, #y, #1'
	elevation(dy(V)) FROM (-2, -2) to (2, 2) on z=-2.8284 as 'dV/dy FROM (-2, -2) to (2, 2) on z=2.8284' export (20) file='Pair13_dy_z=-2_8284.txt' format '#x, #y, #1'
	elevation(dz(V)) FROM (-2, -2) to (2, 2) on z=-2.8284 as 'dV/dz FROM (-2, -2) to (2, 2) on z=2.8284' export (20) file='Pair13_dz_z=-2_8284.txt' format '#x, #y, #1'
	
end