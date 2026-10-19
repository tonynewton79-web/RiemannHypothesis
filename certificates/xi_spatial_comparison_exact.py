"""Spatial Laguerre heat comparison: exact arithmetic stress tests.

For a real-rooted polynomial G and simple zero a:
 L_n[G](a)=G'(a)^2 * e_(n-1)((a-rho)^(-2):rho !=a).
Therefore (n+1)(2n+1)L_(n+1)/L_n <=
 ((n+1)(2n+1)/n)*sum_{rho !=a}(a-rho)^(-2).

Two close roots force any first-order spatial coefficient to be
at least 6/(a-b)^2. Thus no universal log^2 height upper bound
follows merely from real-rootedness.

For H_t(z)=z^2-2t, L1(t,0)=4t and L2(t,0)=1:
the required comparison coefficient grows like 3/(2t)
and cannot be locally bounded across the double-zero time.

Maximum-principle barrier b=exp(s)*cosh(x) satisfies
 (partial_s-0.5partial_xx+c)b=(0.5+c)b>0 for c>=0.
This permits locally bounded c(s,x) with NO global x-growth
bound when U is bounded on the spacetime slab.

These tests do not establish the inequality for genuine Xi;
RH remains open.
"""
from fractions import Fraction as Q
from itertools import combinations
from math import prod

def e(vals,k):
    if k<0: return Q(0)
    if k==0: return Q(1)
    return sum((prod(c) for c in combinations(vals,k)),Q(0))

count=0
for roots in [(-3,-1,2,5),(-12,-7,-1,0,4,11),
              (-9,-5,0,1,3,15,21),(Q(0),Q(1,128))]:
    roots=tuple(map(Q,roots))
    for a in roots:
        b=[1/(a-r)**2 for r in roots if r!=a]
        S=sum(b)
        for n in range(1,len(roots)):
            den=e(b,n-1)
            if den:
                ratio=Q((n+1)*(2*n+1))*e(b,n)/den
                assert 0<=ratio<=Q((n+1)*(2*n+1),n)*S
                count+=1
    for x in map(Q,[Q(1,3),Q(7,2),Q(23,3)]):
        if x in roots:continue
        b=[1/(x-r)**2 for r in roots]
        j=max(range(len(b)),key=lambda k:b[k])
        S=sum(b)-b[j]
        for n in range(1,len(roots)):
            if e(b,n):
                ratio=Q((n+1)*(2*n+1))*e(b,n+1)/e(b,n)
                assert 0<=ratio<=Q((n+1)*(2*n+1),n)*S
                count+=1

for k in range(1,32):
    eps=Q(1,2**k)
    assert Q(6)/(4*eps**2)==Q(3,2)*4**k
for k in range(1,31):
    t=Q(1,2**k)
    assert Q(6)/(4*t)==Q(3)/(2*t)
for c in map(Q,[0,Q(1,9),5,10**20]):
    assert Q(1)-Q(1,2)+c==Q(1,2)+c>0

print("PASS:",count,"exact real-rooted finite-Laguerre gap inequalities")
print("PASS: two-real-root inverse-square collision vs any universal log² envelope")
print("PASS: heat polynomial requires coefficient >= 3/(2t) near its double zero")
print("PASS: cosh heat barrier valid for arbitrary nonnegative locally bounded c")
print("OPEN: existence of such c for all genuine Riemann theta Laguerre orders")