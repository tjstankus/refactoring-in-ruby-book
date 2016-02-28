Refactoring in Ruby Notes
=========================

Issues with initial implementation of sparky
--------------------------------------------

- Use of constants, globals, methods, and local(-ish) variables. It's a
  disorganized script. All over the place. Inconsistent style.
- Why is `toss` doing what it's doing? What do the hardcoded numbers mean?
- `values` would benefit from `tap` or something along those lines that's more
  idiomatic and elegant.
- Arguments to `spark` should probably be an object. Anything with x and y as
  coupled parameters probably represents a data clump.
- The markup details of SVG are front and center. They look like line noise.
  They should be in an object that's responsible for emitting SVG markup.
  There's probably a library for this, but I'm not sure yet if the bit of SVG
  we're generating is worthy of pulling in a whole library.
- The code, of course, has no tests, so it's not ready for refactoring. At the
  very least, to start refactoring this, it would need an integration-ish test.

Next steps, IMO
---------------

- [ ] Write an integration-ish test
  - [ ] Seed correctly to test random data
