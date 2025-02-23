# Building challenge

To build the challenge, do the following:

1. Extract the ssh keys stored `gh_keys.zip`, ask @SondreUM for the password. The keys can only be used for this challenge's repository and will be revoked after the competition.
2. Build the docker image: `docker build -t gitgud .`
3. Run the docker container: `docker run -it --rm -v $(pwd)/output:/challenge/output:rw gitgud`
4. The challenge files will be written as a zip archive to the `output` directory.
