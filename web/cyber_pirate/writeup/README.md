> # Cyber Pirate
> > Web - 337pts/33 solves
>
> Only the bravest cyber pirates will find a way to steal the highly secured treasure, but whats the key to opening it?

## Writeup
SQL injection hoo!
The server uses SQL queries in the form:

> "SELECT flag FROM users WHERE key = '{}'


Try `' OR '1'='1` in username field to get the flag.