# UiTHack25

Repository for the yearly CTF challenge by UiT students

## Motivation and vision

> We want to create more interest and enthusiasm for security and related problems for students. For this, a noob-friendly Capture-the-flag competition is perfect! The idea is to expose people to gradually more challenging tasks, starting with very simple ones and moving to more complex ones. None should be too hard and some help will be given for those in need.

### Flag format

The flag format will be `UiTHack25{flag}`

### CTF theme

> TBD

## Challenges

Add emoji!
| Noob | Web | Pwn | Misc | Rev_Eng | Crypto | Forensic | IRL |
| ------------------- | ------------------------------- | --------------------------- | ---------------------------------- | ------------------------------------- | ----------------------------------- | ---- | --- |
|  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |

## Participants

Participants can submit their writeups by creating a pull request. The writeup should preferably be in markdown format, but other formats are also accepted if it is easy to read.

## Developer guidelines

1. Create a new issue for a task. Use tags to indicate category and difficulty.
2. Pull/fetch from main.
3. Create a new branch for the specific task/issue `git checkout -b issueName` from main. (\*Remember do pull/fetch).
4. When task is created, commit it `git add *` `git commit -m "Insert description and alot of emojies like this :rocket: :fire:"`.
5. Push branch `git push --set-upstream origin issueName`.
6. Add README for task, filename should be `README.md`.
7. Copy the `challenge.yml` template and fill in the required fields. Add some topics that explains the exploit/vulnaribility/solution (only visible for admins). Example: -SQL-injection, -Buffer overflow, etc.
8. If the challenge needs to run on a server, create a dockerfile (template available) for it.
9. Add writeup for task in the `writeup` directory for the challenge, filename should be `README.md`.
10. Update the main repository README with the new challenge.
11. Create a pull request to merge, and another member is required to overlook the code to merge it to main.
12. Update issue/task status in project.

### Servers & API

### CTFd app

CTFd is the application we are using to host the challenges and keep track of contestants/teams and scoreboards
It will be served on `uithack.no` ---DNS---> `uithack.td.org.uit.no`

## Resources

## Previous UiTHacks

[UiTHack24 - Space](https://github.com/Loevland/UiTHack24)

[UiTHack23 - Nostalgi](https://github.com/td-org-uit-no/UiTHack23)

[UiTHack22 - Star Wars](https://github.com/td-org-uit-no/UiTHack22)

[UiTHack20 - Halloween](https://github.com/td-org-uit-no/UiTHack20)

[UiTHack19 - ??](https://github.com/td-org-uit-no/UiTHack19)
