# Webbed [![Build status][build-status-icon]][build-status]

Webbed implements the HTTP specification in pure, idiomatic Ruby. It takes care
of the intricacies of the protocol, letting you focus on building applications
that take full control of the rich semantics that HTTP offers.

## Installation ##

Webbed is distributed as a Ruby gem. It *does not* work on versions of Ruby less
than 1.9. It has been tested on Ruby 1.9.3, JRuby (1.9 mode), and Rubinius (1.9
mode).

    $ gem install webbed

## Usage ##

Since the gem has breaking changes daily, I haven't gotten around to writing
proper usage documentation. Check out the specs in the mean time to understand
what's going on.

## Contributing ##

1. Fork this repository.
2. Create a feature branch (`git checkout -b feature/my-new-feature`).
3. Commit your changes (`git commit -am "Add a feature"`).
4. Push your branch (`git push origin feature/my-new-feature`).
5. Create a new pull request.

## Resources ##

* [Documentation][documentation]
* [GitHub repository][repository]
* [Build status][build-status]

[build-status]: http://travis-ci.org/CapnKernul/webbed
[build-status-icon]: https://secure.travis-ci.org/CapnKernul/webbed.png
[repository]: https://github.com/CapnKernul/webbed
[documentation]: http://rubydoc.info/gems/webbed
