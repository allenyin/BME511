
{ lab: 1-d bidomain, FN AP }

title
  '1-d bidomain: FN membrane'	

coordinates
  cartesian1

variables
  Vm(threshold=10)	{ transmembrane potential }
  n(threshold=0.1)  { gating variable }

definitions
  len = 0.6	{ cm, half-length of the fiber }

  gi = 1.1	{ mS/cm, intracellular conductivity }
  ge = 3.6	{ mS/cm, extracellular conductivity }
  Rm = 8.9	{ kOhm.cm2, membrane resistance }
  Cm = 1.0	{ uF/cm2, membrane capacitance }
  bet = 1333	{ 1/cm, surface to volume ratio, a=20 um, Ae=30% A }
  h = 1.8e-3    { cm, fiber unit cell }
  gp = gi*ge/(gi+ge)	{ intr and extr conductivities in parallel }

  G1 = 40         { mS/cm2, FN conductance }
  G2 = 35         { mS/cm2, FN conductance }
  va = 1.5        { mV, activation threshold }
  vna = 112       { mV, reversal potential }
  taun = 10       { ms, slow time constant }

  js = 2500 	 { uA/cm^2, applied current density }
  dur = 0.5      { ms, stimulus duration }
  tmax = 10      { ms, duration of simulation }
  
Initial Values
  Vm = 0
  n = 0

equations
  Vm:	del2(Vm) - (bet/gp)*Cm*dt(Vm) - (bet/gp) * (G1*Vm*(Vm-va)*(Vm-vna)/(vna*vna) + G1*vna*n) = 0
  n: dt(n) = (G2*Vm)/((G1*vna)*taun) - (1/taun)*n

boundaries
  region 1 'fiber'	{ over entire model }
    start(-len)     point load(vm)=(js/ge)*upulse(t,t-dur)
    line to (len)   point load(vm)=-(js/ge)*upulse(t,t-dur)
    { note: no 'Close'! }
  feature 'pathx'	{ path along the fiber }
    start (-len) line to (len)

Time 0 to tmax

Plots 
For T = 0 by tmax/20 to tmax
  elevation(Vm) on 'pathx' as 'Vm between electrodes' report gp
  
Histories
  history(vm) at (0,0) as 'Transm potential vs time'
end

