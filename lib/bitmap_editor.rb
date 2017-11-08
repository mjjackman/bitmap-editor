class BitmapEditor
  attr_accessor :bitmap

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      line.delete! ' '
      command = line[0]
      case command
      when 'I'
        print @bitmap = new_image(line[1].to_i, line[2].to_i)
      when 'S'
          puts "There is no image"
      else
          puts 'unrecognised command :('
      end
    end
  end

  def new_image(m, n)
    matrix = Array.new(n) { Array.new(m, 'O') }
  end
end
