# Makefile for our Driver class to run our Scanner
# This gets called by the bash script: Micro.sh

Driver.class: Driver.java Little.g4
	@antlr4 Little.g4
	@javac LittleLexer.java
	@javac LittleParser.java
	@javac Driver.java

.PHONY: clean
clean :
	@echo "Cleaning up..."
	@rm *.class *.tokens Little*.java

