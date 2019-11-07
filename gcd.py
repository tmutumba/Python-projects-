def gcd(x, y):
    if y == 0:
        return abs(x)
    else:
        return gcd(y, x % y)
print(gcd(2, 3))