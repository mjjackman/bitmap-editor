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
      case array_line[0]
      when 'I'
        if params_order(command: 'I', params_num: array_line.length, a: array_line[1].to_i, b: array_line[2].to_i) && check_params(line)
          @bitmap = Bitmap.new(array_line[1].to_i, array_line[2].to_i)
        else
          return invalid_msg(line)
        end
      when 'L'
        if params_order(command: 'L', params_num: array_line.length, a: array_line[1].to_i, b: array_line[2].to_i) && check_params(line)
          @bitmap.colour_px(array_line[1].to_i, array_line[2].to_i, array_line[3])
        else
          return invalid_msg(line)
        end
      when 'V'
        if params_order(command: 'V', parmas_num: array_line.length, a: array_line[1].to_i, b: array_line[2].to_i, c: array_line[3].to_i, d: array_line[4].to_i) && check_params(line)
          @bitmap.colour_vertical_px(array_line[1].to_i, array_line[2].to_i, array_line[3].to_i, array_line[4])
        else
          return invalid_msg(line)
        end
      when 'H'
        if params_order(command: 'H', parmas_num: array_line.length, a: array_line[1].to_i, b: array_line[2].to_i, c: array_line[3].to_i, d: array_line[4].to_i) && check_params(line)
          @bitmap.colour_horizontal_px(array_line[1].to_i, array_line[2].to_i, array_line[3].to_i, array_line[4])
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

  def params_order(args)
    if args[:command] == 'I' && args[:params_num] == 3
      args[:a] > 0 && args[:a] <= 250 && args[:b] > 0 && args[:b] <= 250
    elsif args[:command] == 'L' && args[:params_num] == 4
      args[:a] < args[:b] && args[:b] <= @bitmap.n
    elsif args[:command] == 'V' && args[:parmas_num] == 5
      args[:a] <= @bitmap.m && args[:b] < args[:c] && args[:d] <= @bitmap.n
    elsif args[:command] == 'H' && args[:parmas_num] == 5
      args[:a] < args[:b] && args[:b] <= @bitmap.m && args[:c] <= @bitmap.n
    else
      false
    end
  end

  def invalid_msg(line)
    print "#{ line } is an invalid command"
  end
end
