require 'bitmap'

describe Bitmap do
	before do
		@bitmap = Bitmap.new(5, 6)
	end

	describe "#colour_px" do
		context "given the input 1, 3, 'A'" do

			it "sets the first element in the third array to 'A'" do
				@bitmap.colour_px(1, 3, 'A')
				expect(@bitmap.bitmap).to eql([['O','O','O','O','O'],
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
				@bitmap.colour_vertical_px(2, 3, 6, 'W')
				expect(@bitmap.bitmap).to eql([['O','O','O','O','O'],
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
				@bitmap.colour_horizontal_px(3, 5, 2, 'Z')
				expect(@bitmap.bitmap).to eql([['O','O','O','O','O'],
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
			@bitmap = Bitmap.new(3, 2)
			@bitmap.colour_horizontal_px(1, 3, 1, 'Z')
			@bitmap.clear
			expect(@bitmap.bitmap).to eql([['O','O','O'],
																		['O','O','O']])
		end
	end
end