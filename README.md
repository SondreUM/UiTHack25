# UiTHack25{CTF}

Repository for the yearly CTF challenge by UiT students.\
Official Discord server: <https://discord.gg/V5dWfyrCQ3>

## Motivation and vision

> We want to create more interest and enthusiasm for security and related problems for students.
For this, a noob-friendly Capture-the-flag competition is perfect!
The idea is to expose people to gradually more challenging tasks, starting with very simple ones and moving to more complex ones.
None should be too hard and some help will be given for those in need.

## Challenges

📌Add emoji!

| Noob | Web | Pwn | Misc | Rev_Eng | Crypto | Forensic | IRL |
| ------------------- | ------------------------------- | --------------------------- | ---------------------------------- | ------------------------------------- | ----------------------------------- | ---- | --- |
| Noob1🐱 | !big_picture 🔍 | SC0 📹 | Knock Knock 🚪 |  | Defining Curves ➰ |  | Dinosaur tech 💾 |
| Noob2🍼 | Evilcorp Marketplace 🏬 | HexCore 🐚 | Alternative Facts 🪟 | Evasive Verification 🌐  | Caesarian Dilemma 👑 |  |  |
| Noob3👶 |  | Commlink 🖧 | Mastermind 🧠️ | luigi.wasm 👨‍🔧 | Pattern Recognition 📯 |  |  |
| Noob4🐊 |  |  | Metro Brutes 💪 | ByteRunner 🌆  | XORbitant defense ❌ |  |  |
| Noob5🐉 |  |  |  |  | Curvy fascination 💀 |  |  |
|  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |

## Participants

Participants can submit their writeups by creating a pull request.
The writeup should preferably be in markdown format, but other formats are also accepted if it is easy to read.
Place the writeup in the `writeup` directory for the challenge, with the teamname as the directory name.
Scripts and other files can be placed in the same directory. Take a look at the example structure below.

### Writeup file structure

```sh
├── README.md # <------------------------ You are here!
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
|                   └── README.md       # your awesome writeup
```

---

## Developer guidelines

### Contributors

Huge thanks to all UiTHack organizers and contributors! 🎉\
They make this event possible by dedicating their free time to create challenges and writeups.
<!-- Will not function until after the repo goes public -->
[![Contributors](https://contrib.rocks/image?repo=SondreUM/UiThack25)](https://github.com/sondreum/UiTHack25/graphs/contributors)

### Flag format

This years flag format: `UiTHack25{flag}`

### CTF theme

> Cyberpunk

Challenges should try to use the theme as much as possible, such as names, images, description text.
However it is not a requirement.

### Challenge difficulty

- **Noob**: Challenges that are meant to familiarize the player with the CTF format.\
*Note: These challenges are put into its own category, and the difficulty rating should not be used on other challenges.*
- **Easy**: No prerequisites, should be solvable by everyone. A new player should be able to solve this in a couple of hours at most.\
*Note: Easy challenges should not have purchasable hints (can be free), as these are provided for free if the player opens a ticket.*
- **Medium**: Requires some knowledge of the subject, or a bit of google-fu.
- **Hard**: Requires in-depth knowledge of the subject. Experienced players will find this challenging.
- **Insane**: Only a few to none will be able to solve this. Requires a lot of knowledge and experience on the topic.\
*Note: This difficulty should be used sparingly, as they require a lot of time to create and test.*

Remember that making a challenge time-consuming does not make it harder, it just makes it more annoying.\
The goal is to make the challenges fun and educational.
To make a challenge easier leave breadcrumbs and hints in the challenge description or in the challenge itself. To make a challenge harder, increase the complexity by adding more steps or layers, but make sure that feedback is given to the player so they know they are on the right track.

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

### Infrastructure

UitHack uses [CTFd](https://ctfd.io/) as the frontend application to host the challenges and keep track of contestants/teams and scoreboards.
It will be served on `uithack.no` ---DNS---> `uithack.td.org.uit.no`

Challenges will be hosted on `uithack-2.td.org.uit.no`

## Resources

### Collaborators

- [Tromsøstudentenes Dataforening](https://td-uit.no/about-us)

### Previous UiTHacks

[UiTHack24 - Space](https://github.com/Loevland/UiTHack24)

[UiTHack23 - Nostalgi](https://github.com/td-org-uit-no/UiTHack23)

[UiTHack22 - Star Wars](https://github.com/td-org-uit-no/UiTHack22)

[UiTHack20 - Halloween](https://github.com/td-org-uit-no/UiTHack20)

[UiTHack19 - ??](https://github.com/td-org-uit-no/UiTHack19)
