module Capoblo
  class InterfaceConnection
  #simplest ruby program to read from arduino serial,
  #using the SerialPort gem
  #(http://rubygems.org/gems/serialport)
    require "rubygems"
    require "arduino_firmata"

    #require "date"

    attr_accessor :port_str, :baud_rate, :data_bits, :stop_bits, :parity
    #params for serial port

    def initialize
      super
      self.port_str = "/dev/ttyACM0" if @port_str #may be different for you
      self.baud_rate = 9600 if @baud_rate
      self.data_bits = 8 if @data_bits
      self.stop_bits = 1 if @stop_bits
      self.parity = SerialPort::NONE
    end

    def self.get_interface(port = "/dev/ttyACM0", boud_rt = 9600)
      conn = InterfaceConnection.new
      conn.port_str = port
      conn.baud_rate = boud_rt
      arduino = ArduinoFirmata.connect conn.port_str
      sleep 1
      arduino
    end

  end
end