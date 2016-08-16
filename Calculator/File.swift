//
//  File.swift
//  Calculator
//
//  Created by Javier Rennola on 1/18/16.
//  Copyright © 2016 Javier Rennola. All rights reserved.
//


import Foundation

class CalulatorBrain
{
    private enum Op
    {
        case Operand(Double)
        case UnaryOperation(String, Double->Double)
        case BinaryOperation(String , (Double,Double)->Double)
    }
    
    private var opStack = [Op]()
    
    private var knownOps = [String:Op]()
    
    init()
    {
        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷", {$1 / $0})
        knownOps["−"] = Op.BinaryOperation("−", {$1 - $0})
        knownOps["+"] = Op.BinaryOperation("+", {$0 + $1})
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
        knownOps["sin"] = Op.UnaryOperation("sin", sin)
        knownOps["cos"] = Op.UnaryOperation("cos", cos)
        knownOps["tan"] = Op.UnaryOperation("tan", tan)
        
    }
    
    @nonobjc private func evaluate(ops: [Op] )->(result:Double?,remainingOps:[Op])
    {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op{
            case .Operand(let operand):
                return (operand,remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result{
                    return (operation (operand),operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_,let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result{
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result{
                        return (operation(operand1,operand2),op2Evaluation.remainingOps)
                    }
                }
                
            }
        }
        return (nil, ops)
    }
    
    @nonobjc func evaluate() -> Double?
    {
        let (result , _) = evaluate(opStack)
        return result
    }
    func pushOperand (operand: Double) -> Double?
    {
        opStack.append(Op.Operand(<#T##Double#>))
        return evaluate()
    }
    
    func performOperation (symbol: String)
    {
        if let operation = knownOps[symbol]
        {
            opStack.append(operation)
        }
    }
    
}
