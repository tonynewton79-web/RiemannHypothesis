"""Exact finite inverse-gap averaging lower bound.

If a_1<...<a_N lie in an interval of length R, then for every m:
  sum_{i=1}^{N-m} (a_{i+m}-a_i)^(-2) >= (N-m)^3/(m*m*R*R).
Proof: Jensen/Cauchy (positive gaps) and each consecutive gap
appears in at most m length-m increments.

For simple real zeros of the de Bruijn-Newman H_(1/2),
6*L2(a_i)/L1(a_i)=6*sum_{j != i}(a_i-a_j)^(-2).
Hence at some zero in [R,2R]:
  c1(0,a)>=12/(N*R*R) *sum_{m=1}^{N-1}(N-m)^3/m^2.
The known count N~R log R/(4*pi) yields
 limsup c1(0,a)/(log(a)^2) >= 1/8.
This is a NECESSARY lower bound, never a sufficient RH bound.
"""
from fractions import Fraction as Q
from math import gcd

def lower_bound(a):
    N=len(a)
    R=a[-1]-a[0]
    assert N>=2 and R>0
    pair_sum=sum((Q(1,(a[j]-a[i])**2)
        for i in range(N) for j in range(i+1,N)),Q())
    finite_lower=sum((Q((N-m)**3,m*m*R*R)
        for m in range(1,N)),Q())
    assert pair_sum>=finite_lower
    true_average=12*pair_sum/N
    certified_average=12*finite_lower/N
    assert true_average>=certified_average
    # Evaluate every m separately, exactly.
    for m in range(1,N):
        distances=[a[i+m]-a[i] for i in range(N-m)]
        assert sum((Q(1,d*d) for d in distances),Q())>=Q((N-m)**3,m*m*R*R)
    return true_average,certified_average

for N in (4,8,16,32,64):
    a=[Q(i) for i in range(N)]
    actual,lower=lower_bound(a)
    assert actual>=lower
    print("uniform",N,"mean coefficient",float(actual),
          "certified minimum",float(lower))
for N in (8,16,32):
    a=[Q(10*i + ((i*i)%7),10) for i in range(N)]
    assert all(a[i]<a[i+1] for i in range(N-1))
    true,lower=lower_bound(a)
    print("nonuniform",N,"mean",float(true),
          "lower",float(lower))
print("PASS: exact rational pair-sum / Jensen gap bounds.")
print("Research theorem: asymptotic coefficient 1/8 needs known H_1/2 zero-count asymptotic.")
print("NOT a proof of an upper envelope, not RH.")
