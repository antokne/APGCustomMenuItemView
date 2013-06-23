//
//  MEAMenuView.h
//  Actual
//
//  Created by Antony Gardiner on 21/Jun/2013.
//  Copyright (c) 2013 MEA Mobile. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class APGCustomMenuViewController;

@interface APGCustomMenuView : NSView

@property (retain, nonatomic) IBOutlet APGCustomMenuViewController *viewController;

- (IBAction)postAction:(id)sender;
@end
