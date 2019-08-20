grammar NCalc;

@parser::header {
using System.Globalization;
using NCalc.Domain;
}

@parser::members {
private const char BS = '\\';
private static NumberFormatInfo numberFormatInfo = new NumberFormatInfo();

private string extractString(string text) {
    
    StringBuilder sb = new StringBuilder(text);
    int startIndex = 1; // Skip initial quote
    int slashIndex = -1;

    while ((slashIndex = sb.ToString().IndexOf(BS, startIndex)) != -1)
    {
        char escapeType = sb[slashIndex + 1];
        switch (escapeType)
        {
            case 'u':
              string hcode = String.Concat(sb[slashIndex+4], sb[slashIndex+5]);
              string lcode = String.Concat(sb[slashIndex+2], sb[slashIndex+3]);
              char unicodeChar = Encoding.Unicode.GetChars(new byte[] { System.Convert.ToByte(hcode, 16), System.Convert.ToByte(lcode, 16)} )[0];
              sb.Remove(slashIndex, 6).Insert(slashIndex, unicodeChar); 
              break;
            case 'n': sb.Remove(slashIndex, 2).Insert(slashIndex, '\n'); break;
            case 'r': sb.Remove(slashIndex, 2).Insert(slashIndex, '\r'); break;
            case 't': sb.Remove(slashIndex, 2).Insert(slashIndex, '\t'); break;
            case '\'': sb.Remove(slashIndex, 2).Insert(slashIndex, '\''); break;
            case '\\': sb.Remove(slashIndex, 2).Insert(slashIndex, '\\'); break;
            default: throw new FailedPredicateException(this,"Unvalid escape sequence: \\" + escapeType);
        }

        startIndex = slashIndex + 1;

    }

    sb.Remove(0, 1);
    sb.Remove(sb.Length - 1, 1);

    return sb.ToString();
}

public List<string> Errors { get; set; }
}

@init {
    numberFormatInfo.NumberDecimalSeparator = ".";
}

ncalcExpression returns [LogicalExpression val]
	: logicalExpression EOF {$val = $logicalExpression.val; }
	;

logicalExpression returns [LogicalExpression val]
	:	left=conditionalExpression { $val = $left.val; } ( WS* '?' WS* middle=conditionalExpression WS* ':' WS* right=conditionalExpression { $val = new TernaryExpression($left.val, $middle.val, $right.val); })? 
	;

conditionalExpression returns [LogicalExpression val]
@init {
BinaryExpressionType type = BinaryExpressionType.Unknown;
}
	:	left=booleanExpression { $val = $left.val; } (
			( ('&&' | 'and') { type = BinaryExpressionType.And; } 
			| ('||' | 'or') { type = BinaryExpressionType.Or; } )
			right=booleanExpression { $val = new BinaryExpression(type, $val, $right.val); }
			)* 
	;
		
booleanExpression returns [LogicalExpression val]
@init {
BinaryExpressionType type = BinaryExpressionType.Unknown;
}
	:	left=relationalExpression { $val = $left.val; } (
			( '&' { type = BinaryExpressionType.BitwiseAnd; } 
			| '|' { type = BinaryExpressionType.BitwiseOr; }
			| '^' { type = BinaryExpressionType.BitwiseXOr; } )
			right=relationalExpression { $val = new BinaryExpression(type, $val, $right.val); } 
			)* 
	;

relationalExpression returns [LogicalExpression val]
@init {
BinaryExpressionType type = BinaryExpressionType.Unknown;
}
	:	left=shiftExpression { $val = $left.val; } (
			( ('==' | '=' ) { type = BinaryExpressionType.Equal; } 
			| ('!=' | '<>' ) { type = BinaryExpressionType.NotEqual; } 
			| '<' { type = BinaryExpressionType.Lesser; } 
			| '<=' { type = BinaryExpressionType.LesserOrEqual; }  
			| '>' { type = BinaryExpressionType.Greater; } 
			| '>=' { type = BinaryExpressionType.GreaterOrEqual; } ) 
			right=shiftExpression { $val = new BinaryExpression(type, $val, $right.val); } 
			)* 
	;

shiftExpression returns [LogicalExpression val]
@init {
BinaryExpressionType type = BinaryExpressionType.Unknown;
}
	: left=additiveExpression { $val = $left.val; } (
			( '<<' { type = BinaryExpressionType.LeftShift; } 
			| '>>' { type = BinaryExpressionType.RightShift; }  )
			right=additiveExpression { $val = new BinaryExpression(type, $val, $right.val); } 
			)* 
	;

additiveExpression returns [LogicalExpression val]
@init {
BinaryExpressionType type = BinaryExpressionType.Unknown;
}
	:	left=multiplicativeExpression { $val = $left.val; } (
			( '+' { type = BinaryExpressionType.Plus; } 
			| '-' { type = BinaryExpressionType.Minus; } ) 
			right=multiplicativeExpression { $val = new BinaryExpression(type, $val, $right.val); } 
			)* 
	;

multiplicativeExpression returns [LogicalExpression val]
@init {
BinaryExpressionType type = BinaryExpressionType.Unknown;
}
	:	left=unaryExpression { $val = $left.val; } (
			( '*' { type = BinaryExpressionType.Times; } 
			| '/' { type = BinaryExpressionType.Div; } 
			| '%' { type = BinaryExpressionType.Modulo; } )
			right=unaryExpression { $val = new BinaryExpression(type, $val, $right.val); } 
			)* 
	;

	
unaryExpression returns [LogicalExpression val]
	:	WS* ( primaryExpression { $val = $primaryExpression.val; }
    	|	('!' | 'not') primaryExpression { $val = new UnaryExpression(UnaryExpressionType.Not, $primaryExpression.val); }
    	|	('~') primaryExpression { $val = new UnaryExpression(UnaryExpressionType.BitwiseNot, $primaryExpression.val); }
    	|	'-' primaryExpression { $val = new UnaryExpression(UnaryExpressionType.Negate, $primaryExpression.val); } ) WS*
   	;
		
primaryExpression returns [LogicalExpression val]
	:	'(' logicalExpression ')' 	{ $val = $logicalExpression.val; }
	|	expr=value		{ $val = $expr.val; }
	|	identifier {$val = (LogicalExpression) $identifier.val; } (arguments {$val = new Function($identifier.val, ($arguments.val).ToArray()); })?
	;

value returns [ValueExpression val]
	:	FLOAT		{ $val = new ValueExpression(double.Parse($FLOAT.text, NumberStyles.Float, numberFormatInfo)); }
	| 	INTEGER		{ try { $val = new ValueExpression(int.Parse($INTEGER.text)); } catch(System.OverflowException) { $val = new ValueExpression(long.Parse($INTEGER.text)); } }
	|	STRING		{ $val = new ValueExpression(extractString($STRING.text)); }
	| 	DATETIME	{ $val = new ValueExpression(DateTime.Parse($DATETIME.text.Substring(1, $DATETIME.text.Length-2))); }
	|	TRUE		{ $val = new ValueExpression(true); }
	|	FALSE		{ $val = new ValueExpression(false); }
	;

identifier returns[Identifier val]
	: 	ID { $val = new Identifier($ID.text); }
	| 	NAME { $val = new Identifier($NAME.text.Substring(1, $NAME.text.Length-2)); }
	;

expressionList returns [List<LogicalExpression> val]
@init {
List<LogicalExpression> expressions = new List<LogicalExpression>();
}
	:	first=logicalExpression {expressions.Add($first.val);}  ( WS* ',' WS* follow=logicalExpression {expressions.Add($follow.val);})* 
	{ $val = expressions; }
	;
	
arguments returns [List<LogicalExpression> val]
@init {
$val = new List<LogicalExpression>();
}
	:	'(' ( expressionList {$val = $expressionList.val;} )? ')' 
	;			

TRUE
	:	'true'
	;

FALSE
	:	'false'
	;
			
ID 
	: 	LETTER (LETTER | DIGIT)*
	;

FLOAT 
	:	DIGIT* '.' DIGIT+ E?
	|	DIGIT+ E
	;

INTEGER
	:	DIGIT+
	;

STRING
	:  	'\'' ( EscapeSequence | ~('\u0000'..'\u001f' | '\\' | '\'' ) )*? '\''
	;

DATETIME 
 	:	'#' .*? '#'
        ;

NAME	:	'[' (~('[' | ']') | NAME)*? ']'
	;

E	:	('E'|'e') ('+'|'-')? DIGIT+ 
	;	

fragment LETTER
	:	'a'..'z'
	|	'A'..'Z'
	|	'_'
	;

fragment EscapeSequence 
	:	'\\'
  	(	
  		'n' 
	|	'r' 
	|	't'
	|	'\'' 
	|	'\\'
	|	UnicodeEscape
	)
  ;

fragment UnicodeEscape
	:    'u' HexDigit HexDigit HexDigit HexDigit ;

fragment HexDigit 
	: 	DIGIT|'a'..'f'|'A'..'F' ;

fragment DIGIT
	:	'0'..'9' ;

/* Ignore white spaces */	
WS	:  (' '|'\r'|'\t'|'\u000C'|'\n')
	;
