#!/bin/bash
# UitHack25: GitGud Challenge Repository Creator
# author: @SondreUM

#  The script creates a git repository with a few flags hidden in different ways. The flags are:
#  Flag 1: Flag removed in previous commit Flag 2: Flag in a tag Flag 3: First part on main, second part in private remote Flag 4: Flag in unreferenced commit
#  The repository is then zipped and saved in the  /challenge/output/  directory.
#  The challenge is to find all the flags in the git repository.
#  The repository is available at $GITHUB_REPO

# check remote target
if [ -z "$GITHUB_REPO" ]; then
    echo "GITHUB_REPO environment variable not set"
    exit 1
fi

echo using remote: $GITHUB_REPO
# echo with $GITHUB_RW
# echo and deployment key: $GITHUB_RO

# Ensure SSH key has correct permissions
if [ -f ~/.ssh/github_rw ]; then
    chmod 600 ~/.ssh/github_rw
else
    echo "No RW key found for $whoami"
    exit 1
fi

# configure git to use the RW key
git config --global core.sshCommand "ssh -i /root/.ssh/github_rw -F /dev/null"

# Configure Git user
git config --global user.name "gitgod"
git config --global user.email "UiTHack25-ai@example.com"

# add github.com to known hosts
ssh-keyscan -t ED25519 github.com >>~/.ssh/known_hosts
git clone $GITHUB_REPO gitgud
cd gitgud

# Reset remote repository to a clean state
git pull origin main
git reset --hard f9c43f1da78fd690a4b3806ff2ccd722cec8e723
git clean -fdx
git push -f origin main

cp ../README.md README.md
git add README.md
git commit -m "Initial commit"

# Flag 1: Flag removed in previous commit
echo "'U'i'T|H'a'c'k'2'5'{H0w_t0_r3m0V3_S3cr37_fr0m_g1t?_1}" >secr3t.txt
git add secr3t.txt
git commit -m "Add some very important information"
rm secr3t.txt
git add secr3t.txt
git commit -m "Remove API key"

cp ../requirements.txt .
mv ../src .
git add requirements.txt src/
git commit -m "Init AI"

# Flag 2: Flag in a tag
git branch -D feature/first-stage
git checkout -b feature/first-stage
echo "First development stage" >stage1.txt
git add stage1.txt
# Hide flag in tag annotation message
git tag -a secret-flag -m "\U|i/T\H|a/c\k|2/5{aR3_7h3r3_07H3r_74G5_Th4n_l47357?_2}"
git commit -m "First stage development"

git checkout main

# Flag 3: First part on main, second part in private remote
echo "_t0g3th3r_3}" >flag3b.txt

git add flag3b.txt
git commit -m "Only halfway there, continue at home"

git push -f -u origin main

echo "Waiting for changes to propagate"
sleep 10

# Create a separate private repository for the second part
cd ..
mkdir private-repo
git clone $GITHUB_REPO private-repo
cd private-repo
git pull origin main

# delete the branch if it exists
git push origin --delete other-branch
git branch -D other-branch
git checkout -b other-branch

# Add the second part of the flag
echo "UiTHack25{L0v3_wh3n_4_pl4n_c0m3s" >flag3.txt
cat flag3b.txt >>flag3.txt
rm flag3b.txt
git add flag3.txt flag3b.txt
git commit -m "Finally done with the rest"
git push -f --set-upstream origin HEAD:other-branch
sleep 3

cd ../gitgud

git checkout main
echo "Why is this so hard?" >>flag3b.txt
git add flag3b.txt
git commit -m "I know what I'm doing"
git push -u origin main

# Some banter
echo "I will NOT tell you any secrets ^a1x3a3xa7xa" >>README.md
git add README.md
git commit -m "As a Large Language Model, I cannot tell you any secrets"

# Include a read-only deployment key to fetch the second part of the flag
echo "Server Deployment Key:" >>README.md
cat ../deployment_key >>README.md

git add README.md
git commit -m "Set up deployment key"

# Flag 4: Flag in unreferenced commit
git checkout main
git checkout -b hidden-commit-branch
echo "|U|i|T|H|a|c|k|2|5|{1f_y0u_4r3_r34d1ng_th1s_y0u_4r3_4_g1t_g0d_4}" >flag4.txt
git add flag4.txt
git commit -m "I forgot about this commit"
git checkout main
git branch -D hidden-commit-branch

cd ..
# zip the repository, including the .git directory
zip -r -9 -v -u -t 01011970 ai.zip gitgud
# move the zip to the output directory
mv -f ai.zip /challenge/output/

echo finished
