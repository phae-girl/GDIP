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
@property NSString *textToBeDispalyed;
@property NSTimer *scroller, *colorFader;
@property float redValue, greenValue, blueValue, alphaValue, timerLength;
@property int currentView;

@end

@implementation VWTAnimatedView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _redValue = 0.0f;
		_greenValue = 0.0f;
		_blueValue = 0.0f;
		_alphaValue = 1.0f;
		_textAttributes = [NSMutableDictionary dictionaryWithDictionary:@{NSForegroundColorAttributeName: [NSColor colorWithCalibratedRed:_redValue green:_greenValue blue:_blueValue alpha:_alphaValue], NSFontAttributeName: [NSFont systemFontOfSize:13]}];
    }
    
    return self;
}

- (void)drawText:(NSString *)labelText withSlideInAnimation:(BOOL)animation forView:(int)viewName
{
	
	self.currentView = viewName;
	self.textToBeDispalyed = labelText;
	_textInsertionPoint.y = (self.bounds.size.height/2 - [labelText sizeWithAttributes:self.textAttributes].height/2);
	
	if (animation) {
		_textInsertionPoint.x = -[labelText sizeWithAttributes:self.textAttributes].width;
		_timerLength = (1/[labelText sizeWithAttributes:self.textAttributes].height)*0.03;
		self.scroller = [NSTimer scheduledTimerWithTimeInterval:self.timerLength
														 target:self
													   selector:@selector(moveText:)
													   userInfo:nil repeats:YES];
	}
	else {
		_textInsertionPoint.x = 0.0f;
		[self setNeedsDisplay:YES];
	}
}

- (void) moveText:(NSTimer *)timer
{
	if (self.textInsertionPoint.x >= 0.0f) {
		_textInsertionPoint.x = 0.0f;
		[self.scroller invalidate];
		self.scroller = nil;
		[self.delegate animationDidCompleteForView:self.currentView];
	}
	
	_textInsertionPoint.x += 1.0f;
	[self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[self.textToBeDispalyed drawAtPoint:self.textInsertionPoint withAttributes:self.textAttributes];
}

@end
