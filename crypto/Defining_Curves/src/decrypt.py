from hashlib import sha256
from Crypto.Cipher import AES
from binascii import *

key = input("key: ").encode()
ciphertext = b'W\xc7\xd2\x8e\xc0\x9d\x1bYi}\x19\xbf\xa6\xb9l\xf7\xae\x9f\x89,]\x8e\xc3\xd7\x17\xa41\xb2\xa4\xe9z\xb6\xbd'

nonce = b'J\x06g\xf1\x97\xb1\x92G\x03\x86\x85\xf6i\x1c\xe0\x88'
AESkey = sha256(key).digest()
cipher = AES.new(AESkey, AES.MODE_EAX, nonce=nonce)
plain = cipher.decrypt(ciphertext).decode()
print(plain)
