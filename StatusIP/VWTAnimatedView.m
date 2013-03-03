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
	NSLog(@"%s [Line %d] ", __PRETTY_FUNCTION__, __LINE__);
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

- (void)drawText:(NSString *)labelText withSlideInAnimation:(BOOL)animation
{
	NSLog(@"%s [Line %d] ", __PRETTY_FUNCTION__, __LINE__);
	self.textToBeDispalyed = labelText;
	_textInsertionPoint.y = (self.bounds.size.height/2 - [labelText sizeWithAttributes:self.textAttributes].height/2);
	
	if (animation) {
		_textInsertionPoint.x = -[labelText sizeWithAttributes:self.textAttributes].width;
		self.scroller = [NSTimer scheduledTimerWithTimeInterval:0.001
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
	}
	
	_textInsertionPoint.x += 1.0f;
	[self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSLog(@"%s [Line %d] ", __PRETTY_FUNCTION__, __LINE__);
	[self.textToBeDispalyed drawAtPoint:self.textInsertionPoint withAttributes:self.textAttributes];
}

@end
