//
//  SelectViewController.m
//  MineSweeper
//
//  Created by Yuki Tomiyoshi on 2014/12/28.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import "SelectViewController.h"

@interface SelectViewController ()

@end

@implementation SelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.heightNum = 0;
    appDelegate.widthNum = 0;
    appDelegate.mineNum = 0;
    
    selectedBtn.hidden = YES;
    
    UIButton *tmpBtn = (UIButton*)[self.view viewWithTag:9];
    tmpBtn.hidden = YES;

}

- (IBAction)tappedHeightNum:(UIButton*)btn {
    appDelegate.heightNum = (int)btn.titleLabel.text.integerValue;
    
    for (int i = 1; i <= 3; i++) {
        UIButton *tmpBtn = (UIButton*)[self.view viewWithTag:i];
        tmpBtn.backgroundColor = [UIColor whiteColor];
    }
    
    btn.backgroundColor = [UIColor grayColor];
    
    [self check];
    
}

- (IBAction)tappedWidthNum:(UIButton*)btn {
    appDelegate.widthNum = (int)btn.titleLabel.text.integerValue;
    
    for (int i = 4; i <= 6; i++) {
        UIButton *tmpBtn = (UIButton*)[self.view viewWithTag:i];
        tmpBtn.backgroundColor = [UIColor whiteColor];
    }
    
    btn.backgroundColor = [UIColor grayColor];

    [self check];
}

- (IBAction)tappedMineNum:(UIButton*)btn {
    appDelegate.mineNum = (int)btn.titleLabel.text.integerValue;
    
    for (int i = 7; i <= 9; i++) {
        UIButton *tmpBtn = (UIButton*)[self.view viewWithTag:i];
        tmpBtn.backgroundColor = [UIColor whiteColor];
    }
    
    btn.backgroundColor = [UIColor grayColor];

    [self check];
}

- (void)check {
    if (appDelegate.heightNum * appDelegate.widthNum > 30) {
        UIButton *tmpBtn = (UIButton*)[self.view viewWithTag:9];
        tmpBtn.hidden = NO;
    } else {
        UIButton *tmpBtn = (UIButton*)[self.view viewWithTag:9];
        tmpBtn.hidden = YES;
        appDelegate.mineNum = 0;
    }
    
    if (appDelegate.heightNum != 0 &&
        appDelegate.widthNum != 0 &&
        appDelegate.mineNum != 0) {
        selectedBtn.hidden = NO;
    } else {
        selectedBtn.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
