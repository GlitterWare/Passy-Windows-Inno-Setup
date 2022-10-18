# Passy Windows Inno Setup

Windows Inno Setup for [Passy](https://github.com/GlitterWare/Passy).

## Building

1. *(Optional)* Change `MyAppVersion` in `passy.iss`.
2. Copy Windows build files into the `Release` folder.
3. Compile using Inno Setup Compiler.

## Command  line arguments

Format for command line arguments is `/<name>[=<value>]` (without angle brackets). E.g.: `/VERYSILENT`, `/UninstallerUserDataRemove=true`.

A list of Inno Setup command line arguments can be found [here](https://jrsoftware.org/ishelp/index.php?topic=setupcmdline).

Command line arguments specific to this setup:
- UninstallerUserDataRemove - Default is `false`, if set to `true`, all `Passy` directories containing user data inside every user's `Documents` directory will be erased during uninstall.
