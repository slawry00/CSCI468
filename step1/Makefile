# Makefile for our Driver class to run our Scanner
# This gets called by the bash script: Micro.sh

Driver.class: Driver.java LittleLexer.class
	@javac Driver.java

LittleLexer.class: Little.g4
	@antlr4 Little.g4
	@javac LittleLexer.java

.PHONY: clean
clean :
	@echo "Cleaning up..."
	@rm *.class *.tokens Little*.java

