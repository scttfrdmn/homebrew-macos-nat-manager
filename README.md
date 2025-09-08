# Homebrew Tap for macOS NAT Manager

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This is a Homebrew tap for [macOS NAT Manager](https://github.com/scttfrdmn/macos-nat-manager), a tool that provides true Network Address Translation (NAT) functionality for macOS.

## Installation

```bash
# Add the tap
brew tap scttfrdmn/macos-nat-manager

# Install NAT Manager
brew install nat-manager
```

## Usage

After installation, you can use NAT Manager:

```bash
# Interactive TUI mode
sudo nat-manager

# CLI mode
sudo nat-manager start --external en0 --internal bridge100 --network 192.168.100
```

## About

Unlike macOS's built-in Internet Sharing which operates as a bridge, NAT Manager provides true NAT functionality with:

- **True NAT**: Actual address translation, not bridging
- **DHCP Server**: Built-in DHCP for guest networks  
- **DNS Integration**: Seamless DNS forwarding and resolution
- **pfctl Integration**: Native macOS packet filter configuration
- **Bridge Management**: Automatic bridge interface creation and management
- **Interactive TUI**: Beautiful terminal user interface
- **CLI Support**: Full command-line interface for automation

## Dependencies

- **dnsmasq**: Automatically installed as a dependency
- **pfctl**: Built into macOS (no installation needed)

## Requirements

- macOS 10.15+ (Catalina or later)
- Administrator privileges (sudo access)

## Links

- [Source Code](https://github.com/scttfrdmn/macos-nat-manager)
- [Documentation](https://github.com/scttfrdmn/macos-nat-manager/blob/main/README.md)
- [Issues](https://github.com/scttfrdmn/macos-nat-manager/issues)

## License

MIT © 2025 Scott Freedman