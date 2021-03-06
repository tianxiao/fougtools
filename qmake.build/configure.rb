#############################################################################
##
##  FougTools
##  Copyright FougSys (1 Mar. 2011)
##  contact@fougsys.fr
##
## This software is a computer program whose purpose is to provide utility
## tools for the C++ language and the Qt toolkit.
##
## This software is governed by the CeCILL-C license under French law and
## abiding by the rules of distribution of free software.  You can  use,
## modify and/ or redistribute the software under the terms of the CeCILL-C
## license as circulated by CEA, CNRS and INRIA at the following URL
## "http://www.cecill.info".
##
## As a counterpart to the access to the source code and  rights to copy,
## modify and redistribute granted by the license, users are provided only
## with a limited warranty  and the software's author,  the holder of the
## economic rights,  and the successive licensors  have only  limited
## liability.
##
## In this respect, the user's attention is drawn to the risks associated
## with loading,  using,  modifying and/or developing or reproducing the
## software by the user in light of its specific status of free software,
## that may mean  that it is complicated to manipulate,  and  that  also
## therefore means  that it is reserved for developers  and  experienced
## professionals having in-depth computer knowledge. Users are therefore
## encouraged to load and test the software's suitability as regards their
## requirements in conditions enabling the security of their systems and/or
## data to be ensured and,  more generally, to use and operate it in the
## same conditions as regards security.
##
## The fact that you are presently reading this means that you have had
## knowledge of the CeCILL-C license and that you accept its terms.
##
#############################################################################

#!/usr/bin/ruby

require 'getoptlong'

def isWinPlatform()
  return RUBY_PLATFORM =~ /mingw|mswin/
end

def checkFileExists(file)
  if not File.exists?(file) then
    puts "Warning: '#{file}' does not exist"
  end
end

def asQMakePath(file)
  if isWinPlatform() then
    return file.gsub("\\", "/")
  else
    return file
  end
end

def printHelp()
  puts "Usage: configure.rb [--help|-h]"
  puts ""
  puts "         --prefix <dir> ............. This will install everything relative to <dir>"
  puts "                                      (default PWD/local)"
  puts ""
  puts "         --qt-dir <dir> ............. Qt root directory"
  puts "         --boost-dir <dir> .......... Boost root directory"
  puts "         --occ-dir .................. Open Cascade root directory"
  puts "                                      Useful only with --occtools"
  puts ""
  puts "      *  --no-occtools .............. Do not compile occtools"
  puts "         --occtools ................. Compile occtools"
  puts "                                      Requires OpenCascade (see --occ-dir)"
  puts "         --use-oce .................. Use OpenCascade community edition"
  puts "                                      Useful only with --occtools"
  puts ""
end

# Parse command line
configArgs = ARGV.join(' ')
opts = GetoptLong.new(
  ['--help', '-h', GetoptLong::NO_ARGUMENT],
  ['--prefix', GetoptLong::REQUIRED_ARGUMENT],
  ['--qt-dir', GetoptLong::REQUIRED_ARGUMENT],
  ['--boost-dir', GetoptLong::REQUIRED_ARGUMENT],
  ['--occ-dir', GetoptLong::REQUIRED_ARGUMENT],
  ['--no-occtools', GetoptLong::NO_ARGUMENT],
  ['--occtools', GetoptLong::NO_ARGUMENT],
  ['--use-oce', GetoptLong::NO_ARGUMENT])

options = { :boostDir => "/opt/def/boost",
            :prefix=> "$$PWD/local",
            :qtDir => "/opt/def/qt",
            :occDir => "/opt/def/occ",
            :occTools => false,
            :useOce => false }
opts.each do |opt, arg|
  case opt
    when '--help'
      printHelp()
      exit
    when '-h'
      printHelp()
      exit
    when '--prefix'
      options[:prefix] = arg
    when '--qt-dir'
      options[:qtDir] = arg
    when '--boost-dir'
      options[:boostDir] = arg
    when '--occ-dir'
      options[:occDir] = arg
    when '--no-occtools'
      options[:occtools] = false
    when '--occtools'
      options[:occtools] = true
    when '--use-oce'
      options[:useOce] = true
  end
end

checkFileExists(options[:boostDir])

File.open('_local_config.pri', 'w') do |f|
  f.puts("PREFIX_DIR = #{asQMakePath(options[:prefix])}")
  f.puts("BOOST_ROOT = #{asQMakePath(File.expand_path(options[:boostDir]))}")
  if options[:occtools] then
    f.puts("CONFIG *= occtools")
    f.puts("CASCADE_ROOT = #{asQMakePath(File.expand_path(options[:occDir]))}")
    if options[:useOce] then
      f.puts("CONFIG *= use_oce")
    end
  end
end

# Output configure cache
File.open('_configure.cache', 'w') do |f|
  f.puts("configure.rb #{configArgs}")
end
