//
//  MEAMenuTextField.m
//  Actual
//
//  Created by Antony Gardiner on 21/Jun/2013.
//  Copyright (c) 2013 MEA Mobile. All rights reserved.
//

#import "APGCustomMenuTextField.h"

@implementation APGCustomMenuTextField
{
  NSColor *currentColor;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
      currentColor = self.textColor;
    }
    
    return self;
}


- (void)selectHighlightedTextColor:(BOOL)highlighted
{
  if (highlighted)
  {
    self.textColor = [NSColor whiteColor];
  }
  else
  {
    self.textColor = currentColor;
  }

}


@end
