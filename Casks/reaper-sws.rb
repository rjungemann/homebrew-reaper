cask "reaper-sws" do
  arch arm: "arm64", intel: "x86_64"

  version "2.14.0.7"
  sha256 arm:   "8e6ba86f4aac958871884d9285f4f063844900a04b25251bf95044334b103dba",
         intel: "7347a74485c537e74c0ddc53437845bf46a599317475fad21c82cd8a0269d89b"

  url "https://github.com/reaper-oss/sws/releases/download/v#{version}/reaper_sws-#{arch}.dylib"
  name "SWS/S&M Extension"
  desc "Extension adding actions and tools to REAPER"
  homepage "https://www.sws-extension.org/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on cask: "reaper"
  depends_on :macos

  artifact "reaper_sws-#{arch}.dylib",
           target: "#{Dir.home}/Library/Application Support/REAPER/UserPlugins/reaper_sws-#{arch}.dylib"

  # Upstream's dylib is not notarized, so Gatekeeper blocks REAPER from loading it while quarantined.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           [
          "-d", "com.apple.quarantine",
          "#{Dir.home}/Library/Application Support/REAPER/UserPlugins/reaper_sws-#{arch}.dylib"
        ],
        writable_paths: ["#{Dir.home}/Library/Application Support/REAPER/UserPlugins/reaper_sws-#{arch}.dylib"]
  end

  zap trash: "~/Library/Application Support/REAPER/S&M.ini"
end
