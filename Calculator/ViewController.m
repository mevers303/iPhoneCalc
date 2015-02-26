//
//  ViewController.m
//  Calculator
//
//  Created by Mark on 2/1/15.
//  Copyright (c) 2015 CSCI 3320. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;

@end



@implementation ViewController



@synthesize display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;


- (CalculatorBrain *) brain
{
    if (!_brain)
        _brain = [[CalculatorBrain alloc] init];
    return _brain;
}


- (void)appendToBrainDisplay:(NSString *)string {
    
    // add to secondary display first
    self.brainDisplay.text = [[self.brainDisplay.text stringByAppendingString:@" "] stringByAppendingString:string];
    
}


- (IBAction)digitPressed:(UIButton *)sender {
    
    NSString *digit = [sender currentTitle];
    
    
    // if the user tries to enter a "." when there's already one in the string,
    // exit the function.
    if ([digit isEqualToString:@"."])
    {
        if ([self.display.text rangeOfString:@"."].location != NSNotFound)
            return;
    }
    
    
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
}


- (IBAction)enterPressed
{
    
    // add to secondary display
    [self appendToBrainDisplay:self.display.text];
    
    
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    
}



- (IBAction)operationPressed:(id)sender
{
    
    if (self.userIsInTheMiddleOfEnteringANumber)
        [self enterPressed];
    
    
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    
    // add to secondary display
    [self appendToBrainDisplay:operation];
    [self appendToBrainDisplay:@"="];
    [self appendToBrainDisplay:self.display.text];
                              
}

- (IBAction)clearPressed:(id)sender {
    
    self.display.text = @"0";
    self.brainDisplay.text = nil;
    [self.brain clearStack];
    
}

- (IBAction)backspacePressed:(id)sender {
    
    if (self.display.text.length > 0)
    {
        
        self.display.text = [self.display.text substringToIndex:(self.display.text.length - 1)];
        
        if (self.display.text.length == 0)
            self.display.text = @"0";
        
    }
}

- (IBAction)negativePressed:(id)sender {
    
    if ([[self.display.text substringToIndex:1] isEqualToString:@"-"])
        self.display.text = [self.display.text substringFromIndex:1];
    else
        self.display.text = [@"-" stringByAppendingString:self.display.text];
    
}
@end
