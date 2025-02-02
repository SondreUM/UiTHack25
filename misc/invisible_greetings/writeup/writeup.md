hcxpcapngtool -o hash.txt dump.pcapng
hashcat -a 3 -w4 -m 22000 hash.txt /home/nikolai/Downloads/10k-most-common.txt -o cracked_pmkid.txt
