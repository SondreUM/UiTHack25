from hashlib import sha256
from Crypto.Cipher import AES
from binascii import *

key = b""
ciphertext = b'&\x9dRH\xd9p\xb7\x0c&\xe30\xa7\t\xccYEBt\x80\xf7K\xd7Fq\xd3\xc8"\x066\xfa'

nonce = b'\xe2Y\x16A\xde\xb5\x0f\x8d\xca\xc8\x03q\xbe\xfcg4'
AESkey = sha256(key).digest()
cipher = AES.new(AESkey, AES.MODE_EAX, nonce=nonce)
plain = cipher.decrypt(ciphertext).decode()
print(plain)