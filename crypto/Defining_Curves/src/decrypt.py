from hashlib import sha256
from Crypto.Cipher import AES

key = input("type/paste key: ").encode()
ciphertext = b'\xee\x0e=\xd1T\xe9}\xec\x11A\n\xf2\xb8\x13\x06\x08[{\x05L\xceC\t-g\x83\xc1iJ\xc6\x1eDW'

nonce = b'\xdc-A\x8b\x00r\xe3\x9d\x92`\x9bKE\xa3\x0b-'
AESkey = sha256(key).digest()
cipher = AES.new(AESkey, AES.MODE_EAX, nonce=nonce)
plain = cipher.decrypt(ciphertext).decode()
print(plain)
