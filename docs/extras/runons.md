# Enjambment and Multiline input in Nimbsh.

Multiline input is accessible through Enjambment.
You can enjamb a line by appending `\` to the end of it.

```
> ls \
>> -a

people
places
.hidden

> ls \
>> -a \
>> places

springfield
winden
.hiddenplace
```
