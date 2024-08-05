from hashlib import sha256
from Crypto.Cipher import AES

key = "632783634760079068257481593728378909226796967090221149792".encode()
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
