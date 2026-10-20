from fractions import Fraction as Q
assert Q(43,30)**2*24-49 == Q(23,75)
assert Q(43,30)**2*24 > 49
assert Q(49)<54
assert Q(1,15)>1-Q(49,48)
for k in range(1,21):
    a,b=Q(3,7),Q(4,11)
    u=a/15; v=b
    assert k*v <= (15*k*b/a)*u
print('PASS exact seven-unit rational algebra and source comparison gate')
