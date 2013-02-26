//
//  VWTAnimatedView.m
//  GDIP
//
//  Created by Phaedra Deepsky on 2013-02-26.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTAnimatedView.h"

@interface VWTAnimatedView ()
@property NSMutableDictionary *textAttributes;
@property NSPoint textInsertionPoint;
@property NSTimer *scroller, *colorFader;
@property float redValue, greenValue, blueValue, alphaValue;
@property NSString *textToBeDispalyed;


@end

@implementation VWTAnimatedView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _redValue = 0.0f;
		_greenValue = 0.0f;
		_blueValue = 0.0f;
		_alphaValue = 0.0f;
		_textAttributes = [NSMutableDictionary dictionaryWithDictionary:@{NSForegroundColorAttributeName: [NSColor colorWithCalibratedRed:_redValue green:_greenValue blue:_blueValue alpha:_alphaValue], NSFontAttributeName: [NSFont systemFontOfSize:13]}];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

@end
