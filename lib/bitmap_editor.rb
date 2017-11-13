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
      command = line[0]
      case command
      when 'I'
        if array_line.length == 3 && check_params(line, 3)
          @bitmap = Bitmap.new(array_line[1].to_i, array_line[2].to_i)
        else
          return invalid_msg(line)
        end
      when 'L'
        if array_line.length == 4 && check_params(line, 4)
          @bitmap.colour_px(array_line[1].to_i, array_line[2].to_i, array_line[3])
        else
          return invalid_msg(line)
        end
      when 'V'
        if array_line.length == 5 && check_params(line, 5)
          @bitmap.colour_vertical_px(array_line[1].to_i, array_line[2].to_i, array_line[3].to_i, array_line[4])
        else
          return invalid_msg(line)
        end
      when 'H'
        if array_line.length == 5 && check_params(line, 5)
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

  def check_params(line, num)
    if num == 3
      line = line.delete(' ')
      line =~ /^[A-Z]\d{2,4}$/
    elsif num == 4
      line = line.delete(' ')
      line =~ /^[A-Z]\d{2,6}[A-Z]$/
    elsif num == 5
      line = line.delete(' ')
      line =~ /^[A-Z]\d{3,9}[A-Z]$/
    else 
      false
    end
  end

  def invalid_msg(line)
    print "#{ line } is an invalid command"
  end
end
