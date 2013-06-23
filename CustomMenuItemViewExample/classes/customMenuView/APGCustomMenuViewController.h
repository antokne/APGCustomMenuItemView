//
//  MEAPostMenuViewController.h
//  Actual
//
//  Created by Antony Gardiner on 21/Jun/2013.
//  Copyright (c) 2013 MEA Mobile. All rights reserved.
//

#import <Cocoa/Cocoa.h>



@interface APGCustomMenuViewController : NSViewController

@property (weak) IBOutlet NSTextField *titleTextField;
@property (weak) IBOutlet NSTextField *dateTextField;
@property (weak) IBOutlet NSTextField *timeTextField;


- (IBAction)postAction:(id)sender;


@end


