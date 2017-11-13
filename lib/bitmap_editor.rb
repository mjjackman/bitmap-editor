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
    file.each do |line|
      line = line.chomp
      line.delete! ' '
      command = line[0]
      case command
      when 'I'
        if line.length == 3 && check_params(line, 3)
          @bitmap = Bitmap.new(line[1].to_i, line[2].to_i)
        else
          return invalid_msg(line)
        end
      when 'L'
        if line.length == 4 && check_params(line, 4)
          @bitmap.colour_px(line[1].to_i, line[2].to_i, line[3])
        else
          return invalid_msg(line)
        end
      when 'V'
        if line.length == 5 && check_params(line, 5)
          @bitmap.colour_vertical_px(line[1].to_i, line[2].to_i, line[3].to_i, line[4])
        else
          return invalid_msg(line)
        end
      when 'H'
        if line.length == 5 && check_params(line, 5)
          @bitmap.colour_horizontal_px(line[1].to_i, line[2].to_i, line[3].to_i, line[4])
        else
          return invalid_msg(line)
        end
      when 'C'
        clear
      when 'S'
          puts @bitmap.show
      else
          puts 'unrecognised command :('
      end
    end
  end

  def check_params(line, num)
    if num == 3
      line =~ /[A-Z][0-9]{2}/
    elsif num == 4
      line =~ /[A-Z][0-9]{2}[A-Z]/
    elsif num == 5
      line =~ /[A-Z][0-9]{3}[A-Z]/
    else 
      false
    end
  end

  def invalid_msg(line)
    print "#{ line } is an invalid command"
  end
end
