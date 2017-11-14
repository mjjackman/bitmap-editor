require 'bitmap_editor'
require 'pry'

describe BitmapEditor do
	before do
		@editor = BitmapEditor.new
	end

	describe "#run" do
		context "if an none existing file is used" do
			it "should throw an exception" do
				expect { @editor.run('unexistant_file') }.to raise_error { |error|
      expect(error).to be_a(StandardError) }
			end
		end
	end

	describe "new M x N image command" do
		context "if the command has more than 2 params" do
			it "returns an error message" do
				test_file = open("examples/test.txt", "w")
				test_file.puts "I 3 4 5"
				test_file.close
				expect do
					@editor.run(test_file)
				end.to output("I 3 4 5 is an invalid command").to_stdout
			end
		end
	end

	describe "command for changing the colour a given pixel" do
		context "if the command is not equal to 4" do
			it "returns an error message" do
				test_file = open("examples/test.txt", "w")
				test_file.puts "L 3 5"
				test_file.close
				expect do
					@editor.run(test_file)
				end.to output("L 3 5 is an invalid command").to_stdout			
			end
		end
	end

	describe "command for vertical colour changing" do
		context "if the command is not equal to 5" do
			it "returns an error message" do
				test_file = open("examples/test.txt", "w")
				test_file.puts "V 4 5 6 7 8 9"
				test_file.close
				expect do
					@editor.run(test_file)
				end.to output("V 4 5 6 7 8 9 is an invalid command").to_stdout
			end
		end
	end

	describe "command for horizontal colour changing" do
		context "if the command is not equal to 5" do
			it "returns an error message" do
				test_file = open("examples/test.txt", "w")
				test_file.puts "H 4 5 6 7 8"
				test_file.close
				expect do
					@editor.run(test_file)
				end.to output("H 4 5 6 7 8 is an invalid command").to_stdout
			end
		end
	end

	describe "#check_params" do
		context "validates the command has the correct number of params" do
			it "returns truthy if params are correct" do
				command1 = "H 3 5 2 Z"
				command2 = "H 10 13 4 J"
				command3 = "H 10 14 700000 k"
				expect(@editor.check_params(command1)).to be_truthy
				expect(@editor.check_params(command2)).to be_truthy
				expect(@editor.check_params(command3)).not_to be_truthy
			end
		end
	end

	before do
		@editor = BitmapEditor.new
		test_file = open("examples/test.txt", "w")
		test_file.puts 'I 7 8'
		test_file.close
		@editor.run(test_file)
	end

	describe "#params_order" do
		context "checks that the params are in the correct order and don't
					exceed the size of the bitmap" do
			it "returns true if the params are correct" do
				command1 = {command: 'I', params_num: 3, a: 0, b: 4}
				command2 = {command: 'L', params_num: 4, a: 9, b: 3}
				command3 = {command: 'V', parmas_num: 5, a: 3, b: 5, c: 6, d:7}
				expect(@editor.params_order(command1)).to be false
				expect(@editor.params_order(command2)).to be false
				expect(@editor.params_order(command3)).to be true
			end
		end
	end
end