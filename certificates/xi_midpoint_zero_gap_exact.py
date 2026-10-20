"""Exact rational tests for the adjacent-real-zero midpoint source barrier.

For real-rooted genus≤1 G at midpoint m of two consecutive
simple real zeros a,b with gap g=b-a>0 and G(m)!=0,
  6*L2[G](m)/L1[G](m) >= 12/g².
The lower bound holds independently of all other real zeros.

Use lambda=4/g² (two repeated inverse-square distances),
B=sum(other lambda), E=sum(other pairwise products):
  L1/G²=2lambda+B
  L2/G²=lambda²+2lambda*B+E
so exact surplus is (9lambda*B+6E)/(2lambda+B).

The infinite canonical product transfer remains an analytic
paper theorem, not a machine-checked Lean fact.
"""
from fractions import Fraction as Q
from itertools import combinations

def test(roots,ai,bi):
    a,b=Q(roots[ai]),Q(roots[bi])
    assert a<b and bi==ai+1
    gap=b-a
    m=(a+b)/2
    other=[Q(1)/(m-Q(roots[j]))**2
           for j in range(len(roots)) if j not in (ai,bi)]
    lam=Q(4)/gap**2
    B=sum(other,Q())
    E=sum((other[j]*other[k] for j,k in combinations(range(len(other)),2)),Q())
    L1=2*lam+B
    L2=lam**2+2*lam*B+E
    ratio=6*L2/L1
    lower=Q(12)/gap**2
    assert ratio>=lower
    assert (ratio-lower)*L1 == 9*lam*B+6*E
    return ratio,lower

tests=[([-1,1],0,1),([-1,1,3],0,1),
       ([-10,-3,-2,2,9],2,3),
       ([-7,-3,-1,Q(1,2),1,6,9],3,4)]
for roots,i,j in tests:
    ratio,lower=test(roots,i,j)
    print('PASS midpoint',roots[i],roots[j],
          'R1=',ratio,'min=',lower)
print('PASS exact all-nonnegative-others algebra; no RH result.')
