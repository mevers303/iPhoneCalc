//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Mark on 2/1/15.
//  Copyright (c) 2015 CSCI 3320. All rights reserved.
//

#import "CalculatorBrain.h"
#import <math.h>


@interface CalculatorBrain()

@property (nonatomic, strong) NSMutableArray *operandStack;

@end


@implementation CalculatorBrain

@synthesize operandStack = _operandStack;


- (NSMutableArray *)operandStack {
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}


- (void)clearStack {
    
    [self.operandStack removeAllObjects];
    
}


- (void)pushOperand:(double)op {
    NSNumber *operandObject = [NSNumber numberWithDouble:op];
    [self.operandStack addObject:operandObject];
}


- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject)
        [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}


- (double)performOperation:(NSString *)operation
{
    
    double result = 0;
    
    if ([operation isEqualToString:@"+"])
        result = [self popOperand] + [self popOperand];
    else if ([operation isEqualToString:@"*"])
        result = [self popOperand] * [self popOperand];
    else if ([operation isEqualToString:@"-"])
    {
        double temp = [self popOperand];
        result = [self popOperand] - temp;
    }
    else if ([operation isEqualToString:@"/"])
    {
        double temp = [self popOperand];
        result = [self popOperand] / temp;
    }
    else if ([operation isEqualToString:@"sin"])
        result = sin([self popOperand]);
    else if ([operation isEqualToString:@"cos"])
        result = cos([self popOperand]);
    else if ([operation isEqualToString:@"sqrt"])
        result = sqrt([self popOperand]);
    else if ([operation isEqualToString:@"pi"])
        result = M_PI;
    
    
    
    [self pushOperand:result];
    
    
    return result;
}


@end