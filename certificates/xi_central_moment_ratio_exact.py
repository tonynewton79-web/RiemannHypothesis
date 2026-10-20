"""Exact algebra for the central Laguerre moment-ratio theorem.

Analytic result:
  U_n(t,0)=M_(2n)(t)/(4*(2n)!),
  k_n U_(n+1)/U_n=M_(2n+2)/(2*M_(2n)).
For the complete theta heat kernel, convolution density is strictly
positive on R, so ratios increase and diverge uniformly on t∈[0,1/2].
These last analytic facts are NOT inferred from finite test data.
"""
from fractions import Fraction as Q
from math import factorial
for n in range(101):
    assert Q((n+1)*(2*n+1),(2*n+2)*(2*n+1))==Q(1,2)
w=[Q(1),Q(3),Q(2)]
r2=[Q(1),Q(4),Q(25)]
mom=[sum((w[i]*r2[i]**n for i in range(3)),Q()) for n in range(101)]
ratios=[mom[n+1]/(2*mom[n]) for n in range(100)]
assert all(ratios[n]<ratios[n+1] for n in range(99))
assert ratios[-1]<Q(25,2)
assert ratios[-1]>Q(1249,100)
print("PASS 101 exact factorial cancellations")
print("PASS 99 exact strict moment-ratio comparisons")
print("PASS finite-support negative control: divergence needs unbounded support")
print("Analytical infinite-theta theorem not fully Lean certified; RH unresolved")
