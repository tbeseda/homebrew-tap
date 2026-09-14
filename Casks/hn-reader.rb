cask "hn-reader" do
  version "0.6.0"
  sha256 "f04fcdd20a21484e44e69d57f3850e1d9f2d9826fb029e72d7cea6fd36b6f7f1"

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
