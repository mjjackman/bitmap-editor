require './lib/bitmap'
require 'pry'

class BitmapEditor
  attr_accessor :bitmap

  def run(file_name)
    begin
      file = open(file_name)
    rescue StandardError=>e
      raise StandardError
      puts "Error: #{e}"
      return 
    end
    return puts "This file has no commands!!" if File.zero?(file)
    file.each do |line|
      line = line.chomp
      array_line = line.split(' ')
      array_line.map! {|i| i =~ /[A-Z]/ ? i : i.to_i}
      case array_line[0]
      when 'I'
        if params_order(line_hash(array_line)) && check_params(line) && array_line.length == 3
          @bitmap = Bitmap.new(array_line[1], array_line[2])
        else
          return invalid_msg(line)
        end
      when 'L'
        if params_order(line_hash(array_line)) && check_params(line) && array_line.length == 4
          @bitmap.colour_px(array_line[1], array_line[2], array_line[3])
        else
          return invalid_msg(line)
        end
      when 'V'
        if params_order(line_hash(array_line)) && check_params(line) && array_line.length == 5
          @bitmap.colour_vertical_px(array_line[1], array_line[2], array_line[3], array_line[4])
        else
          return invalid_msg(line)
        end
      when 'H'
        if params_order(line_hash(array_line)) && check_params(line) && array_line.length == 5
          @bitmap.colour_horizontal_px(array_line[1], array_line[2], array_line[3], array_line[4])
        else
          return invalid_msg(line)
        end
      when 'C'
        @bitmap.clear
      when 'S'
          puts @bitmap.show
      else
          puts 'unrecognised command :('
      end
    end
  end

  def check_params(line)
    line = line.delete(' ')
    if line[0] == 'I'
      line =~ /^[A-Z]\d{2,4}$/
    elsif line[0] == 'L'
      line =~ /^[A-Z]\d{2,6}[A-Z]$/
    elsif line[0] == 'V' || line[0] == 'H'
      line =~ /^[A-Z]\d{3,9}[A-Z]$/
    else 
      false
    end
  end

  def line_hash(command_line)
    key = [:command, :a, :b, :c]
    command_hash = Hash[key.zip command_line]
    command_hash.delete_if { |key, value| value.to_s.strip == '' }
  end

  def params_order(args)
    if args[:command] == 'I'
      args[:a] > 0 && args[:a] <= 250 && args[:b] > 0 && args[:b] <= 250
    elsif args[:command] == 'L'
      args[:a] < args[:b] && args[:b] <= @bitmap.n
    elsif args[:command] == 'V'
      args[:a] <= @bitmap.m && args[:b] < args[:c] && args[:c] <= @bitmap.n
    elsif args[:command] == 'H'
      args[:a] < args[:b] && args[:b] <= @bitmap.m && args[:c] <= @bitmap.n
    else
      false
    end
  end

  def invalid_msg(line)
    print "#{ line } is an invalid command"
  end
end
