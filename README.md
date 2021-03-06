# Specify HTML Reporter

[![Gem Version](https://badge.fury.io/rb/specify_html_reporter.svg)](http://badge.fury.io/rb/specify_html_reporter)
[![Build Status](https://travis-ci.org/jeffnyman/specify_html_reporter.svg)](https://travis-ci.org/jeffnyman/specify_html_reporter)
[![License](http://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/jeffnyman/specify_html_reporter/blob/master/LICENSE.md)
[![Maintainability](https://api.codeclimate.com/v1/badges/3a112fb395c56c961d87/maintainability)](https://codeclimate.com/github/jeffnyman/specify_html_reporter/maintainability)

This gem provides a custom formatter for RSpec execution that generates an HTML-based repository of results files.

While this projet was designed to augment my [Specify](https://github.com/jeffnyman/specify) tool, it will generate reports for any RSpec execution.

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

The usage is fairly simple and follows the standard pattern you would use for any RSpec formatter. Make sure to require the gem in your `spec_helper.rb` file:

```ruby
require "specify_html_reporter"
```

Then, in your `.rspec` file, make sure the following line is in place:

```ruby
--format SpecifyHtmlReport
```

If you aren't using an `.rspec` file, just provide `--format SpecifyHtmlReport` as part of your `rspec` execution command.

With the above being done, upon execution of your RSpec suite, you should get a directory called `reports` and within that you'll find an `overview.html` file that serves as the entry point for all reporting. Each spec file is given its own report format and is linked to from the overview file.

It is possible to include comments within the reports. See the [comment test](https://github.com/jeffnyman/specify_html_reporter/blob/master/spec/specify_html_reporter/comment_spec.rb) to see how to add comment metadata.

You can also include inline specifications, which are effectively special comments that get inserted into the reports. See the [inline test](https://github.com/jeffnyman/specify_html_reporter/blob/master/spec/specify_html_reporter/inline_spec.rb) to see how to add these.

It is also possible to embed resources, such as screen grabs and video records, into a report. See the [embedding test](https://github.com/jeffnyman/specify_html_reporter/blob/master/spec/specify_html_reporter/embedding_spec.rb) to see how metadata is used to achieve this effect.

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

## Credits

This gem is based on original work in [kingsleyh/rspec_reports_formatter](https://github.com/kingsleyh/rspec_reports_formatter) and the modifications provided by [vbanthia/rspec_html_reporter](https://github.com/vbanthia/rspec_html_reporter). The rationale for a new project rather than a fork is I wanted to significantly clean up the code to follow better practices, including fixing a lot of issues with the HTML in the report. Also I plan on extending this very specifically to work with my [Specify](https://github.com/jeffnyman/specify) gem.
