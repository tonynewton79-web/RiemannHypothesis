"""Exact signed shielding endpoint audit; RH remains open.

The signed budget 4*int(D)<G0 is algebraically equivalent to G(s)>0
when G'=-4D. Strict positivity through s=1/2 additionally implies
endpoint simplicity; RH alone permits multiple critical-line zeros.

Adversarial polynomial heat flow:
p_s(z)=exp(s*d²/dz²)[(z²-1)(z²-4)]
      =z⁴+(12s-5)z²+12s²-10s+4.
The two positive real zeros collide at
s*=(10-sqrt(46))/24 in (1/8,1/7), strictly before 1/2.
Initial gap is 1, exterior shielding 1/4, signed defect 7/4,
and 4*int_0^s* D=1 exactly at collision.
This is NOT the Riemann theta flow and does NOT prove RH.
"""
from fractions import Fraction as F
from decimal import Decimal, getcontext
from random import Random
rng=Random(321014)
for _ in range(2000):
    s=F(rng.randrange(100),rng.randrange(101,1000))
    z=F(rng.randrange(-40,41),rng.randrange(1,21))
    p0=(z*z-1)*(z*z-4)
    ps=z**4+(12*s-5)*z*z+12*s*s-10*s+4
    assert ps==p0+s*(12*z*z-10)+12*s*s
    A=5-12*s;B=12*s*s-10*s+4
    assert A*A-4*B==96*s*s-80*s+9
print("PASS 2000 exact quartic heat polynomial/discriminant identities")
def disc(s):return 96*s*s-80*s+9
assert disc(F(0))==9 and disc(F(1,8))>0 and disc(F(1,7))<0
assert 5-12*F(1,7)>0 and 4-10*F(1,7)>0
assert 192*F(1,7)-80<0 and F(1,7)<F(1,2)
shield=F(1,2*3)+F(1,3*4)
assert shield==F(1,4) and 2-shield==F(7,4) and -4*(2-shield)==-7
print("PASS rational collision bracket (1/8,1/7) and initial shielding S=1/4")
for _ in range(1000):
    g0=F(rng.randrange(1,500),rng.randrange(1,100))
    I=F(rng.randrange(-100,600),rng.randrange(1,200))
    gs=g0-4*I
    assert (4*I<g0)==(gs>0)
    assert (4*I<=g0)==(gs>=0)
print("PASS 1000 exact budget <=> endpoint gap identities")
getcontext().prec=70
tau=(Decimal(10)-Decimal(46).sqrt())/Decimal(24)
def B(s):return Decimal(12)*s*s-Decimal(10)*s+4
def G(s):return Decimal(5)-Decimal(12)*s-2*B(s).sqrt()
def D(s):return (Decimal(12)+(Decimal(24)*s-10)/B(s).sqrt())/4
assert Decimal(1)/8<tau<Decimal(1)/7
assert abs(G(tau))<Decimal("1e-62")
assert D(Decimal(0))==Decimal(7)/4
assert abs(D(tau)-2)<Decimal("1e-62")
N=4000;h=tau/N
I=h*(D(Decimal(0))+D(tau))/3
for k in range(1,N):
    I+=h*(4 if k%2 else 2)*D(h*k)/3
assert abs(I-Decimal(1)/4)<Decimal("0.0000000005")
print("PASS 70-digit quartic collision and diagnostic signed-integral replay")
print("OPEN: independent theta-specific integrated deficit envelope and global completeness.")
