# UiTHack25

Repository for the yearly CTF challenge by UiT students.

## Motivation and vision

> We want to create more interest and enthusiasm for security and related problems for students.
For this, a noob-friendly Capture-the-flag competition is perfect!
The idea is to expose people to gradually more challenging tasks, starting with very simple ones and moving to more complex ones.
None should be too hard and some help will be given for those in need.

## Challenges

Add emoji!
| Noob | Web | Pwn | Misc | Rev_Eng | Crypto | Forensic | IRL |
| ------------------- | ------------------------------- | --------------------------- | ---------------------------------- | ------------------------------------- | ----------------------------------- | ---- | --- |
|  |  | Commlink 🖧 |  |  | Defining Curves ➰ |  |  |
|  |  |  | Alternative Facts 🪟 | Evasive Verification 🌐  | Caesarian Dilemma 👑 |  |  |
|  |  |  | Mastermind 🧠️ |  | Pattern Recognition 📯 |  |  |
|  |  |  |  |  | XORbitant defense ❌ |  |  |
|  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |

## Participants

Participants can submit their writeups by creating a pull request.
The writeup should preferably be in markdown format, but other formats are also accepted if it is easy to read.
Place the writeup in the `writeup` directory for the challenge, with the teamname as the directory name.
Scripts and other files can be placed in the same directory, look at the example structure below.

### Writeup file structure

```sh
├── README.md
├── rev📂
|    └── challenge1📂
|         ├── challenge.yml
|         ├── dockerfile
|         ├── README.md
|         ├── src📂
|         |    ├── app.exe📦
|         |    └── app.py📦
|         └── writeup📂
|              ├── README.md            # UiTHack organizer writeup
|              └── my-awesome-team📂    # team directory
|                   ├── solve.py        # solve script (optional)
|                   ├── image-1.png     # images to show off your exploits (optional)
|                   └── README.md       # your writeup
```

---

## Developer guidelines

### Flag format

This years flag format: `UiTHack25{flag}`

### CTF theme

> Cyberpunk

Challenges should try to use the theme as much as possible, such as names, images, description text.
However it is not a requirement.

### Challenge creation

1. Create a new issue for the challenge. Use tags to indicate category and difficulty. Use the issue description field to for a basic description of the challenge.
2. Pull/fetch from main.
3. Create a new branch for the specific task/issue `git checkout -b issueName` from main.
(\*Remember do pull/fetch).
4. When challenge is created, perform a commit `git add *` and `git commit -m "Insert description and alot of emojies like this :rocket: :fire:"`.\
Usage of [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/#summary) are encouraged, but not required.
5. Push branch `git push --set-upstream origin issueName`.
6. Add README for challenge, filename should be `README.md`.
Set up the directory structure as illustrated above.
All code should be contained in a subdirectory called `src`.
If complex commands are needed to build the project, add a Makefile or a build script.
7. Copy the `challenge-example_required.yml` template and fill in the required fields.
Add some topics that explains the exploit/vulnerability/solution (only visible for admins).
Example: SQL-injection, Buffer overflow, etc.
8. If the challenge needs to run on a server, create a dockerfile (template available) that contains everything needed to host the challenge.
9. Add writeup in the `writeup` directory for the challenge, filename should be `README.md`.
Additional solve scripts and files can also be added.
Include sources and references if relevant.
10. Update the main repository README with the new challenge.
11. Test the challenge. You should be able to solve it with the information given in writeup.
12. Create a pull request, the pull request should be linked to an issue.
Another team member should review and test the challenge before approving.

### CTFd app

CTFd is the application we are using to host the challenges and keep track of contestants/teams and scoreboards.
It will be served on `uithack.no` ---DNS---> `uithack.td.org.uit.no`

## Resources

### Previous UiTHacks

[UiTHack24 - Space](https://github.com/Loevland/UiTHack24)

[UiTHack23 - Nostalgi](https://github.com/td-org-uit-no/UiTHack23)

[UiTHack22 - Star Wars](https://github.com/td-org-uit-no/UiTHack22)

[UiTHack20 - Halloween](https://github.com/td-org-uit-no/UiTHack20)

[UiTHack19 - ??](https://github.com/td-org-uit-no/UiTHack19)
