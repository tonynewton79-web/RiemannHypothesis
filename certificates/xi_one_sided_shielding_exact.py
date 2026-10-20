"""Exact rational regression: one-sided inverse-square zero-gap shielding.

For g>0 and outward gaps d_L(j), d_R(j):
 [2-g²*S]_+ <= sum_j ((d_L(j)/g-1)_+ +(d_R(j)/g-1)_+)/j².
Finite R: add 2/(R+1) and use weights 1/j²-1/(R+1)².

Only geometry of an ordered real zero set is tested, NOT a
genuine theta-flow estimate and NOT RH.
"""
from fractions import Fraction as Q
from random import Random

def positive(a): return max(Q(0),a)
def phi(x): return 1/(x*(x+1))
def budget(g,left,right,R):
    assert g>0 and R>=1 and len(left)>=R and len(right)>=R
    leftsum=rightsum=Q(0)
    shielding=Q(0)
    for m in range(R):
        leftsum+=left[m]; rightsum+=right[m]
        shielding+=g*g/(leftsum*(leftsum+g))
        shielding+=g*g/(rightsum*(rightsum+g))
    deficit=positive(2-shielding)
    bound=Q(2,R+1)
    for j in range(1,R+1):
        weight=Q(1,j*j)-Q(1,(R+1)**2)
        bound+=weight*(positive(left[j-1]/g-1)+positive(right[j-1]/g-1))
    assert deficit<=bound, (deficit,bound)
    return deficit,bound

for m in range(1,201):
    for h in (Q(0),Q(1,1000),Q(1,7),Q(1),Q(17,3)):
        w=Q(1,m*m)-Q(1,(m+1)**2)
        diff=h*w-(phi(Q(m))-phi(Q(m)+h))
        assert diff>=0
        assert diff*m*m*(m+1)**2*(m+h)*(m+h+1)==h*h*(
             2*h*m+h+3*m*m+3*m+1)
print('PASS 1000 exact convexity/tangent identities')

rng=Random(20261020)
count=0
for _ in range(300):
    g=Q(rng.randint(1,15),rng.randint(2,20))
    left=[Q(rng.randint(1,25),rng.randint(2,25))*g for j in range(35)]
    right=[Q(rng.randint(1,25),rng.randint(2,25))*g for j in range(35)]
    for R in (1,2,4,8,16,32):
        budget(g,left,right,R)
        count+=1
assert count==1800
print('PASS 1800 finite-gap adversarial rational tests')

for j in (1,2,3,8,20,100):
    exact=Q(1,j*(j+1))
    R=10*j
    finite=sum((phi(Q(m))-phi(Q(m+1)) for m in range(j,R+1)),Q())
    assert finite==exact-phi(Q(R+1))
    assert Q(1,j*j)-Q(1,(R+1)**2)+Q(1,(R+1)**2)==Q(1,j*j)
print('PASS sharp doubled-gap formula and optimal first-order weights')

for R in (1,3,5,10,100):
    _,b=budget(Q(1),[Q(1,2)]*R,[Q(3,4)]*R,R)
    assert b==Q(2,R+1)
print('PASS no one-sided penalty for compressed gaps')
print('ALL EXACT TESTS PASS. Theta-specific integrated bound is NOT proved.')
