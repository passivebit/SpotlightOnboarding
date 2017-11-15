//
//  TutorialViewController.m
//  DoggyDating
//
//  Created by Ritu Raj on 20/12/16.
//  Copyright © 2016 Acknown Technologies. All rights reserved.
//

#import "TutorialViewController.h"
#import "TutorialView.h"

@interface TutorialViewController (){
    
    int count;
}
@property (weak, nonatomic) IBOutlet TutorialView *layerView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        [self.view setInsetsLayoutMarginsFromSafeArea:NO];
    } else {
        // Fallback on earlier versions
    }
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    count = 0;
        
    [self.layerView setSpotlightStartPoint:[NSValue valueWithCGPoint:self.backgroundView.center]];
    
    [self nextButtonPressed:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction methods
- (IBAction)nextButtonPressed:(id)sender {
    
    if (count==[self.rectArray count]) {
        count=0;
    }
    
    [self.layerView setRectToSpotlight:[[self.rectArray objectAtIndex:count] CGRectValue]];
    
    [self.infoLabel setText:[self.textArray objectAtIndex:count]];
    
    [self.layerView setNeedsLayout];
    count=count+1;
    
}
- (IBAction)exitButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
