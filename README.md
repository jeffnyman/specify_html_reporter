# Specify HTML Reporter

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'specify_html_reporter'
```

To get the latest code:

```ruby
gem 'specify_html_reporter', git: 'https://github.com/jeffnyman/specify_html_reporter'
```

After doing one of the above, execute the following command:

```
$ bundle
```

You can also install Specify HTML Reporter just as you would any other gem:

```
$ gem install specify_html_reporter
```

## Usage

Instructions coming soon.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake spec:all` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To experiment with the code, run `bin/console` for an interactive prompt. If you want to make changes and see how they work as a gem installed on your local machine, run `bundle exec rake install`.

The default `rake` command will run all tests as well as a Rubocop analysis.

If you have rights to deploy a new version, make sure to update the version number in `version.rb`, and then run `bundle exec rake release`. This will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/jeffnyman/specify_html_reporter](https://github.com/jeffnyman/specify_html_reporter). The testing ecosystem of Ruby is very large and this project is intended to be a welcoming arena for collaboration on yet another test-supporting tool. As such, contributors are very much welcome but are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) which is provided as a [code of conduct](https://github.com/jeffnyman/specify_html_reporter/blob/master/CODE_OF_CONDUCT.md).

The Specify HTML Reporter gem follows [semantic versioning](http://semver.org).

To contribute to Specify HTML Reporter:

1. [Fork the project](http://gun.io/blog/how-to-github-fork-branch-and-pull-request/).
2. Create your feature branch. (`git checkout -b my-new-feature`)
3. Commit your changes. (`git commit -am 'new feature'`)
4. Push the branch. (`git push origin my-new-feature`)
5. Create a new [pull request](https://help.github.com/articles/using-pull-requests).

## Author

* [Jeff Nyman](http://testerstories.com)

## License

Specify HTML Reporter is distributed under the [MIT](http://www.opensource.org/licenses/MIT) license.
See the [LICENSE](https://github.com/jeffnyman/specify_html_reporter/blob/master/LICENSE.md) file for details.
