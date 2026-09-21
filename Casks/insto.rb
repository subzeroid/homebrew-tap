cask "insto" do
  version "0.1.3"

  on_arm do
    sha256 "9321ac5124bd324af2a696f2da86a0fa0c6728f1511b809e39968a4a84814d68"

    url "https://github.com/subzeroid/insto-gui/releases/download/v#{version}/insto_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "dfc79b31311665cff3977ca1481e8cd8e2e9adeab1f4bf0824df3b85db66a88c"

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
