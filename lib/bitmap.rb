class Bitmap
	attr_reader :bitmap, :m, :n

  def initialize(m, n)
    @m = m
    @n = n
    @bitmap = Array.new(n) { Array.new(m, 'O') }
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

  def show
    @bitmap.map { |i| i.join(' ') }
  end
end
