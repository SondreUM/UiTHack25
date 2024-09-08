import argparse
import subprocess
import re
from itertools import permutations
import socket

process = None

def send_data(data):
    if isinstance(process, subprocess.Popen):
        process.stdin.write(data)
        process.stdin.flush()
    else:
        process.sendall(data.encode())

def recv_line():
    if isinstance(process, subprocess.Popen):
        return process.stdout.readline()
    else:
        buffer = ""
        while True:
            # Receive 1 byte at a time (or more if you prefer)
            data = process.recv(1).decode()
            if not data:
                # If no data is received, the connection is likely closed
                break
            
            buffer += data
            
            # If a newline is found, return the line (excluding the newline character)
            if "\n" in buffer:
                line, buffer = buffer.split("\n", 1)
                return line

def recv_data(len=1024):
    if isinstance(process, subprocess.Popen):
        return process.stdout.read(len)
    else:
        return process.recv(len).decode()

def parse_output(output):
    correct_pos_match = re.search(r'(\d) digits in the correct position', output)
    wrong_pos_match = re.search(r'(\d) correct digits, but in the wrong position', output)
    
    correct_pos = int(correct_pos_match.group(1)) if correct_pos_match else 0
    wrong_pos = int(wrong_pos_match.group(1)) if wrong_pos_match else 0

    return correct_pos, wrong_pos

def is_consistent(guess, possible_code, correct_pos, wrong_pos):
    correct_pos_count = sum(guess[i] == possible_code[i] for i in range(4))
    wrong_pos_count = sum(min(guess.count(digit), possible_code.count(digit)) for digit in set(guess)) - correct_pos_count

    return correct_pos_count == correct_pos and wrong_pos_count == wrong_pos

def crack_mastermind(host, port):
    global process

    try:
        if host and port:
            # Connect to the server
            process = socket.create_connection((host, int(port)))
        else:
            process = subprocess.Popen(['./mastermind'], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    except Exception as e:
        print(e)
        exit(1)
    
    for _ in range(8):
      output = recv_line()

    # Create a list of all possible 4-digit codes using digits 0-9
    remaining_possibilities = [''.join(i) for i in permutations('0123456789', 4)]
    print(f"Total possibilities: {len(remaining_possibilities)}")

    for _ in range(50):
        guess = remaining_possibilities.pop(0)
        print(f"Trying {guess}")

        # Send guess to the process
        send_data(f"{guess}\n")
        
        recv_data(len("Please enter code (4 digits): "))
        output = recv_line()
        output += recv_line()
        print(output)

        if "ACCESS GRANTED" in output:
            output = recv_data()
            print(output)
            break

        correct_pos, wrong_pos = parse_output(output)

        # Eliminate possibilities that are inconsistent with the feedback
        remaining_possibilities = [
            code for code in remaining_possibilities
            if is_consistent(guess, code, correct_pos, wrong_pos)
        ]

        print(f"Remaining possibilities: {len(remaining_possibilities)}")

    if isinstance(process, subprocess.Popen):
        process.stdin.close()
        process.stdout.close()
        process.stderr.close()
    else:
        process.close()

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('server', nargs='?', default='', help="Server in the format 'host:port'")

    args = parser.parse_args()
    host, port = None, None

    if args.server:
        if re.match(r'^[\w\.-]+:\d+$', args.server):
            # Server mode: extract host and port
            host, port = args.server.split(':')
        else:
            print("Invalid server format. Server in the format 'host:port'")
            exit(1)

    print(f"Cracking mastermind on {host}:{port}")

    crack_mastermind(host, port)
