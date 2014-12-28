//
//  ViewController.h
//  MineSweeper
//
//  Created by Yuki Tomiyoshi on 2014/12/28.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MINE @"Mine"
#define NOMINE @"NoMine"

@interface ViewController : UIViewController {
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
    
    UIImage *tileImg;
    UIImage *mineImg;
    UIImage *nothingImg;
}

- (IBAction)start:(UIButton*)startButton;

@end
