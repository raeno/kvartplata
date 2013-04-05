#!/usr/bin/env ruby

def changelog_for_gem(gem)
  changelogs = `bundle exec gem contents #{gem}`.lines.grep(/history|changelog|news/i)
  if changelogs.empty?
    puts "No changelog found for gem #{gem}"

    return nil
  end
  changelogs.first.chomp
end



class GemDetails
  attr_accessor :name, :version_old, :version_new, :changelog_file_old, :changelog_file_new


  def initialize(name, version_old, version_new)
    @name, @version_old, @version_new = name, version_old, version_new
  end
  def self.from_str(str)
    match = str.match(/(\S+) \((.*) > (.*)\)/)
    puts "processing gem #{match[1]}"
    result = self.new(match[1], Gem::Version.new(match[3]), Gem::Version.new(match[2]))
    result.changelog_file_old = changelog_for_gem(result.name)
    result
  end
end



def bundler_gems
  gem_list = `bundle outdated`.lines.map{|line| line.gsub(/\s*\* /, '') if line =~ /\s*\* /}.compact

  gem_list.map { |gem_str| GemDetails.from_str(gem_str) }
end

def bundler_update
  system("bundle update")
end

def bundler_install
  system("bundle install")
end


def updated_gems(initial_gems, new_gems)
  result = []
  initial_gems.each do |gem|
    updated_gem = new_gems.find { |new_gem| gem.name == new_gem.name && gem.version < new_gem.version }
    result << [gem, updated_gem] if updated_gem
  end
  result
end


def changelog_diff
  gems = bundler_gems
  puts "Updating bundle"
  system('bundle update')
  File.open('bundler_gem_diff.txt', 'w') do |f|
    gems.each do |gem|
      gem.changelog_file_new = changelog_for_gem(gem.name)
      f.puts "###### #{gem.name} #{gem.version_old} -> #{gem.version_new} ######"
      if gem.changelog_file_old && gem.changelog_file_new
        puts "diff #{gem.changelog_file_old} #{gem.changelog_file_new}"
        f.puts `diff #{gem.changelog_file_old} #{gem.changelog_file_new}`
      else
        f.puts "Missing changelogs"
      end
    end
  end
  system('git checkout Gemfile.lock')
  #system('bundle install')
  nil
end

changelog_diff




