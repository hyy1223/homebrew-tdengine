# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Tdengine < Formula
  desc "An open-source big data platform designed and optimized for the Internet of Things (IoT)."
  homepage "https://github.com/taosdata/TDengine"
  url "https://github.com/taosdata/TDengine/archive/refs/tags/ver-2.2.0.0.tar.gz"
  sha256 "ba943a9aca8d90e20f2329c192f29289eb4676ba6828105d584aa9c4913767c0"
  license "AGPL-3.0"

  depends_on "cmake" => :build

 def install
     mkdir "debug" do
     system "cmake", "..", *std_cmake_args
     system "cmake","--build","."
     system "make"
     system "make","install"
     end
 end
 
 plist_options :manual => "taosd start"
 
 def plist; <<~EOS
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
     <key>KeepAlive</key>
     <true/>
     <key>Label</key>
     <string>#{plist_name}</string>
     <key>ProgramArguments</key>
     <array>
       <string>/usr/local/cellar/tdengine/$(verNumber)/bin/taosd</string>
     </array>
     <key>RunAtLoad</key>
     <true/>
     <key>WorkingDirectory</key>
     <string>/usr/local/cellar/tdengine/$(verNumber)/data</string>
   </dict>
   </plist>
   EOS
   end
 end