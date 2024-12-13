
require_relative 'lib/net/scp/version'

Gem::Specification.new do |spec|
  spec.name          = "net-scp"
  spec.version       = Net::SCP::Version::STRING
  spec.authors       = ["Jamis Buck", "Delano Mandelbaum", "Mikl\u{f3}s Fazekas"]
  spec.email         = ["r.cheramy@netze-bw.de"]

  if ENV['NET_SSH_BUILDGEM_SIGNED']
    spec.cert_chain = ["net-scp-public_cert.pem"]
    spec.signing_key = "/mnt/gem/net-ssh-private_key.pem"
  end

  spec.summary       = %q{A pure Ruby implementation of the SCP client protocol.}
  spec.description   = %q{A pure Ruby implementation of the SCP client protocol}
  spec.homepage      = "https://github.com/robertcheramy/net-scp/"
  spec.license       = "MIT"
  spec.metadata      = {
    "changelog_uri" => "https://github.com/robertcheramy/net-scp/blob/master/CHANGELOG.md"
  }

  spec.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'net-ssh', [">= 2.6.5", "< 8.0.0"]

  spec.add_development_dependency 'test-unit', [">= 0"]
  spec.add_development_dependency 'mocha',     [">= 0"]
end
