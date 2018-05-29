# Xcode Trash Remover

This is a simple script to remove Xcode's trash files that are generated under development.

## Installation

    $ gem install xcode_trash_remover

## Usage

`$ xcclean` to check your directories.

`$ xcclean -rm` to **remove** the files.

<img src = https://raw.githubusercontent.com/FrankKair/xcode-trash-remover/master/assets/output2.png width="45%" height="45%"/>

## Directories

- `Derived Data`: Intermediate build information.

- `Archives`: Info about the target. Used for debbuging deployd applications.

- `XCPGDevices`: Xcode Playground files.

- `CoreSimulator/Devices`: Simulators and devices. That's where Xcode stores the apps' data.

## Warning

You should only use this program if you're sure you're not going to use the information contained in these folders.

