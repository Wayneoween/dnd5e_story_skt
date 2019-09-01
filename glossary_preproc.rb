#!/usr/bin/env ruby
# frozen_string_literal: true

# This script will take a post filename as the first and only argument
# What it will do is loop through all files in _glossary/ and replace
# mentions in the post with links to the glossary page. This script aims to
# produce idempotent results.
#

require 'front_matter_parser'
require 'yaml'
require 'active_support/core_ext/string/inflections'

DEBUG = true

# just one glossary item
class GlossaryItem
  attr_reader :fname, :title, :link_part, :slug

  def initialize(fname)
    return unless File.exist? fname

    @fname = fname
    fcontent = YAML.load_file(fname)
    # Slug is the file name without extension, e.g. "Volo"
    @slug = fname.gsub('_skt_glossary/', '')\
                 .gsub(/\.md$/, '')\
                 .gsub('_', ' ')\
                 .titleize
    # Title is e.g. "Volothamp Geddarm". This is optional and defaults to @slug
    @title = fcontent['title'] ||= @slug
    # Link part is the hash part in /glossary/ for this glossary item,
    # i.e. #volothamp+geddarm
    @link_part = "##{@title.downcase.gsub(' ', '+')}"
  end
end

all_glossary_items = Dir.glob('_skt_glossary/*.md').map do |item_fname|
  puts "[DEBUG] reading #{item_fname}" if DEBUG
  GlossaryItem.new(item_fname)
end

puts "[DEBUG] DONE reading glossary items" if DEBUG

markdown_fname = ARGV.first
markdown_file = FrontMatterParser::Parser.parse_file(markdown_fname)

all_glossary_items.each do |glossary_term|
  puts "[DEBUG] substituting #{glossary_term.title} in #{markdown_fname}..." if DEBUG
  count = 0

  # We must only replace full words that are not enclosed in quotes
  markdown_file.content.gsub!(/\b(?!<")#{glossary_term.title}(?!")\b/) { |m| count +=1; m.replace("{% include glossary_link.html title=\"#{glossary_term.title}\" %}")}

  markdown_file.content.gsub!(/\b(?!<")#{glossary_term.slug}(?!")\b/) { |m| count +=1; m.replace("{% include glossary_link.html title=\"#{glossary_term.slug}\" name=\"#{glossary_term.title}\" %}")}

  puts "[DEBUG] ... #{count} times!"
end

File.open(markdown_fname, 'w') do |output_file|
  puts "[DEBUG] writing changes to #{markdown_fname}" if DEBUG
  # We're writing this out step by step because FrontMaterParser.to_yaml
  # does not reproduce the original input
  output_file.write(markdown_file.front_matter.to_yaml)
  output_file.write("---\n\n")
  output_file.write(markdown_file.content)
end
