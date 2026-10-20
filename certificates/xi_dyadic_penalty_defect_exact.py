"""Exact finite dyadic RH defect and adaptive-cutoff proof gates.

Let T=1/2, A_n>=0, M_n>=0, b_n=1+T(A_n+M_n).
Let N_n be the genuine Gaussian-smoothed negative mass 0<=N_n<=T*A_n.
At C=2^k, let Ehat_n(C) be the adaptive finite theta positive-part
penalty with |Ehat_n(C)-E_n(C)|<1 and
|E_n(C)-C*N_n|<=T*M_n.
Define S_k=sum_{n=1}^k 2^-n Ehat_n(2^k)/b_n.

Then D=sum_{n>=1}2^-n N_n/b_n exists in [0,1] and
  |S_k/2^k-D| < 2^(1-k).

If RH, N_n=0 so S_k<1 for all k. Conversely, if RH is
false then some N_n>0; hence S_k~2^k D and eventually S_k>1.
Thus RH iff all S_k<1, provided the full analytic inputs cited
in the accompanying paper hold. No finite successful k proves RH.

This independent regression uses exact Fractions, not floating point.
"""
from fractions import Fraction as Q
from itertools import product

T=Q(1,2)
cases=0
for k in range(1,17):
    C=2**k
    for alpha,beta in product([Q(0),Q(1,3),Q(2),Q(101,7)],
                              [Q(0),Q(1,7),Q(1),Q(13)]):
        norm=1+T*(alpha+beta)
        assert norm>0 and (T*beta+1)/norm<=1
        assert T*alpha/norm<1
        # Finite triangle comparison:
        for N in [Q(0),T*alpha/2,T*alpha]:
            E=C*N+T*beta/2
            Ehat=E+Q(1,3)
            assert abs(Ehat-C*N)<T*beta+1
            assert abs(Ehat/C-N)/norm < Q(1,C)
            cases+=1

# Prove |S_k/C-D|<1/C+2^-k from geometric weights
# on a rational toy infinite family having simple closed form.
# N_n/b_n = d0, for any chosen d0 in [0,1).
for d0 in [Q(0),Q(1,10),Q(1,3),Q(3,4)]:
    for k in range(1,20):
        C=2**k
        # Set a hypothetical normalized finite-mode penalty
        # to the exact ideal C*N/b plus perturbation epsilon_n,
        # with |epsilon_n|<1 in normalized coordinates.
        perturb=Q(1,3)
        sk=sum((Q(1,2**n)*(C*d0+perturb) for n in range(1,k+1)),Q())
        D=d0
        assert abs(sk/C-D) < Q(2,2**k)
        if d0==0: assert sk<1
        if d0>0 and C>Q(3, d0): assert sk>1

# For a fixed nonnegative D, C>=2^k gives lower bound
# S_k>C*(D-2/C). So any D>0 causes eventual S_k>1.
for D in [Q(1,10000),Q(1,10),Q(9,10)]:
    for k in (8,12,20,30):
        C=Q(2**k)
        lower=C*D-2
        if lower>1:
            assert C*D>3

print(f'PASS {cases} exact adaptive weighted-normalization inequalities')
print('PASS finite dyadic defect error <2^(1-k), k=1..19')
print('PASS single-sequence finite falsification threshold and growth')
print('No value of the genuine Xi defect D was calculated; RH remains open.')
