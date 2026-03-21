cask "hn-reader" do
  version "0.1.0"
  sha256 "811f16cf9998394997e1e45cf47505636ffb613eb8f0ba80afeb63819065ef1b"

  url "https://github.com/tbeseda/hnr-swiftui/releases/download/v#{version}/HNReader.zip"
  name "HN Reader"
  desc "Native macOS app for browsing Hacker News stories"
  homepage "https://github.com/tbeseda/hnr-swiftui"

  depends_on macos: ">= :sequoia"

  app "HNReader.app"

  postflight do
    puts "Removing quarantine attributes from HNReader.app..."
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/HNReader.app"],
                   print_stderr: true
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.provenance", "#{appdir}/HNReader.app"],
                   print_stderr: true
    puts "Done. HNReader.app should launch without Gatekeeper warnings."
  end

  zap trash: [
    "~/Library/Preferences/com.tbeseda.HNReader.plist",
  ]
end
