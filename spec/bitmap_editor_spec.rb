require 'bitmap_editor'
require 'pry'

describe BitmapEditor do
	before do
		@editor = BitmapEditor.new
	end

	describe "#new_image" do
		context "given the numbers 5, 6" do

			it "returns a 2D array with 5 columns and 6 rows" do
				@editor.new_image(5, 6)
				expect(@editor.bitmap).to eql([['O','O','O','O','O'],
																		['O','O','O','O','O'],
																		['O','O','O','O','O'],
																		['O','O','O','O','O'],
																		['O','O','O','O','O'],
																		['O','O','O','O','O']])
			end
		end

		context "given the numbers 2, 4" do

			it "returns a 2D array with 2 columns and 4 rows" do
				@test_bitmap = @editor.new_image(2, 4)
				expect(@test_bitmap).to eql([['O','O'],
																		['O','O'],
																		['O','O'],
																		['O','O']])
			end
		end
	end

	before do
		@editor.bitmap = Array.new(6) { Array.new(5, 'O') }
	end

	describe "#colour_px" do
		context "given the input 1, 3, 'A'" do

			it "sets the first element in the third array to 'A'" do
				@editor.colour_px(1, 3, 'A')
				expect(@editor.bitmap).to eql([['O','O','O','O','O'],
																		['O','O','O','O','O'],
																		['A','O','O','O','O'],
																		['O','O','O','O','O'],
																		['O','O','O','O','O'],
																		['O','O','O','O','O']])
			end
		end
	end

	describe "#colour_vertical_px" do
		context "given the input 2, 3, 6, 'W'" do

			it "changes the elements in column 2 in rows 3 to 6 to 'W inclusively" do
				@editor.colour_vertical_px(2, 3, 6, 'W')
				expect(@editor.bitmap).to eql([['O','O','O','O','O'],
																		['O','O','O','O','O'],
																		['O','W','O','O','O'],
																		['O','W','O','O','O'],
																		['O','W','O','O','O'],
																		['O','W','O','O','O']])
			end
		end
	end

	describe "#colour_horizontal_px" do
		context "given the input 3, 5, 2, 'Z'" do

			it "changes the elements in columns 3 to 5 in row 2 to 'Z' inclusively" do
				@editor.colour_horizontal_px(3, 5, 2, 'Z')
				expect(@editor.bitmap).to eql([['O','O','O','O','O'],
																		['O','O','Z','Z','Z'],
																		['O','O','O','O','O'],
																		['O','O','O','O','O'],
																		['O','O','O','O','O'],
																		['O','O','O','O','O']])
			end
		end
	end

	describe "#clear" do
		it "sets each element in bitmap to 'O'" do
			@editor.bitmap = Array.new(2) { Array.new(3, 'Z')}
			@editor.clear
			expect(@editor.bitmap).to eql([['O','O','O'],
																		['O','O','O']])
		end
	end

	describe "#run" do
		context "if an none existing file is used" do
			it "should throw an exception" do
				expect { @editor.run('unexistant_file') }.to raise_error { |error|
      expect(error).to be_a(StandardError) }
			end
		end
	end

	before do
		test_file = open("examples/test.txt", "w")
	end

	describe "new M x N image command" do
		context "if the command is larger than 3" do
			it "returns an error message" do
				test_file = open("examples/test.txt", "w")
				test_file.puts "I 3 4 5"
				test_file.close
				# binding.pry
				expect(@editor.run(test_file)).to eql("I 3 4 5 is invalid command")
			end
		end
	end

end