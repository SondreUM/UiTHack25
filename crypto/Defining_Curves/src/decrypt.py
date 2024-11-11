from hashlib import sha256
from Crypto.Cipher import AES

key = input("type/paste key: ").encode()
ciphertext = b'"t\xdd\xfb\x1b\xdds\xf5\x81\'\xf6@\xcbF\xcd\xff\x1e\xaa\xa93\x9e\rx{?\x18K\r\x11~\xca]X'

nonce = b'.\x00\x91\x9c]\xc0\xe4+f=\xa4\x90\xfd\x0b&\xb5'
AESkey = sha256(key).digest()
cipher = AES.new(AESkey, AES.MODE_EAX, nonce=nonce)
plain = cipher.decrypt(ciphertext).decode()
print(plain)
