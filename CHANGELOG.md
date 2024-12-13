# Changelog

## [ Unreleased ]
### Added
### Changed
### Fixed


## [4.0.rc01 - 2024-12-13 ]

### Added

### Changed
- Forked Net::SCP on https://github.com/robertcheramy/net-scp (@robertcheramy)

### Fixed
- Handle remotes closes without eof (@robertcheramy)


## [4.0.0 - 2022-10-14 ]
- net-ssh 7.* support

## [ 3.0.0 - 2020-04-26 ]

* NetSHH 6.* support

## [ 2.0.0 - 2019-03-20 ]

* NetSSH 5.* support

## [ 1.2.1 / 30 Apr 2014 ]

* Resign gem with new pubkey

## [ 1.2.0 / 11 Apr 2014 ]

* Get the error string during download [jkeiser]

## [ 1.1.2 / 6 Jul 2013 ]

* Explicit convert to string in shellescape [jwils]

## [ 1.1.1 / 13 May 2013 ]

* Allow passing a shell to use when executing scp. [Arthur Schreiber]

## [ 1.1.0 / 06 Feb 2013 ]

* Added public cert. All gem releases are now signed. See INSTALL in readme.

## [ 1.0.4 / 16 Sep 2010 ]

* maintain filename sanitization compatibility with ruby 1.8.6 [Sung Pae, Tim Charper]

## [ 1.0.3 / 17 Aug 2010 ]

* replace :sanitize_file_name with a call to String#shellescape [Sung Pae]
* Added gemspec file and removed echoe dependency [Miron Cuperman, Delano Mandelbaum]
* Removed Hanna dependency in Rakefile [Delano Mandelbaum]


## [ 1.0.2 / 4 Feb 2009 ]

* Escape spaces in file names on remote server [Jamis Buck]


## [ 1.0.1 / 29 May 2008 ]

* Make sure downloads open the file in binary mode to appease Windows [Jamis Buck]


## [ 1.0.0 / 1 May 2008

* Pass the channel object as the first argument to the progress callback [Jamis Buck]


## [ 1.0 Preview Release 1 (0.99.0) / 22 Mar 2008 ]

* Birthday!
