def gcd(x, y):
    if y == 0:
        return x
    else:
        return gcd(y, x % y)

def coPrime(x, y):
    if gcd(x, y) == 0:
        return True
    else:
        return False

def totienthPhi(m):