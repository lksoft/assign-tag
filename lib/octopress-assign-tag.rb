require "octopress-assign-tag/version"
require "octopress-tag-helpers"
require "jekyll"

module Octopress
  module Tags
    module Assign
      class Tag < Liquid::Tag
        SYNTAX = /([[:word:]]+)\s*(=|\+=|\|\|=)\s*(.*)\s*/o
        VAR_MATCH = /([^{]*)({{(.*)}})(.*)/o
        SUB_VARS = /([^{]*)({{\s([^}]*)\s}})/o

        def initialize(tag_name, markup, tokens)
          @markup = markup
          super
        end

        def render(context)

          return unless markup = TagHelpers::Conditional.parse(@markup, context)

          if markup =~ SYNTAX
            var      = $1
            operator = $2
            value    = $3

            if value =~ VAR_MATCH 
              first_part = $1
              evaluate_part = $2
              last_part = $4
              new_value = ""

              evaluate_part.scan (SUB_VARS) {
                pre_value = $1
                evaluated_var = TagHelpers::Var.get_value($3, context)
                new_value = new_value + pre_value + evaluated_var
              }
              value = first_part + new_value + last_part
            end

            value = TagHelpers::Var.get_value(value, context)

            return if value.nil?

            context = TagHelpers::Var.set_var(var, operator, value, context)
          else
            raise SyntaxError.new("Syntax Error in 'assign tag': #{@markup} - Valid syntax: assign [var] = [source] | filter")
          end
          ''
        end
      end
    end
  end
end

Liquid::Template.register_tag('assign', Octopress::Tags::Assign::Tag)

if defined? Octopress::Docs
  Octopress::Docs.add({
    name:        "Octopress Assign Tag",
    gem:         "octopress-assign-tag",
    version:     Octopress::Tags::Assign::VERSION,
    description: "An improved assign liquid tag, featuring conditionals, concatenation, ternary asignment, and more.",
    path:        File.expand_path(File.join(File.dirname(__FILE__), "../")),
    source_url:  "https://github.com/octopress/assign-tag"
  })
end
