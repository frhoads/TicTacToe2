//
//  ViewController.m
//  TicTacToe
//
//  Created by Fletcher Rhoads on 1/10/14.
//  Copyright (c) 2014 Fletcher Rhoads. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    
    __weak IBOutlet UILabel *whichPlayerLabel;
    
    __weak IBOutlet UILabel *myLabelOne;
    
    __weak IBOutlet UILabel *myLabelTwo;
    
    __weak IBOutlet UILabel *myLabelThree;
    
    __weak IBOutlet UILabel *myLabelFour;
    
    __weak IBOutlet UILabel *myLabelFive;
    
    __weak IBOutlet UILabel *myLabelSix;
    
    __weak IBOutlet UILabel *myLabelSeven;
    
    __weak IBOutlet UILabel *myLabelEight;
    
    __weak IBOutlet UILabel *myLabelNine;
    
    __weak IBOutlet UILabel *playerToken;
    
    CGAffineTransform transform;
    
    UILabel *labelTapped;
    
    NSString *playerTurn;
    
    int turnCounter;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    transform = playerToken.transform;
    whichPlayerLabel.text = @"It's Player O's turn";
    turnCounter = 1;  //initialize turnCounter to 1
    playerTurn = @"O"; //initialize playerTurn to 'O'
}


- (UILabel *)findLabelUsingPoint:(CGPoint)point
{
    labelTapped = nil;
    //find which label was tapped
    if (CGRectContainsPoint(myLabelOne.frame, point)) {
        labelTapped = myLabelOne;
    }
    if (CGRectContainsPoint(myLabelTwo.frame, point)) {
        labelTapped = myLabelTwo;
    }
    if (CGRectContainsPoint(myLabelThree.frame, point)) {
        labelTapped = myLabelThree;
    }
    if (CGRectContainsPoint(myLabelFour.frame, point)) {
        labelTapped = myLabelFour;
    }
    if (CGRectContainsPoint(myLabelFive.frame, point)) {
        labelTapped = myLabelFive;
    }
    if (CGRectContainsPoint(myLabelSix.frame, point)) {
        labelTapped = myLabelSix;
    }
    if (CGRectContainsPoint(myLabelSeven.frame, point)) {
        labelTapped = myLabelSeven;
    }
    if (CGRectContainsPoint(myLabelEight.frame, point)) {
        labelTapped = myLabelEight;
    }
    
    if (CGRectContainsPoint(myLabelNine.frame, point)) {
        labelTapped = myLabelNine;
    }
    
    return labelTapped;
}



-(NSString*)whichPlayerTurn
{
    //Keeps track of 'X' or 'O' player's turn
    if (turnCounter % 2 == 0) {
        playerTurn = @"X";
    }else{
        playerTurn = @"O";
    }
    NSLog(@"It is Player's %@ turn", playerTurn);
    return playerTurn;
}

-(IBAction)onDrag:(UIPanGestureRecognizer*)panGestureRecognizer
{
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5f animations:^{;
        playerToken.transform = transform;
        }];
    }else{
        CGPoint point = [panGestureRecognizer translationInView:self.view];
        playerToken.transform = CGAffineTransformMakeTranslation(point.x, point.y);
    }
}

-(IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGestureRecognizer;

{
    CGPoint point = [tapGestureRecognizer locationInView:self.view];// setting 'point' to user's finger tap
    labelTapped = [self findLabelUsingPoint:point]; //Call findLabelUsingPoint method
    playerToken.text = [NSString stringWithFormat:@"%@", playerTurn];
    NSLog(@"the turn is %i",turnCounter);
    
    //Change [] to blue 'X'
    if ([labelTapped.text isEqualToString:@"[      ]"] && [playerTurn isEqualToString:@"X"]) {
        turnCounter++;
        labelTapped.text = [NSString stringWithFormat:@"X"];
        labelTapped.textColor = [UIColor blueColor];
        if ([[self whoOne] isEqualToString:@"X"]) {
            whichPlayerLabel.text = [NSString stringWithFormat: @"Player %@ is the winner!", [self whoOne]];
        }
        playerTurn = [self whichPlayerTurn];
    }
    
    //Change [] to red 'O'
    if ([labelTapped.text isEqualToString:@"[      ]"] && [playerTurn isEqualToString:@"O"]) {
        turnCounter++;
        labelTapped.text = [NSString stringWithFormat:@"O"];
        labelTapped.textColor = [UIColor redColor];
        if ([[self whoOne] isEqualToString:@"O"])
        {
            whichPlayerLabel.text = [NSString stringWithFormat: @"Player %@ is the winner!", [self whoOne]];
        }
        playerTurn = [self whichPlayerTurn];
    }
    //whichPlayerLabel.text = [NSString stringWithFormat:@"It's %@ players turn", [self whichPlayerTurn]];
}


-(NSString*)whoOne
{
    NSString *winningPlayer;
    
    winningPlayer = [self checkWinningTryptychFirst:myLabelOne.text Second:myLabelTwo.text Third:myLabelThree.text];
    
    if (winningPlayer == nil)
        winningPlayer = [self checkWinningTryptychFirst:myLabelFour.text Second:myLabelFive.text Third:myLabelSix.text];
    
    if (winningPlayer == nil)
        winningPlayer = [self checkWinningTryptychFirst:myLabelSeven.text Second:myLabelEight.text Third:myLabelNine.text];
    
    if (winningPlayer == nil)
        winningPlayer = [self checkWinningTryptychFirst:myLabelOne.text Second:myLabelFour.text Third:myLabelSeven.text];
    
    if (winningPlayer == nil)
        winningPlayer = [self checkWinningTryptychFirst:myLabelTwo.text Second:myLabelFive.text Third:myLabelEight.text];
    
    if (winningPlayer == nil)
        winningPlayer = [self checkWinningTryptychFirst:myLabelThree.text Second:myLabelSix.text Third:myLabelNine.text];
    
    if (winningPlayer == nil)
        winningPlayer = [self checkWinningTryptychFirst:myLabelOne.text Second:myLabelFive.text Third:myLabelNine.text];

    if (winningPlayer == nil) {
        winningPlayer = [self checkWinningTryptychFirst:myLabelThree.text Second:myLabelFive.text Third:myLabelSeven.text];
    }
    
    return winningPlayer;
}

-(NSString*)checkWinningTryptychFirst:(NSString*)checkValueOne
                               Second:(NSString*)checkValueTwo
                                Third:(NSString*)checkValueThree
{
    NSString *winner;
    if ([checkValueOne isEqualToString:checkValueTwo] && [checkValueTwo isEqualToString:checkValueThree]
        && ![checkValueOne isEqualToString: @"[      ]"]) {
        winner = playerTurn;
    }
    return winner;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
