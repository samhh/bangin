# bangin - pure, private bangs

## SYNOPSIS

**bangin** _input_

## DESCRIPTION

**bangin** takes an input string, attempts to parse it for a search term and a known !bang, and if successful outputs a URL.

## BANGLIST

Instead of storing bangs in a centralised database, bangin checks local _banglists_ for bang definitions.

Banglists are plaintext files in which each entry is newline separated. Each line should first contain a bang, followed by a space, followed by a string including the replacement location. The syntax is as follows:

`!bang text{{{s}}}text`

Banglists are discoverable by bangin in the following ordered locations:

1. `$XDG_CONFIG_HOME/bangin/bangin.bangs`
2. `$XDG_DATA_HOME/bangin/lists/*.bangs` (reverse alphabetical order)

## EXAMPLES

Given the following banglist:

```
!ab first{{{s}}}bang
!cd second{{{s}}}bang
```

And the following input: `bangin test!cd`

You will see the following output: `secondtestbang`

## EXIT STATUS

bangin exits with status 0 if a bang could successfully be produced. If this fails for any reason then bangin exits with status 1. This could represent but is not limited to the following:

- Invalid input syntax.
- Failure to find a matching bang.

## AUTHOR

Sam A. Horvath-Hunt (hello@samhh.com)

