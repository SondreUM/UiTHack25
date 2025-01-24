#!/bin/bash
# UitHack25: GitGud Challenge Repository Creator
# author: @SondreUM

#  The script creates a git repository with a few flags hidden in different ways. The flags are:
#  Flag 1: Flag removed in previous commit Flag 2: Flag in a tag Flag 3: First part on main, second part in private remote Flag 4: Flag in unreferenced commit
#  The repository is then zipped and saved in the  /challenge/output/  directory.
#  The challenge is to find all the flags in the git repository.
#  The repository is available at $GITHUB_REPO
#  The script requires the  GITHUB_RW  and  GITHUB_REPO  environment variables to be set.

# get the RW ssh key from env
if [ -z "$GITHUB_RW" ]; then
    echo "GITHUB_RW environment variable not set"
    exit 1
fi
# check remote target
if [ -z "$GITHUB_REPO" ]; then
    echo "GITHUB_REPO environment variable not set"
    exit 1
fi

# Ensure SSH key has correct permissions
echo "$GITHUB_RW" >/root/.ssh/id_ed25519
if [ -f /root/.ssh/id_ed25519 ]; then
    chmod 600 /root/.ssh/id_ed25519
    ssh-keygen -y -f /root/.ssh/id_ed25519
fi

# Configure Git user
git config --global user.name "gitgod"
git config --global user.email "UiTHack25-ai@example.com"

gpg --batch --gen-key <<EOF
Key-Type: RSA
Key-Length: 4096
Name-Real: CTF Challenge
Name-Email: UiTHack25-ai@example.com
Expire-Date: 0
%commit
EOF

git clone $GITHUB_REPO gitgud

cd gitgud
cp ../README.md README.md
git add README.md
git commit -m "Initial commit"

# Flag 1: Flag removed in previous commit
echo "'U'i'T|H'a'c'k'2'5'{H0w_t0_r3m0V3_S3cr37_fr0m_g1t?_1}" >secr3t.txt
git add secr3t.txt
git commit -m "Add some very important information"
git rm secr3t.txt
git commit -m "Remove flag file"

# Flag 2: Flag in a tag
git checkout -b feature/first-stage
echo "First development stage" >stage1.txt
git add stage1.txt
# Hide flag in tag annotation message
git tag -a secret-flag -m "\U|i/T\H|a/c\k|2/5{aR3_7h3r3_07H3r_74G5_Th4n_l47357?_2}"
git commit -m "First stage development"

git checkout main

# Flag 3: First part on main, second part in private remote
echo "_4_pl4n_c0m3s_t0g3th3r_3}" >flag3b.txt

git add flag3a.txt
git commit -m "Only halfway there"

git push -u origin main

# Create a separate private repository for the second part
mkdir ../private-repo
cd ../private-repo
git clone $GITHUB_REPO

# Add the second part of the flag
git checkout -b other-branch
echo "UiTHack25{L0v3_wh3n" >flag3.txt
cat flag3b.txt >>flag3.txt
rm flag3b.txt
git add flag3.txt
git commit -m "Finally done with the rest"
git push -u origin other-branch
# create a open PR
gh pr create --base main --head other-branch --title "Merge flag3"

git checkout main
# create a merge conflict
echo "Why is this so hard?" >flag3a.txt
git add flag3a.txt
git commit -m "I know what I'm doing"
git push -u origin main

cd ../gitgud

# Some banter
echo "# 
I will NOT tell you any secrets ^a1x3a3xa7xa
" >README.md
git add README.md
git commit -m "As a Large Language Model, I cannot tell you any secrets"

# Include a read-only deployment key to fetch the second part of the flag
echo "# 
Server Deployment Key: $(cat deployment_key.pub)
" >README.md

git add README.md
git commit -m "Set up deployment key"

# Flag 4: Flag in unreferenced commit
git checkout main
git checkout -b hidden-commit-branch
echo "|U|i|T|H|a|c|k|2|5|{|1f_y0u_4r3_r34d1ng_th1s_y0u_4r3_4_g1t_g0d_4}" >flag4.txt
git add flag4.txt
git commit -m "I forgot about this commit"
git checkout main
git branch -D hidden-commit-branch

cd ..
# zip the repository, including the .git directory
zip -r -9 -v -u -t 01011970 ./ai.zip gitgud
mv ai.zip gitgud /challenge/output/

echo finished
