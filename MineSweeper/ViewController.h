//
//  ViewController.h
//  MineSweeper
//
//  Created by Yuki Tomiyoshi on 2014/12/28.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MINE 8888
#define NOMINE 7777

@interface ViewController : UIViewController {
    int width;
    int height;
    
    int widthNum;
    int heightNum;
    int mineNum;
    
    NSMutableArray *tiles;
    
    IBOutlet UIView *base;
    IBOutlet UILabel *leftMineLabel;
    IBOutlet UILabel *timerLabel;
    
    NSTimeInterval startTime;
    NSTimer *timer;
}

- (IBAction)start:(UIButton*)startButton;

@end
