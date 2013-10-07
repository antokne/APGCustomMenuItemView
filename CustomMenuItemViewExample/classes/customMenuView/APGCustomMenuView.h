//
//  APGCustomMenuView.h
//  
//
//  Created by Antony Gardiner on 21/Jun/2013.
//  Copyright (c) 2013 MEA Mobile. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class APGCustomMenuViewController;

@interface APGCustomMenuView : NSView <NSMenuDelegate>

@property (retain, nonatomic) IBOutlet APGCustomMenuViewController *viewController;


@property (weak) IBOutlet NSTextField *titleTextField;
@property (weak) IBOutlet NSTextField *dateTextField;
@property (weak) IBOutlet NSTextField *timeTextField;

@property (nonatomic) BOOL disabled;

@property (nonatomic, assign) BOOL isMenuBar;

@property (nonatomic, assign) BOOL highlight;


@end
