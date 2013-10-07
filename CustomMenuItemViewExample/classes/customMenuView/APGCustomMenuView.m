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
	NSTrackingArea *trackingArea;
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

-(void)setTitleTextResizeIfNeeded:(NSString *)newTitle
{

	BOOL smallEnough = NO;
	CGFloat currentPointSize = 16;

	while (! smallEnough)
	{
		NSFont *font = [NSFont fontWithName:_titleTextField.font.fontName size:currentPointSize];

		NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];

		NSSize size = [_titleTextField.stringValue sizeWithAttributes:attributes];

		if (size.width <= _titleTextField.frame.size.width)
		{
			smallEnough = YES;
			_titleTextField.font = font;
		}
		else
		{
			currentPointSize--;
		}
	}

	_titleTextField.stringValue = newTitle;
}

-(void)updateTrackingAreas
{
	[self setUpTrackingArea];

	[super updateTrackingAreas];
}

-(void)setUpTrackingArea
{
	if(trackingArea != nil)
	{
		[self removeTrackingArea:trackingArea];
	}

	int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways | NSTrackingEnabledDuringMouseDrag);
	trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds] options:opts	owner:self userInfo:nil];
	[self addTrackingArea:trackingArea];

	NSLog(@"update tracking area %@", trackingArea);

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

-(float)widthOfView
{
	float notepading = 10;
	float width = 300 + notepading;


	NSFont *font = _titleTextField.font;

	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];

	NSSize size = [_titleTextField.stringValue sizeWithAttributes:attributes];
	if (size.width > (238 + notepading))
	{
		width = size.width + 62 + notepading;
	}

	return width;
}

-(void)setDisabled:(BOOL)disabled
{
	_disabled = disabled;

	self.highlight = NO;
}

- (void)viewWillMoveToSuperview:(NSView *)newSuperview
{
	//	NSLog(@"viewWillMoveToSuperview");
	[super viewWillMoveToSuperview:newSuperview];
}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent
{
  return YES;
}

// will clear any select menu options hanging around...
- (void)viewWillMoveToWindow:(NSWindow *)window
{
	//	NSLog(@"viewWillMoveToWindow");
	self.highlight = NO;

  [super viewWillMoveToWindow:window];
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

	// do something here

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

}

- (void)menuWillOpen:(NSMenu *)menu
{
	self.highlight = YES;
}

- (void)menuDidClose:(NSMenu *)menu
{
	self.highlight = NO;

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
			_titleTextField.textColor = [NSColor blackColor];
			_dateTextField.textColor = [NSColor darkGrayColor];
			_timeTextField.textColor = [NSColor darkGrayColor];
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
