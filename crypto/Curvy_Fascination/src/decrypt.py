from hashlib import sha256
from Crypto.Cipher import AES

key = input("type/paste key: ").encode()
ciphertext = b'\xe5\x82,\xf4\xae\x10x\xba \xefh\x05\xaa\xd3\xfd\xe6\x9c\x1d\x0e\xbe\x8b\x1d\x86+\x81w\x12\x1c:\x19'
nonce = b'\x13\x14Aro6\xd3Jl/\xdeT7\xfc\x96\xf1'
AESkey = sha256(key).digest()
cipher = AES.new(AESkey, AES.MODE_EAX, nonce=nonce)
plain = cipher.decrypt(ciphertext).decode()
print(plain)
