TITLE 'Passive fiber, steady-state solution'

COORDINATES
	cartesian1

VARIABLES
	vm(threshold=10)	{ transmembrane potential}

DEFINITIONS
	len = 0.6		{ cm, fiber half/length}
	ri = 2.6e5		{ kOhm/cm, intr res/length}
	re = 0.8e5	{ kOhm/cm, extr res/length}
	rm = 1.9e3	{ kOhm/cm, mem res/length}
	cm = 1.0	  { uF/cm2, membrane capacitance }
	dur = 0.5     { ms, stimulus duration }
    tmax = 15     { ms, duration of simulation }

	Is = 7.5e-3	{ uA, stimulating current }
	lam = sqrt(rm/(ri+re)) 	{ cm, length constant }
	tau = rm*cm	{ ms, time constant}
	van = -re*lam*Is * sinh(x/lam)/cosh(len/lam)		{ steady-state solution }

INITIAL VALUES
	vm = 0

EQUATIONS
	Div(grad(vm)) - (ri+re)*cm*dt(vm) - ((ri+re)/rm)*vm = 0

BOUNDARIES
	region 1	 { the total domain }
	start(-len) point load(vm)=re*Is*upulse(t, t-dur)
	line to (len) point load(vm)=-re*Is*upulse(t,t-dur)
	{ note: no 'Close'!}

	TIME 0 to tmax
	
	PLOTS
	FOR T=0	BY tmax/20 TO tmax
		elevation(vm,van) from (-len) to (len) as 'vm(x), v_anal(x)'
		report lam as 'lambda'
	HISTORIES
		history(vm) at (-len) (len)
		report tau as 'tau'
	END
