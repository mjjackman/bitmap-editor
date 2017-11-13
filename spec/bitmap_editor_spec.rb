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

	before do
		test_file = open("examples/test.txt", "w")
	end

	describe "new M x N image command" do
		context "if the command is not equal to 3" do
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

	describe '#check_params' do
		context "validates the command params" do
			it "returns truthy if params are correct" do
				command1 = "H 3 5 2 Z"
				command2 = "H 10 13 4 J"
				command3 = "H 10 14 700000 k"
				expect(@editor.check_params(command1, 5)).to be_truthy
				expect(@editor.check_params(command2, 5)).to be_truthy
				expect(@editor.check_params(command3, 5)).not_to be_truthy
			end
		end
	end
end