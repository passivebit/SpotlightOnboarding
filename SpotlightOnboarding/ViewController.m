//
//  ViewController.m
//  SpotlightOnboarding
//
//  Created by Ritu Raj on 15/11/17.
//  Copyright © 2017 Ritu Raj. All rights reserved.
//

#import "ViewController.h"
#import "TutorialViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *myButton1;
@property (weak, nonatomic) IBOutlet UIButton *myPinkView;
@property (weak, nonatomic) IBOutlet UIButton *myYellowView;
@property (weak, nonatomic) IBOutlet UIButton *myGreenButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSArray *rectArr = @[[NSValue valueWithCGRect:_myButton1.frame],[NSValue valueWithCGRect:_myPinkView.frame],[NSValue valueWithCGRect:_myYellowView.frame],[NSValue valueWithCGRect:_myGreenButton.frame]];
    
    NSArray *textArray = @[@"This is My Button 1",@"This is My Pink View",@"This is My Yellow View",@"This is My Green Button"];
    
    [self showTutorialsWithSpotlightOn:rectArr withTextArray:textArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showTutorialsWithSpotlightOn:(NSArray*)frameArray withTextArray:(NSArray*)textArray{
    
    TutorialViewController *tutorialController = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialViewController"];
    
    tutorialController.textArray = textArray;
    tutorialController.rectArray = frameArray;
    
    tutorialController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:tutorialController animated:YES completion:nil];
}


@end
