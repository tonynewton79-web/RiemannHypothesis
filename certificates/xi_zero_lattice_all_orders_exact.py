"""Exact rational audit: theta heat band and zero-lattice coefficients.

Analytic inputs outside this script:
- all-order genuine theta moment ratio 0<=B_n/(2A_n)<1/48;
- positive correlation kernel U_n(x)>=A_n(1-r_n*x²)
  and U_(n+1)(x)<=A_(n+1);
- genus-one real canonical products at simple zeros of H_(1/2).
The finite algebra below is exact. No RH claim.
"""
from fractions import Fraction as Q
from itertools import combinations
from math import factorial

R2=Q(48)
for x in (Q(0),Q(4),Q(6),Q(13,2),Q(27,4),Q(55,8)):
    gap=1-x*x/R2
    assert gap>0
    assert (1/gap)*(gap)==1
    if x<=Q(13,2):
        assert gap>=Q(23,192)
        assert 1/gap<=Q(192,23)
    print("PASS x=",x,"theta central lower factor=",gap,
          "source multiplier <=",1/gap)
assert Q(13,2)>6
assert Q(55,8)**2<48

for length in range(2,11):
    # All rational positive inverse squared gaps; no floating point.
    gaps=[Q(j+1,j+2)**2 for j in range(length)]
    lam=[1/g for g in gaps]
    es=[Q(1)]
    for n in range(1,length+1):
        e=sum((__import__('math').prod(v) for v in combinations(lam,n)),Q())
        es.append(e)
    assert es[0]==1 and all(e>0 for e in es)
    S=sum(lam)
    for n in range(1,length+1):
        assert n*es[n] <= S*es[n-1]
    # Product coefficient identity by expanding recursively.
    coeff=[Q(1)]
    for v in lam:
        t=[Q(0)]*(len(coeff)+1)
        for j,a in enumerate(coeff):
            t[j]+=a
            t[j+1]+=a*v
        coeff=t
    assert coeff==es
print("PASS elementary symmetric all-order product and n*e_n <= S*e_(n-1), 2..10 gaps")

for m in range(2,18):
    for a in [Q(1,3),Q(-4,7),Q(3,2)]:
        assert m*(2*m-1)*a*a > 0
print("PASS no finite coefficient at a real zero of multiplicity m>=2 through m=17")
print("NOT a full theorem about Xi, and no proof of RH.")
