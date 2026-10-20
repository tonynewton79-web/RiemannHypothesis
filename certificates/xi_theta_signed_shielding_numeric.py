"""Exploratory genuine theta heat-flow signed defect on first two gaps.

Numerical only, not a rigorous all-height or interval result.
H_t(z)=∫_0∞ exp(tu²) Phi(u) cos(zu) du;
a'(t)=H_t''(a)/H_t'(a);
signed backward-time D=(b-a)*(b'(t)-a'(t))/2.

Six Jacobi square-lattice modes, 36-digit positive-axis quadrature,
and roots near the first three known Xi zero ordinates.
"""
import mpmath as mp
mp.mp.dps=36
Q=[mp.pi*m*m for m in range(1,7)]
segments=[mp.mpf('0'),mp.mpf('.2'),mp.mpf('.45'),mp.mpf('.8'),mp.mpf('1.25'),mp.mpf('1.8')]
def phi(u):
    e=mp.exp(4*u)
    return sum(q*(2*q*e-3)*mp.exp(5*u-q*e) for q in Q)
def H(t,z,k=0):
    trigs=[mp.cos,lambda x:-mp.sin(x),lambda x:-mp.cos(x)]
    return mp.quad(lambda u:mp.exp(t*u*u)*phi(u)*u**k*trigs[k](z*u),segments)
def root(t,g):
    return mp.findroot(lambda z:H(t,z),(g-mp.mpf('.12'),g+mp.mpf('.12')),tol=mp.mpf('1e-29'),verify=False)
initial=list(map(mp.mpf,['28.26945028','42.04407928','50.02171516']))
for tt in ('0','0.25','0.5'):
    t=mp.mpf(tt)
    roots=[root(t,g) for g in initial]
    velocities=[H(t,z,2)/H(t,z,1) for z in roots]
    deficits=[(roots[j+1]-roots[j])*(velocities[j+1]-velocities[j])/2 for j in range(2)]
    assert deficits[0]<0 and deficits[1]>0
    print('t',tt,'g1',mp.nstr(roots[1]-roots[0],18),
          'g2',mp.nstr(roots[2]-roots[1],18),
          'signedD1',mp.nstr(deficits[0],18),
          'signedD2',mp.nstr(deficits[1],18))
print('PASS qualitative first-negative / second-positive theta shielding signs (NUMERICAL ONLY)')
print('No interval certificate or global RH proof.')
