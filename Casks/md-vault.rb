cask "md-vault" do
  version "0.3.1"
  sha256 "f96bef2a42a8b51b0e03f2d8379ea8743bb61d81ffee67b969308a6d9ee2de62"

  url "https://github.com/tbeseda/md-vault/releases/download/v#{version}/md-vault.zip"
  name "md-vault"
  desc "Viewer and editor for folders of markdown files"
  homepage "https://github.com/tbeseda/md-vault"

  depends_on macos: :tahoe

  app "md-vault.app"

  postflight do
    %w[com.apple.quarantine com.apple.provenance].each do |attr|
      result = system_command "/usr/bin/xattr",
                              args: ["-dr", attr, "#{appdir}/md-vault.app"]
      opoo "Failed to remove #{attr} from md-vault.app: #{result.stderr.strip}" unless result.exit_status.zero?
    end
  end

  zap trash: "~/Library/Preferences/com.tbeseda.md-vault.plist"
end
