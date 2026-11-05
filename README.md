# homebrew-reaper

Homebrew casks that install the [ReaPack](https://reapack.com/) and [SWS/S&M](https://www.sws-extension.org/) extensions for [REAPER](https://www.reaper.fm/). Both depend on Homebrew's `reaper` cask, so installing either one also installs REAPER.

## Install

```sh
brew tap rjungemann/reaper
brew trust --cask rjungemann/reaper/reaper-reapack
brew trust --cask rjungemann/reaper/reaper-sws
brew install --cask rjungemann/reaper/reaper-reapack rjungemann/reaper/reaper-sws
```

If `/Applications/REAPER.app` wasn't installed by Homebrew, the install stops rather than replacing it. Remove that copy first, or run `brew install --cask --force reaper`.

## What to know

- **Gatekeeper is bypassed for these two files.** Neither extension is notarized, so macOS blocks REAPER from loading them while they're quarantined. After Homebrew verifies each download's SHA-256, the cask removes `com.apple.quarantine` from that one dylib.
- **Standard resource folder only.** The dylibs go in `~/Library/Application Support/REAPER/UserPlugins` for the current user. Portable REAPER installs aren't covered.
- **ReaPack can update itself.** Its cask sets `auto_updates`, so `brew upgrade` skips it unless you pass `--greedy`.
- **SWS Python bindings aren't included.** `sws_python64.py` is a separate download, needed only for Python ReaScripts that call SWS functions.
- **Uninstalling keeps settings.** `brew uninstall --cask` removes the dylib. Add `--zap` to also remove the extension's settings and ReaPack's data.
