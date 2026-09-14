# Xcode Trash Remover

[![CI](https://github.com/FrankKair/xcode-trash-remover/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/FrankKair/xcode-trash-remover/actions/workflows/ci.yml)

This is a simple script to remove Xcode's trash files that are generated under development.

If you need a full fledged application, check out [PureMac](https://github.com/momenbasel/PureMac) and [xcode-dev-cleaner](https://github.com/vashpan/xcode-dev-cleaner).

## Installation

    $ gem install xcode_trash_remover

## Usage

    $ xcclean

```
Usage: xcclean [options]
        --check           Checks the volumes
        --remove          Removes the files from your system
    -h, --help            Show this help
```

Pass exactly one of `--check` or `--remove`.

## Directories

- `Derived Data`: Intermediate build information.

- `Archives`: Info about the target. Used for debbuging deployed applications.

- `CoreSimulator/Devices`: Simulators and devices. That's where Xcode stores the apps' data.

- `iOS Support`: iOS device support files used for on-device debugging.

- `watchOS Support`: watchOS device support files used for on-device debugging.

- `Xcode Cache`: Xcode's general cache (`com.apple.dt.Xcode`).

- `SPM Cache`: Swift Package Manager cache (`org.swift.swiftpm`).


## Warning

You should only use this program if you're sure you're not going to use the information contained in these folders.

## Development

Run the test suite with:

    $ bundle exec rake test

The GitHub Actions workflow runs the same command on pushes, and pull requests to `main` using Ruby 4.0.2.

