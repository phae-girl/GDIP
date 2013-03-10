//
//  VWTAnimatedView.h
//  GDIP
//
//  Created by Phaedra Deepsky on 2013-02-26.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol VWTAnimatedViewDelegate <NSObject>
@required
//Required methods for implementing the delegate

@optional
//Optional methods for implementing the delegate
- (void)animationDidCompleteForView:(int)viewName;

@end

@interface VWTAnimatedView : NSView

@property (assign, nonatomic) id <VWTAnimatedViewDelegate> delegate;

- (void)drawText:(NSString *)labelText withSlideInAnimation:(BOOL)animation forView:(int)viewName;

@end
