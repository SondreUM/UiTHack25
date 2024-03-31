from hashlib import sha256
from Crypto.Cipher import AES
from binascii import *

key = "137451353911068132518315417803784679923".encode()
flag = ""
with open("flag.txt", "br") as f:
    flag = f.read().strip()

AESkey = sha256(key).digest()
cipher = AES.new(AESkey, AES.MODE_EAX)
nonce = cipher.nonce
ciphertext, tag = cipher.encrypt_and_digest(flag)
print(f"nonce = {nonce}")
print(f"tag = {tag}")
print(ciphertext)
