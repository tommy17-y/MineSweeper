//
//  ViewController.m
//  MineSweeper
//
//  Created by Yuki Tomiyoshi on 2014/12/28.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    widthNum = appDelegate.widthNum;
    heightNum = appDelegate.heightNum;
    mineNum = appDelegate.mineNum;
    
    if (widthNum <= 6 && heightNum <= 10) {
        width = 50;
        height = 50;
    } else {
        width = 25;
        height = 25;
    }

    openedTileNum = 0;
    
    tileImg = [UIImage imageNamed:@"masu.png"];
    mineImg = [UIImage imageNamed:@"mine.png"];
    flagImg = [UIImage imageNamed:@"flag.png"];
    nothingImg = [UIImage imageNamed:@"nothing.png"];
    
    tiles = [NSMutableArray array];
    tileContents = [NSMutableArray array];
    [tiles removeAllObjects];
    [tileContents removeAllObjects];
    
    leftMineLabel.text = [NSString stringWithFormat:@"%d", mineNum];
    timerLabel.text = @"00:00:00";
    
    base.userInteractionEnabled = NO;
    
    [self setTile];
    [self setMine];
    
}

- (void)onTappedTile:(UITapGestureRecognizer*)recognizer {
    
    UIImageView *tappedTile = (UIImageView*)[base viewWithTag:recognizer.view.tag];
    
    if (tappedTile != nil) {
        if (tappedTile.image != flagImg) {
            tappedTile.userInteractionEnabled = NO;
            if ([tileContents[tappedTile.tag - 1] isEqual:NOMINE]) {
                tappedTile.image = nothingImg;
                openedTileNum++;
                
                [self mineCount:(int)tappedTile.tag];
                
                if (openedTileNum == widthNum * heightNum - mineNum) {
                    [timer invalidate];
                    
                    [NSTimer scheduledTimerWithTimeInterval:0.5f target:self
                                                   selector:@selector(allTileOpen)
                                                   userInfo:nil repeats:NO];
                    
                    leftMineLabel.text = @"クリア！";
                }
            } else if ([tileContents[tappedTile.tag - 1] isEqual:MINE]) {
                tappedTile.image = mineImg;
                [timer invalidate];
                
                [NSTimer scheduledTimerWithTimeInterval:0.5f target:self
                                               selector:@selector(allTileOpen)
                                               userInfo:nil repeats:NO];
                
                [NSTimer scheduledTimerWithTimeInterval:3 target:self
                                               selector:@selector(toStart)
                                               userInfo:nil repeats:NO];
            }
        }
    }
    
}

- (void)mineCount:(int)tappedTileTag {
    int count = 0;
    
    // 最上段以外
    if (tappedTileTag > widthNum) {
        if ([tileContents[tappedTileTag - widthNum - 1] isEqual:MINE]) {
            count++;
        }
        
        if (tappedTileTag % widthNum != 0) {
            if ([tileContents[tappedTileTag - widthNum + 1 - 1] isEqual:MINE]) {
                count++;
            }
        }
        
        if (tappedTileTag % widthNum != 1) {
            if ([tileContents[tappedTileTag - widthNum - 1 - 1] isEqual:MINE]) {
                count++;
            }
        }
    }
    
    // 最下段以外
    if (tappedTileTag <= (widthNum * (heightNum - 1))) {
        if ([tileContents[tappedTileTag + widthNum - 1] isEqual:MINE]) {
            count++;
        }
        
        if (tappedTileTag % widthNum != 0) {
            if ([tileContents[tappedTileTag + widthNum + 1 - 1] isEqual:MINE]) {
                count++;
            }
        }
        
        if (tappedTileTag % widthNum != 1) {
            if ([tileContents[tappedTileTag + widthNum - 1 - 1] isEqual:MINE]) {
                count++;
            }
        }

    }
    
    // 最右以外
    if (tappedTileTag % widthNum != 0) {
        if ([tileContents[tappedTileTag + 1 - 1] isEqual:MINE]) {
            count++;
        }
    }
    
    // 最左以外
    if (tappedTileTag % widthNum != 1) {
        if ([tileContents[tappedTileTag - 1 - 1] isEqual:MINE]) {
            count++;
        }
    }
    
    UIImageView *tappedTile = (UIImageView*)[base viewWithTag:tappedTileTag];
    UILabel *tappedTileLabel = (UILabel*)[tappedTile viewWithTag:tappedTile.tag + 100];
    
    tappedTileLabel.text = [NSString stringWithFormat:@"%d", count];
    tappedTileLabel.hidden = NO;

}

- (void)allTileOpen {
    
    for (int i = 0; i < widthNum * heightNum; i++) {
        UIImageView *tile = tiles[i];
        if ([tileContents[i] isEqual:NOMINE]) {
            tile.image = nothingImg;
        } else if ([tileContents[i] isEqual:MINE]) {
            tile.image = mineImg;
        }
    }
    
}

- (void)toStart {
    [self performSegueWithIdentifier:@"toStart" sender:self];
}

- (void)setTile {
    
    base.frame = CGRectMake(0, 0, width * widthNum, height * heightNum);
    base.center = CGPointMake(self.view.center.x, self.view.center.y);
    
    for (int i = 0; i < widthNum * heightNum; i++) {
        
        UIImageView *tile = [[UIImageView alloc] initWithFrame:
                             CGRectMake(0 + (i % widthNum) * width,
                                        0 + (i / widthNum) * height,
                                        width,
                                        height)];
        tile.image = tileImg;
        tile.tag = i + 1;
        tile.userInteractionEnabled = NO;
        [tiles addObject:tile];
        
        [tileContents addObject:NOMINE];
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(onTappedTile:)];
        [tile addGestureRecognizer:recognizer];
        
        [base addSubview:tile];
        
        UILabel *numLabel = [[UILabel alloc] initWithFrame:
                             CGRectMake(0,
                                        0,
                                        width,
                                        height)];
        numLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.tag = i + 1 + 100;
        numLabel.text = @"";
        numLabel.hidden = YES;
        
        [tile addSubview:numLabel];
    }
}

- (void)setMine {

    int count = mineNum;
    
    for (;;){
        int rand = arc4random() % (widthNum * heightNum);
        
        NSLog(@"%d", rand);
        
        if ([tileContents[rand] isEqual:NOMINE]) {
            [tileContents replaceObjectAtIndex:rand withObject:MINE];
            count--;
            if(count <= 0) {
                break;
            }
        }
    }
    
}

- (IBAction)start:(UIButton*)startButton {
    startButton.hidden = YES;
    startTime = [NSDate timeIntervalSinceReferenceDate];
    
    for (int i = 0; i < widthNum * heightNum; i++) {
        UIImageView *tile = tiles[i];
        tile.userInteractionEnabled = YES;
    }
    
    base.userInteractionEnabled = YES;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self
                                           selector:@selector(timerLabelUpdata)
                                           userInfo:nil repeats:YES];
}

- (void)timerLabelUpdata {
    NSTimeInterval nowTime = [NSDate timeIntervalSinceReferenceDate];
    timerLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",
                       (int)(nowTime - startTime) / 60,
                       (int)(nowTime - startTime) % 60,
                       (int)((nowTime - startTime) * 100.0) % 60];
    
    if ((int)(nowTime - startTime) / 60 >= 60) {
        timerLabel.text = @"time up!";
        [timer invalidate];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    tapStartTime = [NSDate timeIntervalSinceReferenceDate];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (base.userInteractionEnabled == YES) {
    
        NSTimeInterval tapEndTime = [NSDate timeIntervalSinceReferenceDate];
        
        if ((tapEndTime - tapStartTime) > 0.7) {
            UITouch *touch = [touches anyObject];
            CGPoint location = [touch locationInView:base];
            
            UIImageView *tappedTile = [[UIImageView alloc] init];
            
            for (int i = 1; i <= heightNum; i++) {
                if (location.y <= height * i) {
                    for (int j = 1; j <= widthNum; j++) {
                        if (location.x <= width * j) {
                            tappedTile = (UIImageView*)[base viewWithTag:(widthNum * (i - 1) + j)];
                            break;
                        }
                    }
                    break;
                }
            }
            
            if (tappedTile != nil) {
                if (tappedTile.image == tileImg) {
                    tappedTile.image = flagImg;
                } else if (tappedTile.image == flagImg) {
                    tappedTile.image = tileImg;
                }
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
