title
  'bidomain: FN model time-dependent'	{ will be printed on all graphs }

variables
  Vm	(threshold=10)
  gv(threshold=1)	{ gating variable }


definitions
  len = 0.6	{ cm, half length of the strip }
  w = 0.1	{ cm, width and electrode dimension }
  js = 2000 	{ uA/cm^2, applied current density }

  gi = 1.1	{ mS/cm, intracellular conductivity }
  ge = 3.6	{ mS/cm, extracellular conductivity }
  Rm = 8.9	{ kOhm.cm2, membrane resistance }
  bet = 1333	{ 1/cm, surface to volume ratio, a=20 um, Ae=30% A }
  gp = gi*ge/(gi+ge)	{ intr and extr conductivity in parallel }

  { not used in the steady-state solutions }
  Cm = 1.0	  { uF/cm2, membrane capacitance }
  G1 = 40       { mS/cm2, FN conductance }
  G2 = 35       { mS/cm2, FN conductance }
  va = 1.5      { mV, activation threshold }
  vna = 112     { mV, reversal potentials }
  tauy = 10     { ms, slow time constant }
  dur = 0.5     { ms, stimulus duration }
  tmax = 15     { ms, duration of simulation }
  d = 0.1       { cm, distance from the tissue }
  sig0 = 20	  { mS/cm, outside conductivity }
  h = 1.8e-3    { cm, tissue thickness }
  rinv = 1/sqrt(x^2+y^2+d^2)
  phi0 = -gp/(4*pi*sig0)*integral(dot(grad(Vm), grad(rinv)))*h

initial values
Vm = 0
gv = 0
  
equations
  {Vm:	del2(Vm) - gp*bet * Vm/Rm = 0}
  Vm: del2(Vm) - gp*bet*(Cm*dt(Vm)+G1/vna^2*Vm*(Vm-va)*(Vm-vna)+G1*vna*gv) = 0
  { Vm: Cm*dt(Vm) = -G1/vna^2*Vm*(Vm-va)*(Vm-vna)-G1*vna*gv+js }
  gv: dt(gv) = (G2*Vm)/((G1*vna)*tauy) - (1/tauy)*gv

boundaries
	region 1 'model' { over entire model }
		start (0,0)
		natural(Vm) = 0
		line to (len, 0)
		natural(Vm) = -js/ge*upulse(t, t-dur)
		line to (len,w)
		natural(Vm) = 0
		line to (len, len)
		natural(Vm) = 0
		line to (-len, len)
		natural(Vm) = 0 
		line to (-len, w)
		natural(Vm) = js/ge*upulse(t, t-dur)
		line to (-len, 0)
		natural(Vm) = 0
		line to close

  feature 'pathx'	{ path between electrodes }
    start (-len,0) line to (len,0)

TIME 0 TO tmax

plots
  for T=0 by tmax/20 to tmax
      contour(Vm) as 'Transmembrane potential everywhere'
	  elevation(Vm) on 'pathx' as 'Vm between electrodes'
   HISTORIES
	{	history(Vm) at (-len,0) (len,0) as 'Vm(t) at electrodes'}
		history(Vm) at (0,0) as 'Vm(t) at (0,0)'
        history(phi0) as 'phi0(t)'
end
