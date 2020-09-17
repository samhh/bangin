# bangin

_bangin_ - It's positively bangin'!

_bangin_ is a primitive, portable shell script which enables DuckDuckGo-like bangs. For example, an input of `bangin!hn` produces an output of `https://hn.algolia.com/?q=bangin`.

It aspires to be extensible and, hopefully, eventually, something of a pseudo-standard.

## What's wrong with DuckDuckGo?

Nothing at all! DuckDuckGo is an excellent service and bangs are an excellent idea. They are however limited due to their centralisation.

The first issue is that of performance. In order for a user to utilise DuckDuckGo's bangs, your requests must first make it to their servers and be redirected. This adds a perceptible delay to your requests before they reach their destination.

Secondly, DuckDuckGo has a few rules that bangs must adhere to that needn't exist in a decentralised solution. For example, if you've ever wanted to bang your way to a risque website, that's not been possible. Now you can!

Finally, you cannot override or remove bangs per your personal preference, and you cannot add bangs that "would [not] be useful to more than around 500 people". This means that you can't submit a bang for that niche website you like, and you likely occasionally find yourself somewhere you didn't intend to ever be by virtue of a typo. None of these limitations are technically necessary with a decentralised model.

## Why is _bangin_ better?

_bangin_ solves these problems with a simple solution which is maximally extensible, free in every sense of the word, and will work anywhere that can interpret POSIX shell scripts. Given some banglists, which are merely text files of newline-separated bangs, the shell script parses your input and outputs a URL which can then be forwarded onto a web browser or other utility.

The intention is that common bangs will be managed by the community in community lists, and that you as an individual user can also optionally maintain your own personal list. Think of it a little bit like adblocking with community-run lists of blocked domains.

## How do I get started?

There doesn't yet exist any sort of ecosystem around _bangin_, however I hope this changes. In the meantime, you can pass input from something like `dmenu` or `rofi` into _bangin_ and pipe the output to `xdg-open`. And, because it's a dead simple shell script, any other niche use case you have can almost certainly be accomodated with just a little bit of scripting. You can find an example usage in my [dotfiles](https://github.com/samhh/dotfiles/blob/desktop-linux/home/scripts/web-search.sh).

I maintain a few lists that you might be interested in:

- [duckduckgo.bangs](https://github.com/samhh/duckduckgo.bangs)
- [prelude.bangs](https://github.com/samhh/prelude.bangs)
- [dev.bangs](https://github.com/samhh/dev.bangs)
- [english.bangs](https://github.com/samhh/english.bangs)
- [uk.bangs](https://github.com/samhh/uk.bangs)

## Technical details

The shell script is written with POSIX compliance in mind, so it _should_ run almost anywhere. If that's not the case, please report a bug!

Banglists are plaintext files in which bangs are separated by newlines. On each line is a !bang and a URL with a `{{{s}}}` token, delimited by a space. All `*.bangs` files in `$XDG_DATA_HOME/bangin/lists/` are loaded in reverse alphabetical order, with priority being given to the first matching bang. If it exists, `$XDG_CONFIG_HOME/bangin/bangin.bangs` will be given priority and loaded first, allowing you to override bangs in community-sourced lists.

Bang aliases in banglists (`!a,!b url`) are not currently supported but are planned. Additionally, the prospect of enabling multiple bang output (`search !a !b`) is something to consider.

Bang syntax is currently very strict; the bang must be placed at the end of the line, and you must have both a search term and a bang, each non-empty. An input of `a!b!c` is interpreted as a search term of `a!b` and a bang of `!c`. Failure to adhere to this schema will result in a failure exit code.

## Miscellaneous

Unlike most of my projects, which utilise a copyleft license, _bangin_ is MIT licensed to encourage its widespread adoption and pseudo-standardisation. We all benefit if the idea of bangs becomes decentralised and normalised.

It'd be helpful for less technically inclined users if someone wrote a GUI for managing and customising banglists.

It'd also be helpful if someone could write some software that puts a thin web server around _bangin_ so that it could be deployed and used on any machine, almost like a DuckDuckGo substitute. At this point you'd have the extra request again, but you'd still benefit from _bangin_'s customisation, and you'd run the code on your own server that you knew you could trust.

An AUR package is planned. Packages for other distributions and operating systems would be welcomed.

