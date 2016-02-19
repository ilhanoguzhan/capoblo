class InterfaceConnection
#simplest ruby program to read from arduino serial,
#using the SerialPort gem
#(http://rubygems.org/gems/serialport)
  require "rubygems"
  require "arduino_firmata"
  require 'rubyserial'

  #require "date"

  attr_accessor :port_str, :baud_rate, :data_bits, :stop_bits, :parity
  #params for serial port

  def initialize
    super
    self.port_str = "/dev/ttyACM0" #may be different for you
    self.baud_rate = 9600
    self.data_bits = 8
    self.stop_bits = 1
    self.parity = SerialPort::NONE
  end

  def self.get_interface
    conn = InterfaceConnection.new
    arduino = ArduinoFirmata.connect conn.port_str
    arduino
  end

end