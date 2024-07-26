from hashlib import sha256
from Crypto.Cipher import AES
from binascii import *

key = "8076851309726935292348958409867".encode()
flag = ""
with open("flag.txt", "br") as f:
    flag = f.read().strip()

AESkey = sha256(key).digest()
cipher = AES.new(AESkey, AES.MODE_EAX)
nonce = cipher.nonce
ciphertext, tag = cipher.encrypt_and_digest(flag)
flag = str(ciphertext)[2:-1]
with open("flag.enc.txt", "w") as f:
    f.write(flag)
print(f"nonce = {nonce}")
print(f"tag = {tag}")
print(ciphertext)
