cask "md-vault" do
  version "0.4.1"
  sha256 "80f0fdaf4927a5ed7647b0cdc185280379459a3720ddc50b6d1ff9f09973ee3f"

  url "https://github.com/tbeseda/md-vault/releases/download/v#{version}/md-vault.zip"
  name "md-vault"
  desc "Viewer and editor for folders of markdown files"
  homepage "https://github.com/tbeseda/md-vault"

  depends_on macos: :tahoe

  app "md-vault.app"

  # The app is unsigned; clear Gatekeeper's quarantine so it opens
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/md-vault.app"], must_succeed: false
    run "/usr/bin/xattr", args: ["-dr", "com.apple.provenance", "{{appdir}}/md-vault.app"], must_succeed: false
  end

  zap trash: "~/Library/Preferences/com.tbeseda.md-vault.plist"
end
