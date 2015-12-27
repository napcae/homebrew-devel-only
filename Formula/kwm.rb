class Kwm < Formula
  desc "Tiling window manager with focus follows mouse for OSX."
  homepage "https://github.com/koekeishiya/kwm"

  devel do
    # We cannot use tar/zip file.
    # It needs git repository for versioning at bootstrap.
    url "https://github.com/koekeishiya/kwm.git",
        :revision => "6c6aef5de8cb4bd98e137fbbf3cd9b72c9b6eec0"
    version "0.1"
  end

  def install
    system "make", "install"
    bin.install "bin/kwm"
    bin.install "bin/kwmc"
    lib.install "bin/hotkeys.so"
    prefix.install "examples/kwmrc"
  end

  def plist; <<-EOF.undent
    <?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.koekeishiya.kwm</string>
    <key>ProgramArguments</key>
    <array>
      <string>#{bin}/kwm</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>Sockets</key>
    <dict>
        <key>Listeners</key>
        <dict>
            <key>SockServiceName</key>
            <string>3020</string>
            <key>SockType</key>
            <string>dgram</string>
            <key>SockFamily</key>
            <string>IPv4</string>
        </dict>
    </dict>

</dict>
</plist>
    EOF
  end

  def caveats; <<-EOF.undent
      Copy the example config from #{prefix}/kwmrc into your home directory.
        cp #{prefix}/kwmrc ~/.kwmrc
    EOF
  end

  test do
    system "true"
  end
end
