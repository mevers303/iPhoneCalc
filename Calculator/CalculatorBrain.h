//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Mark on 2/1/15.
//  Copyright (c) 2015 CSCI 3320. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;

@end