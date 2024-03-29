if __name__ == "__main__":
    # y^2 = (x^3 + ax + b) % p
    p = 79228162514264337593543950397
    a = 53733592243402496449468535509
    P = (8531568884526597726104480015, 3965280560779306635737009839)

    # b = (y^2 - (x^3 + ax)) % p
    b = (P[1] ** 2 - (P[0] ** 3 + a * P[0])) % p
    print(b)