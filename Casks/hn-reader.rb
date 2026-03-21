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
    %w[com.apple.quarantine com.apple.provenance].each do |attr|
      result = system_command "/usr/bin/xattr",
                              args: ["-dr", attr, "#{appdir}/HNReader.app"]
      unless result.exit_status.zero?
        opoo "Failed to remove #{attr} from HNReader.app: #{result.stderr.strip}"
      end
    end
  end

  zap trash: [
    "~/Library/Preferences/com.tbeseda.HNReader.plist",
  ]
end
