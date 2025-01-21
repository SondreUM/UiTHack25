# Misc - Mastermind

> > Misc - medium
>
> EvilCorp controls it all — your personal data, your freedom, and even your future. You have found a way to leak some data from their security systems, just enough to help you crack their security code. You have 6 attempts and 1 minute to break their code. Fail, and the system will activate a kill switch, instantly notifying EvilCorp's security division.
>
> Files: [mastermind](../src/mastermind), [mastermind.c](../src/mastermind.c)

## Writeup

The code has no repeating digits, the total number of possible codes is the number of permutations of 4 digits code with a set of 10 (0-9). This is:

$$
P(10,4)=10\times 9\times 8\times 7 = 5040
$$

You only have 7 guesses, so bruteforcing is infeasible and a optimal strategy must be used, such as Donald Knuth's algorithm. The algorithm can be simplified as follows:

1. Create a set $S$ of the 5040 possible codes.
2. Start with an initial guess.
3. Interpret the response. If the guess is correct, terminate.
4. Otherwise, remove from $S$ any code that would not give that response.
5. Choose a new guess from $S$.
6. Repeat from step 3.

Solve script: [solve.py](../src/solve.py)

## Resources

[1] <https://en.wikipedia.org/wiki/Mastermind_(board_game)>
