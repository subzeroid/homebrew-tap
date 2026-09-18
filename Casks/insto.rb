cask "insto" do
  version "0.1.0"

  on_arm do
    sha256 "d53cf5d170228b2fdf72bea38219410e8324bc0c5aa3f4516699feb5e82ed4ab"

    url "https://github.com/subzeroid/insto-gui/releases/download/v#{version}/insto_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "3c31bc7e8d20ef8185ac48aeb2ceaa585649767136cac8116fa3f326a5624efd"

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
    insto is ad-hoc signed and not notarized. Install with --no-quarantine, or
    open it once and allow it under System Settings → Privacy & Security.
    The background monitoring service keeps running after you quit or uninstall
    the app; it runs from a private runtime, not from the app bundle. Disable it
    from inside the app before `brew uninstall --zap`, which removes that runtime
    and the service's launchd entry.
  EOS
end
