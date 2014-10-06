//
//  APGCustomMenuView.m
//
//
//  Created by Antony Gardiner on 21/Jun/2013.
//  Copyright (c) 2013 MEA Mobile. All rights reserved.
//

#import "APGCustomMenuView.h"


#import "APGCustomMenuViewController.h"

@implementation APGCustomMenuView
{
	NSTrackingArea *trackingArea, *trackingArea2;
}

@synthesize highlight = _highlight;

- (id)initWithFrame:(NSRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		// Initialization code here.
	}

	return self;
}

-(void)updateTrackingAreas
{
	[super updateTrackingAreas];

	[self setUpTrackingArea];
}

-(void)setUpTrackingArea
{
	if(trackingArea != nil)
	{
		[self removeTrackingArea:trackingArea];
	}
	if (trackingArea2) {
		[self removeTrackingArea:trackingArea2];
	}

	int opts = (NSTrackingMouseMoved | NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited | NSTrackingEnabledDuringMouseDrag);
	trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds] options:opts	owner:self userInfo:nil];
	[self addTrackingArea:trackingArea];

	NSLog(@"update tracking area %@", trackingArea);

	trackingArea2 = [[NSTrackingArea alloc] initWithRect:self.bounds options:(NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways | NSTrackingEnabledDuringMouseDrag) owner:self userInfo:nil];
	[self addTrackingArea:trackingArea2];

	NSPoint mouseLocation = [[self window] mouseLocationOutsideOfEventStream];
	mouseLocation = [self convertPoint: mouseLocation	fromView: nil];

	if (NSPointInRect(mouseLocation, [self bounds]))
	{
		[self mouseEntered: nil];
	}
	else
	{
		[self mouseExited: nil];
	}

}

-(void)setDisabled:(BOOL)disabled
{
	_disabled = disabled;

	self.highlight = NO;
}

- (void)mouseUp:(NSEvent *)theEvent
{
	NSLog(@"mouse up %@", theEvent);
  [self mouseExited:nil];
}

- (void)mouseEntered:(NSEvent *)theEvent
{
	NSLog(@"mouseEntered %@", theEvent);

  [super mouseEntered:theEvent];

	if (_isMenuBar) {
		return;
	}

	if (_disabled) {
		return;
	}

  self.highlight = YES;
}

- (void)mouseExited:(NSEvent *)theEvent
{
	NSLog(@"mouseExited %@", theEvent);

  [super mouseExited:theEvent];

	if (_isMenuBar) {
		return;
	}

	if (_disabled) {
		return;
	}

  self.highlight = NO;
}

-(void)mouseDown:(NSEvent *)theEvent
{
	[super mouseDown:theEvent];

	if (!_isMenuBar)
	{
		return;
	}

	dispatch_async(dispatch_get_main_queue(), ^{
		[self setNeedsDisplay:YES];
	});

	// maybe do something...
	NSLog(@"mouseDown %@", theEvent);
}

- (void)drawRect:(NSRect)rect
{
	if (_highlight)
	{
		[NSGraphicsContext saveGraphicsState];
		[[NSColor selectedMenuItemColor ] setFill];
		[[NSGraphicsContext currentContext] setPatternPhase:NSMakePoint(0, 0)];
		NSRectFill(self.bounds);
		[NSGraphicsContext restoreGraphicsState];

		_titleTextField.textColor = [NSColor selectedMenuItemTextColor];
		_dateTextField.textColor = [NSColor selectedMenuItemTextColor];
		_timeTextField.textColor = [NSColor selectedMenuItemTextColor];
	}
	else
	{
		[[NSColor clearColor] set];
		NSRectFillUsingOperation(self.bounds, NSCompositeSourceOver);

		if (_disabled)
		{
			_titleTextField.textColor = [NSColor disabledControlTextColor];
			_dateTextField.textColor = [NSColor disabledControlTextColor];
			_timeTextField.textColor = [NSColor disabledControlTextColor];
		}
		else
		{
			_titleTextField.textColor = [NSColor labelColor];
			_dateTextField.textColor = [NSColor secondaryLabelColor];
			_timeTextField.textColor = [NSColor secondaryLabelColor];
		}
	}
}

-(BOOL)highlight
{
	return _highlight;
}

-(void)setHighlight:(BOOL)highlight
{
	_highlight = highlight;
	[self setNeedsDisplay:YES];
	[self displayIfNeeded];
}


@end
