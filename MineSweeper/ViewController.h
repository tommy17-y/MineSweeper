//
//  ViewController.h
//  MineSweeper
//
//  Created by Yuki Tomiyoshi on 2014/12/28.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

#define MINE @"Mine"
#define NOMINE @"NoMine"

@interface ViewController : UIViewController {
    AppDelegate *appDelegate;
    
    int width;
    int height;
    
    int widthNum;
    int heightNum;
    int mineNum;
    
    int openedTileNum;
    
    NSMutableArray *tiles;
    NSMutableArray *tileContents;
    
    IBOutlet UIView *base;
    IBOutlet UILabel *leftMineLabel;
    IBOutlet UILabel *timerLabel;
    
    NSTimeInterval startTime;
    NSTimer *timer;
    
    NSTimeInterval tapStartTime;
    
    UIImage *tileImg;
    UIImage *mineImg;
    UIImage *flagImg;
    UIImage *nothingImg;
    
    IBOutlet UIButton *tileBtn;
    IBOutlet UIButton *flagBtn;
}

- (IBAction)start:(UIButton*)startButton;
- (IBAction)tappedTileBtn;
- (IBAction)tappedFladBtn;


@end
