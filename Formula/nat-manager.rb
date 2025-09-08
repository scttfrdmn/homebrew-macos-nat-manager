class NatManager < Formula
  desc "🌐 macOS NAT Manager - True NAT with address translation"
  homepage "https://github.com/scttfrdmn/macos-nat-manager"
  url "https://github.com/scttfrdmn/macos-nat-manager/archive/v1.0.0.tar.gz"
  sha256 "" # Will be updated when first release is created
  license "MIT"
  head "https://github.com/scttfrdmn/macos-nat-manager.git", branch: "main"

  depends_on "go" => :build
  depends_on "dnsmasq"
  depends_on "scttfrdmn/macos-askpass/macos-askpass"

  def install
    # Set version info for build
    ldflags = %W[
      -s -w
      -X main.version=#{version}
      -X main.commit=#{tap.user}
      -X main.date=#{time.iso8601}
    ]

    # Build the main binary
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/nat-manager"
    
    # Install documentation
    doc.install "README.md" if File.exist?("README.md")
    doc.install "CHANGELOG.md" if File.exist?("CHANGELOG.md")
    doc.install Dir["docs/*"] if Dir.exist?("docs")
    
    # Install completion scripts
    bash_completion.install "completions/nat-manager.bash" if File.exist?("completions/nat-manager.bash")
    zsh_completion.install "completions/nat-manager.zsh" if File.exist?("completions/nat-manager.zsh") 
    fish_completion.install "completions/nat-manager.fish" if File.exist?("completions/nat-manager.fish")
  end

  def caveats
    <<~EOS
      🚀 Getting Started:
        sudo nat-manager               # Launch interactive TUI
        nat-manager --help            # Show all commands
        nat-manager version           # Show version info
      
      💡 Quick Examples:
        # Interactive mode (recommended for first-time users)
        sudo nat-manager
        
        # CLI mode for automation
        sudo nat-manager start --external en0 --internal bridge100 --network 192.168.100
        
        # Check NAT status
        sudo nat-manager status
        
        # Stop NAT
        sudo nat-manager stop
      
      ⚠️  Important Notes:
        • This tool requires root privileges (sudo) to modify network configuration
        • Uses pfctl (built into macOS), dnsmasq, and macos-askpass (installed as dependencies)
        • Creates bridge interfaces and configures NAT routing
        • Always stop NAT cleanly with 'nat-manager stop' before system shutdown
      
      📚 Documentation:
        https://github.com/scttfrdmn/macos-nat-manager
        
      🔐 Security Features:
        • True NAT with address translation (not bridging like Internet Sharing)
        • Integrated DHCP server for guest networks
        • DNS forwarding and resolution
        • Clean configuration management
        • Automatic bridge interface creation/deletion
    EOS
  end

  test do
    # Test version command
    assert_match "macOS NAT Manager", shell_output("#{bin}/nat-manager --version")
    
    # Test help command
    assert_match "Usage:", shell_output("#{bin}/nat-manager --help")
    
    # Test configuration validation (should not require root)
    system "#{bin}/nat-manager", "validate", "--config-only"
    
    # Test that the binary exists and is executable
    assert_predicate bin/"nat-manager", :executable?
  end
end