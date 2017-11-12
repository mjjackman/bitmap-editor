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
          @bitmap = new_image(line[1].to_i, line[2].to_i)
        else
          return invalid_msg(line)
        end
      when 'L'
        if line.length == 4 && check_params(line, 4)
          colour_px(line[1].to_i, line[2].to_i, line[3])
        else
          return invalid_msg(line)
        end
      when 'V'
        if line.length == 5 && check_params(line, 5)
          colour_vertical_px(line[1].to_i, line[2].to_i, line[3].to_i, line[4])
        else
          return invalid_msg(line)
        end
      when 'H'
        if line.length == 5 && check_params(line, 5)
          colour_horizontal_px(line[1].to_i, line[2].to_i, line[3].to_i, line[4])
        else
          return invalid_msg(line)
        end
      when 'C'
        clear
      when 'S'
          puts @bitmap.map { |i| i.join(' ') }
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

  def new_image(m, n)
    matrix = Array.new(n) { Array.new(m, 'O') }
  end

  def colour_px(x, y, colour)
    @bitmap[y-1][x-1] = colour
  end

  def colour_vertical_px(x, y1, y2, colour)
    @bitmap[(y1-1)..(y2-1)].each {|i| i[x-1] = colour }
  end

  def colour_horizontal_px(x1, x2, y, colour)
    @bitmap[y-1][(x1-1)..(x2-1)] = @bitmap[y-1][(x1-1)..(x2-1)].fill(colour)
  end

  def clear
    @bitmap.each {|x| x.each {|y| y.replace('O')}}
  end
end
