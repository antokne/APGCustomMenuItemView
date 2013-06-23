//
//  MEAMenuView.m
//  Actual
//
//  Created by Antony Gardiner on 21/Jun/2013.
//  Copyright (c) 2013 MEA Mobile. All rights reserved.
//

#import "APGCustomMenuView.h"
#import "APGCustomMenuTextField.h"

#import "APGCustomMenuViewController.h"

@implementation APGCustomMenuView
{
  NSTrackingRectTag trackingRect;

  NSGradient *normalGradient;
  NSGradient *highlightGradient;
  
  BOOL highlight;
  
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code here.
      trackingRect = [self addTrackingRect:[self frame] owner:self userData:nil assumeInside:NO];
    }
    
    return self;
}

-(void)awakeFromNib
{
  [self setupGradients];
}

- (void)setupGradients
{
	if (normalGradient == nil)
		normalGradient = [[NSGradient alloc] initWithStartingColor:[NSColor whiteColor] endingColor:[NSColor whiteColor]];

	if (highlightGradient == nil)
		highlightGradient = [[NSGradient alloc] initWithStartingColor:[NSColor darkGrayColor] endingColor:[NSColor darkGrayColor]];
}

-(void)viewDidMoveToWindow
{
  NSLog(@"viewDidMoveToWindow start");
  [self removeTrackingRect:trackingRect];
  
  NSPoint loc = [self convertPoint:[[self window] mouseLocationOutsideOfEventStream] fromView:nil];
  BOOL inside = ([self hitTest:loc] == self);
  trackingRect = [self addTrackingRect:[self frame] owner:self userData:nil assumeInside:inside];
  NSLog(@"viewDidMoveToWindow end");
}

- (void)viewWillMoveToWindow:(NSWindow *)window
{
  NSLog(@"viewWillMoveToWindow start");
  if (!window && [self window]) [self removeTrackingRect:trackingRect];
  [super viewWillMoveToWindow:window];
  NSLog(@"viewWillMoveToWindow end");
}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent
{
  return YES;
}

- (void)mouseUp:(NSEvent *)theEvent
{
  NSLog(@"in mouseUp");
  [_viewController postAction:nil];
  [self mouseExited:nil];
}

- (void)mouseEntered:(NSEvent *)theEvent
{
  NSLog(@"in mouseEntered");
  [super mouseEntered:theEvent];
  
  //self.layer.backgroundColor = [NSColor colorWithCalibratedWhite:0.35 alpha:1].CGColor;
  [self setHightlightedTextColorOnSubViews:YES];

  highlight = YES;
  
  [self setNeedsDisplay:YES];	// force update the currently tracked label back to its original color

  NSLog(@"out mouseEntered");
}

- (void)mouseExited:(NSEvent *)theEvent
{
  NSLog(@"in mouseExited");

  [super mouseExited:theEvent];
  
  //self.layer.backgroundColor = [NSColor colorWithCalibratedWhite:1 alpha:1].CGColor;
  [self setHightlightedTextColorOnSubViews:NO];
  
  highlight = NO;

  [self setNeedsDisplay:YES];	// force update the currently tracked label back to its original color

  NSLog(@"out mouseExited");
}

-(void)setHightlightedTextColorOnSubViews:(BOOL)highlighted
{
  for (NSView *view in self.subviews)
  {
    if ([view isKindOfClass:[APGCustomMenuTextField class]])
    {
      if ([view respondsToSelector:@selector(selectHighlightedTextColor:)])
      {
        [(APGCustomMenuTextField *)view selectHighlightedTextColor:highlighted];
      }
    }
  }
}

- (void)drawRect:(NSRect)rect
{
  if (highlight)
  {
    [highlightGradient drawInRect:[self frame] angle:90.0];
  }
  else
  {
    [normalGradient drawInRect:[self frame] angle:90.0];
  }
}

- (IBAction)postAction:(id)sender
{
  NSLog(@"in postAction");
  
  [_viewController postAction:nil];

  [self mouseExited:nil];
}
@end
