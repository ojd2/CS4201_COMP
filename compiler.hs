type Id = String
--type Env = [(Id,Expr)]

-- <program> ::= 
--		   	"program" <id> ":" <pars>  "."			(Skel program)
-- Program type is defined = takes the following expressions of "Id" or "Pars"
data Program = Program 				Id Pars
	    deriving Show



-- <pars> ::= 
--		   	<par> [";" <pars>] 						(Parallel statements)
-- Pars type is defined = takes the following expression "Par".
-- Alternative options are "Pars"
data Pars = Par  					Par
	| Pars 							Pars
	    deriving Show



-- <par> ::=
--			"func" <id> <structs>					(Structed expression)
--			<pars> "||" <pars>						(Parallel pipleline)
--			"farm" <int> <pars>						(Task Farm)
-- Par type is defined = takes the following expressions "ParId".
-- Alternative options are "ParStruct"
data Par = 	ParId					Id Structs
	    deriving Show
-- Have left Pipeline and Task Farm for now.




-- <structs> ::=
--			<struct> [";" <structs>]				(Statements)
-- Structs type is defined = takes the following expressions "Struct" and "StructAlt"
data Structs = 	Struct				Struct
	| StructSeperator				Struct Structs
	    deriving Show



-- <struct> ::=
--				<exprs>									(Expression)
-- |			<structs> "•" <structs>					(Composition)
-- |			"iter"	<int> <structs>					(Iteration)

-- Struct type is defined = takes the following expressions "Exprs"
-- Alternative options are "StructComp" and "StructIt"
data Struct = 	StructExp			Exprs
	| StructComp					Structs Structs
	| StructIt						Int Structs
	    deriving Show



-- <expr> ["," <exprs>]								(Expressions)
-- Exprs type is defined = takes the following expressions "Expr"
-- Alternative options are "ExprAlt"
data Exprs = Expression 			Expr
	| ExprSeperator					Expr Exprs						
	    deriving Show


-- <expr> ::=
--				<int>									(integer value)
-- |			<string>								(String value)
-- |			<bool>									(Boolean value)
-- |			<id> [ "=" <exprs> ]					(Identifier / assignment)
-- |			"raise" <id> "=" <exprs>				(Raise exception)	
-- |			<exprs> "catch" <id> <id> ":" <exprs>	(Catch exception)
-- |			<exprs> <op> <exprs>					(Binary operator)
-- |			"(" <exprs> ")"							(Grouping)
-- Expr type is Already defined = takes the following alternatives:
data Expr = ExprInt 				Int
	| ExprString					String
	| ExprBool						Bool
	| ExprAssignment				Id Exprs
	| ExprRaise						Id Exprs
	| ExprCatch						Exprs Id Id Exprs
	| ExprOp						Exprs Op Exprs
	| ExprGroup						Exprs
	    deriving Show


-- <op> ::=
--			"+" | "*" | "-" | "div" | "<" | "<=" | "==" | "!="		(Operators)
-- Op type is defined = takes the following alternatives:
data Op = OpAdd
	| OpMultiply
	| OpMinus
	| OpDivide
	| OpLess
	| OpLessThanGreat
	| OpEqual
	| OpNotEqual
	    deriving Show	




-- Abstract syntax expression tests:

-- program printInt : string "int" and ExprInt of '42' int
-- printInt = Program "printInt" ( Par ( ParId "Int" ( Struct ( StructExp ( Expression ( ExprInt 42 ) ) )   ) ) )

-- program printString : func String "Hello World!".
-- printString = Program "printString" ( Par ( ParId "String" ( Struct ( StructExp ( Expression ( ExprString "Hello World!" ) ) )   ) ) )

-- program returnBoolTrue : func Bool True.
-- returnBoolTrue = Program "returnBoolTrue" ( Par ( ParId "Bool" ( Struct ( StructExp ( Expression ( ExprBool True  ) ) )   ) ) )

-- program returnBoolFalse : func Bool True.
-- returnBoolFalse = Program "returnBoolFalse" ( Par ( ParId "Bool" ( Struct ( StructExp ( Expression ( ExprBool False  ) ) )   ) ) )

-- program opAddInts : func OpAdd ExprInt 10, OpAdd ExprInt 10
-- opAddInts = Program "opAddInts" ( Par ( ParId "OpAdd" ( Struct ( StructExp ( Expression ( ExprOp (Expression (ExprInt 10) ) (OpAdd) (Expression (ExprInt 5) ) )  ) )  ) ) )

-- program opMinusInts : func OpMinus ExprInt 100, OpMinus ExprInt 35
-- opMinusInts = Program "opMinusInts" ( Par ( ParId "OpMinus" ( Struct ( StructExp ( Expression ( ExprOp (Expression (ExprInt 100) ) (OpMinus) (Expression (ExprInt 35) ) )  ) )  ) ) )

-- program opDivideInts : func OpMinus ExprInt 100, OpDivide ExprInt 35
opDivideInts = Program "opDivideInts" ( Par ( ParId "OpDivide" ( Struct ( StructExp ( Expression ( ExprOp (Expression (ExprInt 100) ) (OpDivide) (Expression (ExprInt 35) ) )  ) )  ) ) )

-- program opMultiplyInts : func String "Hello World!" func Int 42. return
-- opMultiplyInts = Program "opMultiplyInts" ( Par ( ParId "OpMultiply" ( Struct ( StructExp ( Expression ( ExprOp (Expression (ExprInt 235) ) (OpMultiply) (Expression (ExprInt 19) ) )  ) )  ) ) )

-- program printStringInts : func String "Hello World!" func Int 42. return
-- printStringInts = Program "printStringInts" ( Par ( ParId "ExprSeperator" ( Struct ( StructExp ( ExprSeperator (  ( ExprString "Hello World!" )   )  ( Expression ( ExprInt 42 ) )  )  )  ) ) )

-- program printStringBool : func String "Hello World!" func Int 42. return
-- printStringBool = Program "printStringBool" ( Par ( ParId "ExprSeperator" ( Struct ( StructExp ( ExprSeperator (  ( ExprString "Hello World!" )   )  ( Expression ( ExprBool True ) )  )  )  ) ) )


-- Print out programs above using AST declarations
main = print opDivideInts

