import gnupg
import random
import string

def gen_key(seed):
    key_len = 24
    random.seed(seed)
    key = random.choices(string.ascii_letters + string.digits, k=key_len)
    key = ''.join(key)
    return key

def gen_wordlist():
    # Generate wordlist of keys from the last 100 days
    with open('wordlist.txt', 'w') as wordlist:
        for i in range(20050, 20150):
            seed = i
            key = gen_key(seed)
            wordlist.write(key + '\n')

def crack_key():
    # use gnupg to decrypt flag.txt.gpg with keys from wordlist.txt
    with open('wordlist.txt', 'r') as wordlist:
        keys = wordlist.readlines()
        for key in keys:
            gpg = gnupg.GPG()
            gpg.decrypt_file('flag.txt.gpg', passphrase=key, output='flag.txt')
            try:
                with open('flag.txt', 'r') as flag:
                    flag = flag.read()
                    print(flag)
            except:
                print(i)
                continue
            exit()

if __name__ == '__main__':
    gen_wordlist()
    crack_key()
            