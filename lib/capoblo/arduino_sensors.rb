class ArduinoSensors
  attr_accessor :arduino, :front_distance, :rear_distance

  ULTRASONIC_TRIGGER = 11
  ULTRASONIC_ECHO = 12
  AVOIDANCE_SENSOR_PIN = 2


  def initialize
    super
    self.arduino = ARDUINO_ONE

    self.arduino.pin_mode ULTRASONIC_TRIGGER, ArduinoFirmata::OUTPUT
    self.arduino.pin_mode ULTRASONIC_ECHO, ArduinoFirmata::INPUT
    self.arduino.pin_mode AVOIDANCE_SENSOR_PIN, ArduinoFirmata::INPUT
  end


  def front_distance
    @front_distance = 0
    ## For senfor is reading

    arduino.digital_write ULTRASONIC_TRIGGER, false
    sleep 0.005
    arduino.digital_write ULTRASONIC_TRIGGER, true
    sleep 0.01
    arduino.digital_write ULTRASONIC_TRIGGER, false


    puts arduino.sysex 0x74, [ULTRASONIC_ECHO, 1]
  end

  def rear_distance
    @rear_distance = arduino.digital_read 2
    @rear_distance
  end


end