// CSCI 468
// Chris Cooper, Spencer Lawry, Matthew Gober

import java.io.*;
import java.util.*;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.ParseTree;

public class Driver {

    public static void main(String[] args) throws Exception {
        String fileName = args[0];
        String outputName = "output.txt";
        FileWriter myWriter = new FileWriter(outputName);

        try {
            // create the grammar from CharStream interface
            LittleLexer grammar = new LittleLexer(CharStreams.fromFileName(fileName));
            // create the token stream and set channel to 0 to pull tokens instead of default channel
            // (default doesn't pull tokens correctly)
            CommonTokenStream tokens = new CommonTokenStream(grammar, 0);
            // create list of tokens and utilize the Vocabulary interface to return string associated with token
            List<Token> tokenList = tokens.getTokens();
            Vocabulary vocab = grammar.getVocabulary();

            int errors;
            LittleParser myParser= new LittleParser(tokens);
            ParseTree tree = myParser.start();
//            myParser.getInputStream(tokens);
            errors = myParser.getNumberOfSyntaxErrors();
            if(errors > 0){
                System.out.println("Not accepted");
                myWriter.write("Not accepted");
            }
            else{
                System.out.println("Accepted");
                myWriter.write("Accepted");
            }


//            for(int i=0; i < tokenList.size(); i++){
//                int type = tokenList.get(i).getType();
//
//                // EOF is 0, so exclude it from output
//                //removed appends
//                if (type > 0) {
//                    String symbol = vocab.getSymbolicName(type);
////                    System.out.println("Token Type: " + symbol);
////                    System.out.println("Value: " + tokenList.get(i).getText());
//
////                    myWriter.write("Token Type: " + symbol +"\n" + "Value: " + tokenList.get(i).getText() +"\n");
//
//                }
//            }

            myWriter.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
