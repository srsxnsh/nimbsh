# Variables in nimbsh.

## Assignment and Expansion

In nimbsh, a shell variable can be assigned with the simple command `var_name=value`.

You can then refer back to the variable using `$var_name`.

For example:
```
> hl3_release_date=never

> echo half life 3 releases $hl3_release_date
half life 3 releases never
```


## Env variables:

Nimbsh also supports expanding environment variables. If no shell variables are found when
trying to expand a variable, the shell looks for environmental variables that you could be referencing.

For example:
```
> echo $SHELL
/usr/bin/nimbsh
```


