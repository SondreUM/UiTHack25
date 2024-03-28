from hashlib import sha256
from Crypto.Cipher import AES
from binascii import *

key = b""
ciphertext = b'\x88\xe7#\xbe\xf5rNW\x13FA}\xb2*\x9a\x11\x8d\xf6\x84\xe2\xcca\x97\xecE,\n\xcct\x00'

nonce = b'~\xa5\x14R>\xaa\x12\xf9/\xa8A\xcf\xf7\xe6|\x08'
AESkey = sha256(key).digest()
cipher = AES.new(AESkey, AES.MODE_EAX, nonce=nonce)
plain = cipher.decrypt(ciphertext).decode()
print(plain)