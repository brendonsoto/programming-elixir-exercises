# Pattern Matching
This chapter was about pattern matching
The *match* (`=`) and *pin* (`^`) operators were introduced

The match operator is used in two ways:
- if a variable is on the left and a value on the right, the operator sets the left to whatever is on the right
- if a value is on the left then an assertion is made to see if the left matches the right

The pin operator is used to refer to an existing value on a variable without reassing it
For instance, say we have `a = 1`
We're just setting `a` to be `1`
Now consider `^a = 2`
From the above notes on match normally we'd think `a` would be set to `2`, but there's a caret (`^`) before the variable
This caret is the pin operator and indicates the current value should be used
Thus the above context is like saying `1 = 2` which is like comparing `1` to `2` which matches the second bullet on match! (see what I did there?)
