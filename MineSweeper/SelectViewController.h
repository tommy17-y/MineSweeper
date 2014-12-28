//
//  SelectViewController.h
//  MineSweeper
//
//  Created by Yuki Tomiyoshi on 2014/12/28.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SelectViewController : UIViewController {
    AppDelegate *appDelegate;
    
    IBOutlet UIButton *selectedBtn;
}

- (IBAction)tappedHeightNum:(UIButton*)btn;
- (IBAction)tappedWidthNum:(UIButton*)btn;
- (IBAction)tappedMineNum:(UIButton*)btn;

@end
