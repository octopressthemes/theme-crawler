# A parser used for [octopressthemes.github.io](http://octopressthemes.github.io)

## Description:

Goes through the whole table of octopress themes listed on the [Octopress Wiki](https://github.com/imathis/octopress/wiki/3rd-Party-Octopress-Themes) and creates a [jekyll post](http://jekyllrb.com/docs/posts/) for each.

Besides that, it also takes screenshots with [webkit2png](https://github.com/paulhammond/webkit2png) and stores them in the `screenshots` folder with the name `"#{post[:slug]}-clipped.png"`.

## Dependencies:

```ruby
gem 'nokogiri'
gem 'pry'
gem 'activesupport'
gem 'ruby-progressbar'
```

and [webkit2png](https://github.com/paulhammond/webkit2png).


## Installation

```bash
brew install webkit2png
```

```bash
bundle install
```

### Run:

```bash
ruby parser.rb
```
