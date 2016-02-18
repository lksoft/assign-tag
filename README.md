# Octopress Assign Tag

A more powerful assign liquid tag. Features:

- Conditional assignment
- Ternary assignment
- Support for `||`, `||=` and `+=`

[![Build Status](https://travis-ci.org/octopress/assign-tag.svg)](https://travis-ci.org/octopress/assign-tag)
[![Gem Version](http://img.shields.io/gem/v/octopress-assign-tag.svg)](https://rubygems.org/gems/octopress-assign-tag)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://octopress.mit-license.org)

## Installation

If you're using bundler add this gem to your site's Gemfile in the `:jekyll_plugins` group:

    group :jekyll_plugins do
      gem 'octopress-assign-tag'
    end

Then install the gem with Bundler

    $ bundle

To install manually without bundler:

    $ gem install octopress-assign-tag

Then add the gem to your Jekyll configuration.

    gems:
      -octopress-assign-tag

## Usage

Use the assign tag like normal.

```
{% assign var1 = 'awesome' %}     //=> 'awesome'
{% assign var2 = var1 | upcase %} //=> 'AWESOME'
```

Conditionally assign variables.

```
{% assign linkpost = true if post.external-url %}
{% assign comments = true unless post.comments == false %}
{% assign url (post ? post.url : page.url) %}
```

Use fancy operators in assignment.

```
{% assign author = post.author || page.author || site.author %}
{% assign name ||= site.name %}
{% assign title_text += ' →' if linkpost %}
```

Use variables in assignment.

```
{% assign my_data = site.data.{{ data_file_name }} %}
{% assign name = site.name | append:page.{{ product_name }} | downcase %}
{% assign stupid_example = (page.{{ product_name }} == null ? 'no-product' : 'product-{{ page.product_code }} | downcase }}') %}
```

## Contributing

1. Fork it ( https://github.com/octopress/assign-tag/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
