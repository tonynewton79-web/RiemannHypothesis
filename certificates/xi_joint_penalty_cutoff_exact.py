"""Joint theta cutoff / Duhamel penalty exact arithmetic checkpoints.

For fixed n, the theta heat-tail bound in paper/theta_heat_specific_tail.tex
implies |mathcalE_C^M(T,0)-mathcalE_C(T,0)|
 <= T*C*D_n*q*exp(-q+1/16).

For q>=12, q*exp(-q)<=exp(-q/2).
Choose q>=2*log(exp(1/16)*(1+C)*(1+T*D_n));
then the penalty difference is STRICTLY BELOW 1.

This verifies the rational last-step comparisons and tests
the adaptive mode scaling numerically. The theta infinite sums,
exponential inequalities and the sought bounded penalty for RH
are not proved by these tests.
"""
from fractions import Fraction as Q
from itertools import product
from math import ceil, log, exp, sqrt, pi

checks=0
for T,C,D in product((Q(0),Q(1,8),Q(1,4),Q(1,2)),
                     (Q(1),Q(2),Q(11),Q(1000),Q(10**6)),
                     (Q(0),Q(1,100),Q(1),Q(999),Q(10**8))):
    denom=(1+C)*(1+T*D)
    assert denom-T*C*D==1+C+T*D>0
    eps=1/denom
    assert T*C*D*eps<1
    for d in (Q(0),Q(1,2),Q(1)):
        assert T*C*D*(d*eps)<1
    checks+=1
print(f"PASS {checks} exact adaptive penalty ratio cases")

# Numerically explore the explicit least-M rule,
# purely to verify expected O(sqrt(log C)) scaling.
# High-precision theta tail constants remain symbolic in the proof.
for n in [1,2,5,20,50]:
    # Illustrative positive D_n, not a proven evaluation of the
    # genuine theta moment-majorant C_* for this demonstration.
    D=1+n*n
    last=0
    for C in [1,10,10**3,10**6,10**12]:
        threshold=max(12,2*log(exp(1/16)*(1+C)*(1+0.5*D)))
        M=max(1,ceil(sqrt(threshold/pi)-1))
        q=pi*(M+1)**2
        assert q+1e-12>=threshold
        error=0.5*C*D*q*exp(-q+1/16)
        assert error<1
        last=M
    print(f"CHECK scaling n={n} max tested cutoff M={last}")
print("PASS exact finite gates and numerical parameter scaling.")
print("The global theta central penalty bound remains unproved; RH OPEN.")
