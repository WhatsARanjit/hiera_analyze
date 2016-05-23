#!/usr/bin/env ruby

log     = ARGV[0] || '/var/log/hiera_analyze.log'
pattern = ARGV[1] || '.*'
target  = ARGV[2] || false
used    = []

File.open(log).each do |line|
  m = line.match(/[A-Z]+: (\d{4}\-\d{2}\-\d{2} \d{2}:\d{2}:\d{2} \+\d{4}): \[([a-zA-Z0-9\-_\.]+)\] '(.*?)' from '(.*?)'/)
  puts m[3] if line.match(/#{pattern}/) unless target
  used << m[3]
end

used.uniq!

if target
  require 'yaml'
  target_yaml = YAML.load_file(target)
  all_keys    = target_yaml.keys
  puts "== Unused keys from #{target} =="
  puts all_keys - used
end
