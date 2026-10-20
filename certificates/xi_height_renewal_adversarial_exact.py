"""Height-adaptive contour-renewal stress test. Exact rational arithmetic.

This is NOT a counterexample to RH. It constructs even quartic solutions
of the SAME backward heat equation as the Riemann theta deformation,
whose real zeros collide at arbitrarily high position after an
arbitrarily short backward-time step.

A separate analytic Hurwitz/Rouche result: if an entire H_t has only
real zeros for a SEQUENCE of positive times t_j -> 0, and H_t -> H_0
locally uniformly, then H_0 has only real zeros. The terminal closure
does not require a further no-escape-from-infinity theorem.
"""
from fractions import Fraction as Q
import sympy as sp
z,A,e,s=sp.symbols('z A e s',real=True)
S=(A+e)**2+(A+2*e)**2
P=(A+e)**2*(A+2*e)**2
F=z**4+(12*s-S)*z**2+P-2*S*s+12*s**2
assert sp.expand(F.subs(s,0)-(z**2-(A+e)**2)*(z**2-(A+2*e)**2))==0
assert sp.expand(sp.diff(F,s)-sp.diff(F,z,2))==0
Delta=sp.expand((12*s-S)**2-4*(P-2*S*s+12*s**2))
assert sp.expand(Delta-((2*A*e+3*e**2)**2-16*S*s+96*s**2))==0
assert sp.expand(Delta.subs(s,e**2)-e**2*(-28*A*A-84*A*e+25*e*e))==0
assert sp.factor(S-12*e**2-A**2)==(A-e)*(A+7*e)
print('PASS exact symbolic even-quartic backward-heat PDE and discriminant')
for AA in [Q(1),Q(2),Q(10),Q(101),Q(10**6)]:
    for EE in [Q(1,10**5),Q(1,100),Q(1,2),AA]:
        if EE>AA:continue
        SS=(AA+EE)**2+(AA+2*EE)**2
        PP=(AA+EE)**2*(AA+2*EE)**2
        DD=lambda h:(12*h-SS)**2-4*(PP-2*SS*h+12*h*h)
        assert DD(0)>0 and DD(EE**2)<0
        assert SS-12*EE**2>=AA**2
        for Z in [Q(0),Q(1),AA,AA+EE,AA+2*EE,2*AA]:
            h=EE**2
            val=Z**4+(12*h-SS)*Z**2+PP-2*SS*h+12*h*h
            assert val==(Z**2+(12*h-SS)/2)**2-DD(h)/4
            assert val>0
print('PASS 20 exact rational scale cases and independent square-completion replay')
for R,delta in [(Q(1),Q(1,100)),(Q(100),Q(1,10**6)),
                (Q(10**7),Q(1,10**20)),(Q(10**30),Q(1,10**70))]:
    AA=4*(R+1); EE=delta/(1+delta)
    assert AA>=EE>0 and EE**2<delta and AA**2/2>R**2
    SS=(AA+EE)**2+(AA+2*EE)**2
    assert (2*AA*EE+3*EE**2)**2>0
    assert EE**2*(-28*AA**2-84*AA*EE+25*EE**2)<0
print('PASS arbitrary-height and arbitrary-short-time target gates')
print('MATHEMATICAL BOUNDARY: terminal Hurwitz closure is analytic, not a Lean theorem here.')
print('RIEMANN HYPOTHESIS NOT PROVED.')
