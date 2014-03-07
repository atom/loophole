# Eval Loophole

This is a hack to enable third-party libraries that depend on a limited subset
of `eval` semantics to work in Atom with a content security policy that forbids
calls to `eval`.

```coffee
{allowUnsafeEval} = require 'loophole'

allowUnsafeEval ->
  crazyLibrary.exploitLoophole()
```

## How?

It replaces `eval` with a call two `vm.runInThisContext`, which won't perfectly
emulate `eval` but is good enough in certain circumstances, like compiling
[PEG.js][peg-js] grammars.

## Why?

If there's a loophole, why even enable CSP? It still prevents developers from
accidentally invoking eval with legacy libraries. For example, did you know that
jQuery runs eval when you pass it content with script tags? If you want eval,
you'll need to explicitly ask for it.

[peg-js]: http://pegjs.majda.cz/
