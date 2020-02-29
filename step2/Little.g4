// Define a grammar called Little.g4


grammar Little;

options
{
	language = Java;
}

start				: program EOF ;

program				: PROGRAM id BEGIN pgm_body END ;
id					: IDENTIFIER ;
pgm_body			: decl func_declarations ;
decl				: string_decl decl
					| var_decl decl
					|;

// Global String Declaration
string_decl			: STRING id OPS_ASSIGN str OPS_SEMIC ;
str					: STRINGLITERAL ;

// Variable Declaration
var_decl			: var_type id_list OPS_SEMIC ;
var_type			: FLOAT
					| INT ;
any_type			: var_type
					| VOID ;
id_list				: id id_tail ;
id_tail				: OPS_COMMA id id_tail
					|;

// Functions
param_decl_list		: param_decl param_decl_tail
					|;
param_decl			: var_type id ;
param_decl_tail		: OPS_COMMA param_decl param_decl_tail
					|;

// Declarations
func_declarations	: func_decl func_declarations
					|;
func_decl			: FUNCTION any_type id OPS_LP param_decl_list OPS_RP BEGIN func_body END ;
func_body			: decl stmt_list ;

// Statement list
stmt_list			: stmt stmt_list
					|;
stmt				: base_stmt
					| if_stmt
					| while_stmt ;
base_stmt			: assign_stmt
					| read_stmt
					| write_stmt
					| return_stmt ;

// Basic statements
assign_stmt			: assign_expr OPS_SEMIC ;
assign_expr			: id OPS_ASSIGN expr ;
read_stmt			: READ OPS_LP id_list OPS_RP OPS_SEMIC ;
write_stmt			: WRITE OPS_LP id_list OPS_RP OPS_SEMIC ;
return_stmt			: RETURN expr OPS_SEMIC ;

// Expressions
expr				: expr_prefix factor;
expr_prefix			: expr_prefix factor addop
					|;
factor				: factor_prefix postfix_expr ;
factor_prefix		: factor_prefix postfix_expr mulop
					|;
postfix_expr		: primary
					| call_expr ;
call_expr			: id OPS_LP expr_list OPS_RP ;
expr_list			: expr expr_list_tail
					|;
expr_list_tail		: OPS_COMMA expr expr_list_tail
					|;
primary				: OPS_LP expr OPS_RP
					| id
					| INTLITERAL
					| FLOATLITERAL ;
addop				: OPS_PLUS
					| OPS_MINUS ;
mulop				: OPS_STAR
					| OPS_SLASH ;

// Complex Statements and Condition
if_stmt			: IF OPS_LP cond OPS_RP decl stmt_list else_part ENDIF ;
else_part		: ELSE decl stmt_list
				| ;
cond			: expr comop expr ;
comop			: OPS_LT
				| OPS_GT
				| OPS_EQUALS
				| OPS_NOT_EQUALS
				| OPS_LTE
				| OPS_GTE ;

/* While Statement */
while_stmt			: WHILE OPS_LP cond OPS_RP decl stmt_list ENDWHILE ;


// Keywords
PROGRAM			: 'PROGRAM' ;
BEGIN			: 'BEGIN' ;
END				: 'END' ;
FUNCTION		: 'FUNCTION' ;
READ			: 'READ' ;
WRITE			: 'WRITE' ;
IF				: 'IF' ;
ELSE			: 'ELSE' ;
ENDIF			: 'ENDIF' ;
WHILE			: 'WHILE' ;
ENDWHILE		: 'ENDWHILE' ;
CONTINUE		: 'CONTINUE' ;
BREAK			: 'BREAK' ;
RETURN			: 'RETURN' ;
INT				: 'INT' ;
VOID			: 'VOID' ;
STRING			: 'STRING' ;
FLOAT			: 'FLOAT' ;

//Operators
OPS_ASSIGN		: ':=' ;
OPS_PLUS			: '+' ;
OPS_MINUS		: '-' ;
OPS_STAR			: '*' ;
OPS_SLASH		: '/' ;
OPS_EQUALS		: '=' ;
OPS_NOT_EQUALS	: '!=' ;
OPS_LT			: '<' ;
OPS_GT			: '>' ;
OPS_LP			: '(' ;
OPS_RP			: ')' ;
OPS_SEMIC		: ';' ;
OPS_COMMA		: ',' ;
OPS_LTE			: '<=' ;
OPS_GTE			: '>=' ;

IDENTIFIER		: [a-zA-Z][a-zA-Z0-9]* ;
INTLITERAL		: [0-9]+ ;
FLOATLITERAL 	: [0-9]* '.' [0-9]+ ;
STRINGLITERAL	: '"' ~'"'* '"' ;
COMMENT			: '--' ~[\r\n]* [\r\n] -> skip ; //placed keywords above (line 104)
WHITESPACE		: (' '|'\t'|'\r'|'\n')+ -> skip ;
