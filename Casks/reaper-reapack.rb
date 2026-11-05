cask "reaper-reapack" do
  arch arm: "arm64", intel: "x86_64"

  version "1.2.6"
  sha256 arm:   "c7670f3b2e405b9037d49b1941a4d8c3762fff326cecc0c58ac4faeca171f07b",
         intel: "48b261974e36671384ca902a3b3d5a614178f40b1beb7c138c741410ea5d7d9e"

  url "https://codeberg.org/cfillion/reapack/releases/download/v#{version}/reaper_reapack-#{arch}.dylib"
  name "ReaPack"
  desc "Package manager for REAPER"
  homepage "https://reapack.com/"

  livecheck do
    url "https://codeberg.org/cfillion/reapack.git"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  auto_updates true
  depends_on cask: "reaper"
  depends_on :macos

  artifact "reaper_reapack-#{arch}.dylib",
           target: "#{Dir.home}/Library/Application Support/REAPER/UserPlugins/reaper_reapack-#{arch}.dylib"

  # Upstream's dylib is not notarized, so Gatekeeper blocks REAPER from loading it while quarantined.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           [
          "-d", "com.apple.quarantine",
          "#{Dir.home}/Library/Application Support/REAPER/UserPlugins/reaper_reapack-#{arch}.dylib"
        ],
        writable_paths: ["#{Dir.home}/Library/Application Support/REAPER/UserPlugins/reaper_reapack-#{arch}.dylib"]
  end

  zap trash: [
    "~/Library/Application Support/REAPER/ReaPack",
    "~/Library/Application Support/REAPER/reapack.ini",
  ]
end
