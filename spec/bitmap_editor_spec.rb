require 'bitmap_editor'
require 'pry'

describe BitmapEditor do
	before do
		@editor = BitmapEditor.new
	end

	describe "#new_image" do
		context "given the numbers 5, 6" do
			it "returns a 2D array with 5 columns and 6 rows" do

				@test_bitmap = @editor.new_image(5,6)
				expect(@test_bitmap).to eql([['O','O','O','O','O'],
																		['O','O','O','O','O'],
																		['O','O','O','O','O'],
																		['O','O','O','O','O'],
																		['O','O','O','O','O'],
																		['O','O','O','O','O']])
			end
		end

		context "given the numbers 2, 4" do
			it "returns a 2D array with 2 columns and 4 rows" do
				@test_bitmap = @editor.new_image(2,4)
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
				@editor.colour_px(1,3,'A')
				expect(@editor.bitmap).to eql([['O','O','O','O','O'],
																		['O','O','O','O','O'],
																		['A','O','O','O','O'],
																		['O','O','O','O','O'],
																		['O','O','O','O','O'],
																		['O','O','O','O','O']])
			end
		end
	end
end