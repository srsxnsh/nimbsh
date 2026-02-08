# Pipes in nimbsh

Pipes allow the output of one command to become the input of another. 

Nimbsh pipes work much the way as in standard UNIX shells, by using `|` to pipe commands into 
eachother.

```
> ls winden/people 
Helge
Ulrich
Martha
Aleksander
Mikkel

> ls winden/people | grep "M"
Martha
Mikkel
```
