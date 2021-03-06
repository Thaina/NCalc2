//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     ANTLR Version: 4.7.1
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

// Generated from d:\Users\Admin\Documents\komodo\SSM\ss\app\NCalc2\grammer\NCalc.g by ANTLR 4.7.1

// Unreachable code detected
#pragma warning disable 0162
// The variable '...' is assigned but its value is never used
#pragma warning disable 0219
// Missing XML comment for publicly visible type or member '...'
#pragma warning disable 1591
// Ambiguous reference in cref attribute
#pragma warning disable 419


using System.Globalization;
using NCalc.Domain;

using Antlr4.Runtime.Misc;
using IParseTreeListener = Antlr4.Runtime.Tree.IParseTreeListener;
using IToken = Antlr4.Runtime.IToken;

/// <summary>
/// This interface defines a complete listener for a parse tree produced by
/// <see cref="NCalcParser"/>.
/// </summary>
[System.CodeDom.Compiler.GeneratedCode("ANTLR", "4.7.1")]
[System.CLSCompliant(false)]
public interface INCalcListener : IParseTreeListener {
	/// <summary>
	/// Enter a parse tree produced by <see cref="NCalcParser.ncalcExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterNcalcExpression([NotNull] NCalcParser.NcalcExpressionContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NCalcParser.ncalcExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitNcalcExpression([NotNull] NCalcParser.NcalcExpressionContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NCalcParser.logicalExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterLogicalExpression([NotNull] NCalcParser.LogicalExpressionContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NCalcParser.logicalExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitLogicalExpression([NotNull] NCalcParser.LogicalExpressionContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NCalcParser.conditionalExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterConditionalExpression([NotNull] NCalcParser.ConditionalExpressionContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NCalcParser.conditionalExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitConditionalExpression([NotNull] NCalcParser.ConditionalExpressionContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NCalcParser.booleanExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterBooleanExpression([NotNull] NCalcParser.BooleanExpressionContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NCalcParser.booleanExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitBooleanExpression([NotNull] NCalcParser.BooleanExpressionContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NCalcParser.relationalExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterRelationalExpression([NotNull] NCalcParser.RelationalExpressionContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NCalcParser.relationalExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitRelationalExpression([NotNull] NCalcParser.RelationalExpressionContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NCalcParser.shiftExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterShiftExpression([NotNull] NCalcParser.ShiftExpressionContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NCalcParser.shiftExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitShiftExpression([NotNull] NCalcParser.ShiftExpressionContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NCalcParser.additiveExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterAdditiveExpression([NotNull] NCalcParser.AdditiveExpressionContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NCalcParser.additiveExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitAdditiveExpression([NotNull] NCalcParser.AdditiveExpressionContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NCalcParser.multiplicativeExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterMultiplicativeExpression([NotNull] NCalcParser.MultiplicativeExpressionContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NCalcParser.multiplicativeExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitMultiplicativeExpression([NotNull] NCalcParser.MultiplicativeExpressionContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NCalcParser.unaryExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterUnaryExpression([NotNull] NCalcParser.UnaryExpressionContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NCalcParser.unaryExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitUnaryExpression([NotNull] NCalcParser.UnaryExpressionContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NCalcParser.primaryExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterPrimaryExpression([NotNull] NCalcParser.PrimaryExpressionContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NCalcParser.primaryExpression"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitPrimaryExpression([NotNull] NCalcParser.PrimaryExpressionContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NCalcParser.value"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterValue([NotNull] NCalcParser.ValueContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NCalcParser.value"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitValue([NotNull] NCalcParser.ValueContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NCalcParser.identifier"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterIdentifier([NotNull] NCalcParser.IdentifierContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NCalcParser.identifier"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitIdentifier([NotNull] NCalcParser.IdentifierContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NCalcParser.expressionList"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterExpressionList([NotNull] NCalcParser.ExpressionListContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NCalcParser.expressionList"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitExpressionList([NotNull] NCalcParser.ExpressionListContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NCalcParser.arguments"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterArguments([NotNull] NCalcParser.ArgumentsContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NCalcParser.arguments"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitArguments([NotNull] NCalcParser.ArgumentsContext context);
}
