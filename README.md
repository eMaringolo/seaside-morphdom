# seaside-morphdom
Seaside wrapper for morphdom lightweight DOM diffing/patching

[Seaside](https://github.com/SeasideSt/Seaside) integration (library, jQuery plugin and wrapper and call options) for the [morphdom](https://github.com/patrick-steele-idem/morphdom) lightweight DOM patching utility.

# Simple use

It is meant to be used as a replacement of `JQueryInstance>>replaceWith:` so instead of using that, you could call `morph:`.

E.g.

```smalltalk

  (html jQuery id: 'someId') morph: [:h | "render here"]
```

Of course this isn't very useful as a static call, but it is very useful when you're returning lots of elements from an AJAX script.

E.g.
```smalltalk

  html button
    onClick: (html jQuery ajax script: [:s |
      s << ((s jQuery id: 'someId') morph: [:h | "big tree rendered" ]);
    with: 'Morph my DOM!'
```

# Options

See `morph:`, `morph:fast:` and `morph:options:` for further customization, there is a `MorphdomOptions` object that works as a convenience to specify the options to the `morphdom()` call


# Installation

```smalltalk
Metacello new 
  baseline: 'BaselineOfJQueryMorphdom'; 
  repository: 'github://eMaringolo/seaside-morphdom/src';
  load.
```

# More examples

There is a `JQuery-Morphdom-Examples` package that autoinitializes a browser application at `/morphdom` in your default Seaside dispatcher (typically `http://localhost:8080/morphdom`), this example shows how to use a simple DOM patch, attach events to the call and some other things.

# Future work

Integrate it as an alternative of `JQLoad>>html:`, so we can write something like `(html jQuery id: 'foo') load morph: [:h | "render here" ]`.







