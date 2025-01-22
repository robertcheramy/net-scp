# Fork of Net::SCP

> :warning: This is a fork of Net::SCP

Upstream [Net::SCP](https://github.com/net-ssh/net-scp) is curently not
actively maintained. I am in contact with the developpers to find a solution.
I need commit 5ed618157daae8ef4d45943787ea61f714e3e870 in order to use APC
devices in [oxidized](https://github.com/ytti/oxidized).

So this is "my" version of Net::SCP in this repository until I find a solution
with the Net::SCP team.

I plan to keep the original Major and Minor version of Net:SSCP, and
differentiate with the patch version and the prerelease version set to fork:
4.0.3.fork.

Issues and Pull Requests are welcome in this fork, just use the github
funtionality.

## DESCRIPTION:

Net::SCP is a pure-Ruby implementation of the SCP protocol. This operates over
SSH (and requires the Net::SSH library), and allows files and directory trees
to be copied to and from a remote server.

## FEATURES/PROBLEMS:

*   Transfer files or entire directory trees to or from a remote host via SCP
*   Can preserve file attributes across transfers
*   Can download files in-memory, or direct-to-disk
*   Support for SCP URI's, and OpenURI


## SYNOPSIS:

In a nutshell:

```ruby
require 'net/scp'

# upload a file to a remote server
Net::SCP.upload!("remote.host.com", "username",
  "/local/path", "/remote/path",
  :ssh => { :password => "password" })

# upload recursively
Net::SCP.upload!("remote.host", "username", "/path/to/local", "/path/to/remote",
   :ssh => { :password => "foo" }, :recursive => true)

# download a file from a remote server
Net::SCP.download!("remote.host.com", "username",
  "/remote/path", "/local/path",
  :ssh => { :password => "password" })

# download a file to an in-memory buffer
data = Net::SCP::download!("remote.host.com", "username", "/remote/path")

# use a persistent connection to transfer files
Net::SCP.start("remote.host.com", "username", :password => "password") do |scp|
  # upload a file to a remote server
  scp.upload! "/local/path", "/remote/path"

  # upload from an in-memory buffer
  scp.upload! StringIO.new("some data to upload"), "/remote/path"

  # run multiple downloads in parallel
  d1 = scp.download("/remote/path", "/local/path")
  d2 = scp.download("/remote/path2", "/local/path2")
  [d1, d2].each { |d| d.wait }
end

# You can also use open-uri to grab data via scp:
require 'uri/open-scp'
data = open("scp://user@host/path/to/file.txt").read
```

For more information, see Net::SCP.

## REQUIREMENTS:

*   Net::SSH 2

If you wish to run the tests, you'll also need:

*   Echoe (for Rakefile use)
*   Mocha (for tests)


## INSTALL:

*   ```gem install net-scp (might need sudo privileges)```


However, in order to be sure the code you're installing hasn't been tampered
with, it's recommended that you verify the
[signature](http://docs.seattlerb.org/rubygems/Gem/Security.html). To do this,
you need to add my public key as a trusted certificate (you only need to do
this once):

```sh
# Add the public key as a trusted certificate
# (You only need to do this once)
$ curl -O https://raw.githubusercontent.com/net-ssh/net-ssh/master/net-ssh-public_cert.pem
$ gem cert --add net-ssh-public_cert.pem
```

Then- when installing the gem - do so with high security:

    $ gem install net-scp -P HighSecurity

If you don't add the public key, you'll see an error like "Couldn't verify
data signature". If you're still having trouble let me know and I'll give you
a hand.

## Security contact information

See [SECURITY.md](SECURITY.md)

## LICENSE:

(The MIT License)

Copyright (c) 2008 Jamis Buck <jamis@37signals.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
