module Capoblo
  class ArduinoMoves

    attr_accessor :arduino

    MIN_POWER = 60

    ## For Two Motors
    LEFT_DIGITAL_BACKWARD = 5    # Input3 connected to pin 5
    LEFT_DIGITAL_FORWARD = 4    # Input4 connected to pin 4
    LEFT_ANALOG_SIGNAL = 3    # ENB connected to pin 3 of Arduino
    RIGHT_DIGITAL_BACKWARD = 8    # Input3 connected to pin 5
    RIGHT_DIGITAL_FORWARD = 7    # Input4 connected to pin 4
    RIGHT_ANALOG_SIGNAL = 6    # ENB connected to pin 3 of Arduino


    def initialize
      super
      self.arduino = ARDUINO_ONE

      ## For Two Motors
      self.arduino.pin_mode LEFT_DIGITAL_BACKWARD, ArduinoFirmata::OUTPUT
      self.arduino.pin_mode LEFT_DIGITAL_FORWARD, ArduinoFirmata::OUTPUT
      self.arduino.pin_mode LEFT_ANALOG_SIGNAL, ArduinoFirmata::OUTPUT
      self.arduino.pin_mode RIGHT_DIGITAL_BACKWARD, ArduinoFirmata::OUTPUT
      self.arduino.pin_mode RIGHT_DIGITAL_FORWARD, ArduinoFirmata::OUTPUT
      self.arduino.pin_mode RIGHT_ANALOG_SIGNAL, ArduinoFirmata::OUTPUT

    end

    def run_forward(power = MIN_POWER, times = 0)
      set_all_forward
      if times == 0
        soft_run true, power
      else
        soft_run true, power
        sleep times
        stop_all
      end
    end

    def run_backward(power = MIN_POWER, times = 0)
      set_all_backward
      if times == 0
        soft_run true, power
      else
        soft_run true, power
        sleep times
        stop_all
      end
    end

    def rotate_clockwise
      set_left_forward
      set_right_backward
      soft_run
    end

    def rotate_anticlockwise
      set_left_backward
      set_right_forward
      soft_run
    end

    def turn_right(times = 3)
      set_left_forward
      set_right_forward
      run(LEFT_ANALOG_SIGNAL, 125)
      run(RIGHT_ANALOG_SIGNAL, 65)
      sleep times
    end


    def turn_left(times = 3)
      set_left_forward
      set_right_forward
      run(LEFT_ANALOG_SIGNAL, 65)
      run(RIGHT_ANALOG_SIGNAL, 125)
      sleep times
    end

    def turn_back_right(times = 3)
      set_left_backward
      set_right_backward
      run(LEFT_ANALOG_SIGNAL, 125)
      run(RIGHT_ANALOG_SIGNAL, 65)
      sleep times
    end

    def turn_back_left(times = 3)
      set_left_backward
      set_right_backward
      run(LEFT_ANALOG_SIGNAL, 65)
      run(RIGHT_ANALOG_SIGNAL, 125)
      sleep times
    end


    def stop_all
      run(LEFT_ANALOG_SIGNAL, 0)
      run(RIGHT_ANALOG_SIGNAL, 0)
      arduino.digital_write LEFT_DIGITAL_BACKWARD, false
      arduino.digital_write LEFT_DIGITAL_FORWARD, true
      arduino.digital_write RIGHT_DIGITAL_BACKWARD, false
      arduino.digital_write RIGHT_DIGITAL_FORWARD, true
    end

    private
    def soft_run(is_continues = false, max_power = 145)
      if is_continues
        MIN_POWER.upto(max_power).each do |val|
          run(LEFT_ANALOG_SIGNAL, val)
          run(RIGHT_ANALOG_SIGNAL, val)
          sleep 0.01
        end
      else
        MIN_POWER.upto(max_power).each do |val|
          run(LEFT_ANALOG_SIGNAL, val)
          run(RIGHT_ANALOG_SIGNAL, val)
          sleep 0.01
        end
        max_power.downto(MIN_POWER).each do |val|
          run(LEFT_ANALOG_SIGNAL, val)
          run(RIGHT_ANALOG_SIGNAL, val)
          sleep 0.01
        end
        stop_all
      end
    end

    def run(depending_pin, power = MIN_POWER)
      arduino.analog_write depending_pin, power
    end

    def set_left_forward
      arduino.digital_write LEFT_DIGITAL_BACKWARD, false
      arduino.digital_write LEFT_DIGITAL_FORWARD, true
    end

    def set_right_forward
      arduino.digital_write RIGHT_DIGITAL_BACKWARD, false
      arduino.digital_write RIGHT_DIGITAL_FORWARD, true
    end

    def set_all_forward
      set_left_forward
      set_right_forward
    end

    def set_left_backward
      arduino.digital_write LEFT_DIGITAL_BACKWARD, true
      arduino.digital_write LEFT_DIGITAL_FORWARD, false
    end

    def set_right_backward
      arduino.digital_write RIGHT_DIGITAL_BACKWARD, true
      arduino.digital_write RIGHT_DIGITAL_FORWARD, false
    end

    def set_all_backward
      set_left_backward
      set_right_backward
    end

  end
end