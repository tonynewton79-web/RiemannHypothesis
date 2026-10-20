"""Exact finite-rectangle transfer gates for the actual theta heat flow.

If |U_n-U_nM|<=E_n and |U_(n+1)-U_(n+1)M|<=E_(n+1),
and 0<=c<=C_R on K, then the true source defect
k*U_(n+1)-c*U_n is at most the finite-mode defect plus
k*E_(n+1)+C_R*E_n. This is valid independently of
the sign of U_n.

The analytic bounds in paper/theta_heat_specific_tail.tex give
E_n <= [3(2n+1)C_*/(2*4^(2n))] q*exp(-q+1/16)
for H_t=F_t/2, q=pi(M+1)^2. A crude prior-work
theta tail majorant yields C_*<100 (this loose constant is
used as a safe rational proxy, not an optimized bound).

The script checks the exact interval transfer for rational
test cases and a chosen explicit exponential-polynomial majorant.
It does not establish a finite-mode negative defect margin for the
true Jacobi kernel on every rectangle; that missing certificate is
the RH-critical step.
"""
from fractions import Fraction as F
from math import factorial

# Analytic C_* envelope: m=1 < 38, m>=2 < 48.
m1=16*(F(1,2)+F(3,4)+F(6,8)+F(6,16))
assert m1==38 and m1+48<100
print("PASS first-mode and geometric tail rational envelope: C_*<100")

def theta_error_coefficient(n):
    return F(3*(2*n+1)*100,2*4**(2*n))

for n in range(1,101):
    assert theta_error_coefficient(n)>0
    assert theta_error_coefficient(n+1)<theta_error_coefficient(n)

# q >= 3*(M+1)^2; e^{-q+1/16} <= e^{-(3*(M+1)^2-1/16)}.
# Positive Taylor series lower bounds exp(x), giving an upper
# bound for the exponential without floating-point decisions.
def exp_minus_upper(x,order=36):
    assert x>0
    t=sum((x**k/F(factorial(k)) for k in range(order+1)),F(0))
    return F(1,t)

for M in (1,2,3,5,10):
    qlo=F(3*(M+1)**2)
    qhi=F(22*(M+1)**2,7)
    exponential=exp_minus_upper(qlo-F(1,16))
    common=qhi*exponential
    for n in (1,2,5,10):
        en=theta_error_coefficient(n)*common
        ennext=theta_error_coefficient(n+1)*common
        for C_R in (F(1), F(100), F(10000)):
            k=(n+1)*(2*n+1)
            threshold=k*ennext+C_R*en
            # A finite-mode strict certificate must beat this
            # exact threshold. This test verifies the transfer algebra.
            U_M=F(17,31)
            U=U_M-en
            V_M=-threshold+F(3,7)*U_M
            V=V_M+k*ennext
            c=F(3,7)
            assert 0<=c<=C_R
            assert V_M-c*U_M<=-threshold
            assert V<=c*U
    print("PASS M=",M,"exact rational theta-error transfer coefficients")

# Unavoidable odd-order false finite-mode signal:
# for any c>=0 and Uodd<0<Veven, the comparison fails.
for c in (F(0),F(3,5),F(1000)):
    Uodd=-F(1,1000000)
    Veven=F(1,10**12)
    assert Veven>c*Uodd
print("PASS odd-order asymptotic finite-cutoff global comparison obstruction")
print("RH NOT proved. Finite-mode negative margin certificates are missing.")
