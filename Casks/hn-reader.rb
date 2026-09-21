cask "hn-reader" do
  version "0.6.1"
  sha256 "73e1454da8cd79ff1a0f7c061c7f285e132975540fe745529787b9432d4b8191"

  url "https://github.com/tbeseda/hnr-swiftui/releases/download/v#{version}/HNReader.zip"
  name "HN Reader"
  desc "Hacker News story reader with unread tracking"
  homepage "https://github.com/tbeseda/hnr-swiftui"

  depends_on macos: :tahoe

  app "HNReader.app"

  # The app is unsigned; clear Gatekeeper's quarantine so it opens
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/HNReader.app"], must_succeed: false
    run "/usr/bin/xattr", args: ["-dr", "com.apple.provenance", "{{appdir}}/HNReader.app"], must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/HNReader",
    "~/Library/Preferences/com.tbeseda.HNReader.plist",
  ]
end
