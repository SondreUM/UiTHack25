import time
import random
import string

if __name__ == '__main__':
    seed = time.time() // 86400
    key_len = 24
    random.seed(seed)
    key = random.choices(string.ascii_letters + string.digits, k=key_len)
    key = ''.join(key)
    print(key)