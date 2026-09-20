cask "insto" do
  version "0.1.2"

  on_arm do
    sha256 "962e8638a80668ab67bc8e11d4f01e3cc0180dd7456e2838f87f20ac5845de4d"

    url "https://github.com/subzeroid/insto-gui/releases/download/v#{version}/insto_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "55e3d372811e004092fdfe6e5c073fa67f13c007e0b80e6581afd05e90787543"

    url "https://github.com/subzeroid/insto-gui/releases/download/v#{version}/insto_#{version}_x64.dmg"
  end

  name "insto"
  desc "Instagram monitoring desktop app with a bundled insto core"
  homepage "https://github.com/subzeroid/insto-gui"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "insto.app"

  uninstall quit: "app.insto.desktop"

  zap trash: [
    "~/Library/Application Support/insto-gui",
    "~/Library/LaunchAgents/io.insto.watch.*.plist",
  ]

  caveats <<~EOS
    insto is ad-hoc signed and not notarized. Open it once and allow it under
    System Settings → Privacy & Security, or check the DMG hash and run
    `xattr -dr com.apple.quarantine /Applications/insto.app`.
    The background monitoring service keeps running after you quit or uninstall
    the app; it runs from a private runtime, not from the app bundle. Disable it
    from inside the app before `brew uninstall --zap`, which removes that runtime
    and the service's launchd entry.
  EOS
end
