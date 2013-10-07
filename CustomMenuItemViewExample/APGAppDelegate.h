//
//  APGAppDelegate.h
//  CustomMenuItemViewExample
//
//  Created by Antony Gardiner on 23/Jun/2013.
//  Copyright (c) 2013 Antony Gardiner. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface APGAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSMenu *statusMenu;
@property (weak) IBOutlet NSMenu *popupMenu;
@property (weak) IBOutlet NSMenu *customMenu;

- (IBAction)itemSelected:(id)sender;
@end
