# Paint package

Edit images with [jspaint](http://github.com/1j01/jspaint) in [Atom](http://github.com/atom/atom).


Currently supports the following file extensions:

 * `.gif`
 * `.ico`
 * `.jpeg`
 * `.jpg`
 * `.png`
 * `.bmp`


Use `paint:new` for a blank canvas.

Check out the `paint:` in the command palette for more commands. The editor doesn't take focus automatically yet, so you'll have to click on the status bar for the commands to be available.


## Todo!!!

* [x] Load images ([this commit](https://github.com/1j01/atom-jspaint/commit/45302adc5967de992228dce042bb8a45c9076a48) broke some things with security errors, but that should be fixed with a local copy of jspaint)
* [ ] Use git submodule for jspaint
* [ ] Serialization (using `data:` URIs)
* [ ] Save images (by reverse engineering)
* [x] Commands (more commands... `paint:toggle-toolbox`, etc.)
* [ ] Hide menus (most of them don't work in Atom, a bunch aren't wanted, and we can already have discoverability (via the command palette) without a second menu; this is an embedded editor after all, not a full-fledged application)
* [ ] Status bar integration
* [ ] Theme integration

I *should* write specs...

