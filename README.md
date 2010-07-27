Webbed
======
Take control of HTTP.

Note on Releases
----------------
Releases are tagged on GitHub and also released as gems on RubyGems. `Master` is pushed to whenever I add a patch or a new feature. To build from master, you can clone the code, generate the updated `gemspec`, build the gem and install.

 * `rake gemspec`
 * `gem build webbed.gemspec`
 * `gem install` the gem that was built

Note on Patches/Pull Requests
-----------------------------
 * Fork the project.
 * Make your feature addition or bug fix.
 * Add tests for it. This is important so I don't break it in a future version unintentionally.
 * Commit, do not mess with `Rakefile`, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself in another branch so I can ignore when I pull)
 * Send me a pull request. Bonus points for topic branches.

Requirements
------------
 * [Bundler](http://github.com/carlhuda/bundler)
 * [Addressable](http://github.com/sporkmonger/addressable)

Install
-------
* `gem install webbed`

License
-------
Webbed is licensed under the MIT License. See `LICENSE` for details.