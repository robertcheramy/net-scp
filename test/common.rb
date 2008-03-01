$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/../lib"

require 'net/scp'
require 'net/ssh/test'
require 'test/unit'
require 'mocha'

class Net::SSH::Test::Channel
  def gets_ok
    gets_data "\0"
  end

  def sends_ok
    sends_data "\0"
  end
end

class Net::SCP::TestCase < Test::Unit::TestCase
  include Net::SSH::Test

  def default_test
    # do nothing, this is just a hacky-hack to work around Test::Unit's
    # insistence that all TestCase subclasses have at least one test
    # method defined.
  end

  protected

    def prepare_file(path, contents="", mode=0666, mtime=Time.now, atime=Time.now)
      entry = FileEntry.new(path, contents, mode, mtime, atime)
      entry.stub!
      entry
    end

    def prepare_directory(path, mode=0777, mtime=Time.now, atime=Time.now)
      directory = DirectoryEntry.new(path, mode, mtime, atime)
      yield directory if block_given?
      directory.stub!
    end

    class FileEntry
      attr_reader :path, :contents, :mode, :mtime, :atime, :io

      def initialize(path, contents, mode=0666, mtime=Time.now, atime=Time.now)
        @path, @contents, @mode = path, contents, mode
        @mtime, @atime = mtime, atime
      end

      def name
        @name ||= File.basename(path)
      end

      def stub!
        stat = Mocha::Mock.new(false, "file::stat")
        stat.stubs(:size => contents.length, :mode => mode, :mtime => mtime, :atime => atime, :directory? => false)

        File.stubs(:stat).with(path).returns(stat)
        File.stubs(:directory?).with(path).returns(false)
        File.stubs(:file?).with(path).returns(true)
        File.stubs(:open).with(path, "rb").returns(StringIO.new(contents))

        @io = StringIO.new
        File.stubs(:new).with(path, File::CREAT|File::TRUNC|File::RDWR, mode).returns(io)
      end
    end

    class DirectoryEntry
      attr_reader :path, :mode, :mtime, :atime
      attr_reader :entries

      def initialize(path, mode=0777, mtime=Time.now, atime=Time.now)
        @path, @mode = path, mode
        @mtime, @atime = mtime, atime
        @entries = []
      end

      def name
        @name ||= File.basename(path)
      end

      def file(name, *args)
        (entries << FileEntry.new(File.join(path, name), *args)).last
      end

      def directory(name, *args)
        entry = DirectoryEntry.new(File.join(path, name), *args)
        yield entry if block_given?
        (entries << entry).last
      end

      def stub!
        Dir.stubs(:mkdir).with { |*a| a.first == path }

        stat = Mocha::Mock.new(false, "file::stat")
        stat.stubs(:size => 1024, :mode => mode, :mtime => mtime, :atime => atime, :directory? => true)

        File.stubs(:stat).with(path).returns(stat)
        File.stubs(:directory?).with(path).returns(true)
        File.stubs(:file?).with(path).returns(false)
        Dir.stubs(:entries).with(path).returns(%w(. ..) + entries.map { |e| e.name }.sort)

        entries.each { |e| e.stub! }
      end
    end

    def expect_scp_session(arguments)
      story do |session|
        channel = session.opens_channel
        channel.sends_exec "scp #{arguments}"
        yield channel if block_given?
        channel.sends_eof
        channel.gets_exit_status
        channel.gets_eof
        channel.gets_close
        channel.sends_close
      end
    end

    def scp(options={})
      @scp ||= Net::SCP.new(connection(options))
    end
end
