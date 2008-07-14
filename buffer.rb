module AMQP
  class Buffer
    def initialize data = ''
      @data = data
      @pos = 0
    end

    attr_reader :data, :pos
    alias :contents :data

    def << data
      @data << data
    end
    
    def length
      @data.length
    end
    
    def eof?
      pos == length
    end
  end
end

if $0 =~ /bacon/ or $0 == __FILE__
  require 'bacon'
  include AMQP

  describe Buffer do
    before do
      @buf = Buffer.new
    end

    should 'have contents' do
      @buf.contents.should == ''
    end

    should 'initialize with data' do
      @buf = Buffer.new('abc')
      @buf.contents.should == 'abc'
    end

    should 'append raw data' do
      @buf << 'abc'
      @buf << 'def'
      @buf.contents.should == 'abcdef'
    end

    should 'have a position' do
      @buf.pos.should == 0
    end

    should 'have a length' do
      @buf.length.should == 0
      @buf << 'abc'
      @buf.length.should == 3
    end

    should 'know the end' do
      @buf.eof?.should == true
    end

    should 'read data types'
    should 'write data types'
    should 'raise on overflow'
  
    { :octet => 255,
      :short => 100,
      :long => 100_000_000,
      :longlong => 999_888_777_666_555_444_333_222_111,
      :shortstr => 'hello',
      :longstr => 'bye'*500,
      :table => { :this => 'is', 4 => 'hash' },
      :timestamp => Time.now,
      :bit => [true, false, false, true, true]
    }.each do |type, value|

      it "should read and write #{type}s"

    end
  end
end