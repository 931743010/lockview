//
//  LockView.h
//  lockview
//
//  Created by lbq on 15/11/19.
//  Copyright © 2015年 linbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LockView;
@protocol LockViewDelegate <NSObject>

//协议
@optional
-(void)lockView:(LockView *)lockView didFinishPath:(NSString *)path;

@end


@interface LockView : UIView
@property(nonatomic,assign) IBOutlet id<LockViewDelegate> delegate;

@end
