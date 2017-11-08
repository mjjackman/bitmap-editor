require 'bitmap_editor'

describe BitmapEditor do
	describe "#new_image" do
		context "given the numbers 5, 6" do
			it "returns a 2D array with 5 columns and 6 rows" do

				@bitmap = BitmapEditor.new.new_image(5,6)
				expect(@bitmap).to eql([['O','O','O','O','O'],['O','O','O','O','O'],['O','O','O','O','O'],['O','O','O','O','O'],['O','O','O','O','O'],['O','O','O','O','O']])
			end
		end

		context "given the numbers 2, 4" do
			it "returns a 2D array with 2 columns and 4 rows" do
				@bitmap = BitmapEditor.new.new_image(2,4)
				expect(@bitmap).to eql([['O','O'],['O','O'],['O','O'],['O','O']])
			end
		end
	end
end