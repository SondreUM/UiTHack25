from hashlib import sha256
from Crypto.Cipher import AES
from binascii import *

key = b"22514939140182650645646535879"
ciphertext = b'\tb,\xe6\xbd\x95\x83\x91\xa9\xc3\t\xb2\x9eg\xed\x81\x02O\x83\xce\x11\xdf\x07\xceV\xf7\xd9\xe7\x82\xa6\\\xee\xbd'

nonce = b'\xaaw\x1d\xe3\x10)\x05K\xb6\xab\x7f{R\x8e\xcc\xd9'
AESkey = sha256(key).digest()
cipher = AES.new(AESkey, AES.MODE_EAX, nonce=nonce)
plain = cipher.decrypt(ciphertext).decode()
print(plain)