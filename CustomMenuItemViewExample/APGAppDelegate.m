//
//  APGAppDelegate.m
//  CustomMenuItemViewExample
//
//  Created by Antony Gardiner on 23/Jun/2013.
//  Copyright (c) 2013 Antony Gardiner. All rights reserved.
//

#import "APGAppDelegate.h"
#import "APGCustomMenuViewController.h"

@interface APGAppDelegate()

@property (nonatomic, strong) NSStatusItem *statusItem;

@end

@implementation APGAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  // Insert code here to initialize your application
  [self createStatusMenu];
  
  [self buildCustomMenuItems];
}


#pragma mark - status menu
-(void) createStatusMenu
{
	//Create the NSStatusBar and set its length
	_statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
  
	NSImage *image = [NSImage imageNamed:@"clockbw-tiny"];
  
	//Sets the images in our NSStatusItem
	[_statusItem setImage:image];
	[_statusItem setAlternateImage:image];
  
  
  //[_statusItem setView:_menuBarView];
  
	//Tells the NSStatusItem what menu to load
	[_statusItem setMenu:_statusMenu];
  
	//Sets the tooptip for our item
	//[_statusItem setToolTip:@"My Custom Menu Item"];
  
	//Enables highlighting
	[_statusItem setHighlightMode:YES];
}

-(void)buildCustomMenuItems
{
  for (int i = 0; i < 4; i++)
  {
    NSString *title = [NSString stringWithFormat:@"Title %d", i];
    NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:title action:@selector(postToWorkflowMaxSelected:) keyEquivalent:@""];
    
    APGCustomMenuViewController *postMenuVC = [[APGCustomMenuViewController alloc] initWithNibName:@"APGCustomMenuViewController" bundle:nil];
    [item setView:postMenuVC.view];
    
    [_statusMenu addItem:item];
    
  }

  
}


- (IBAction)itemSelected:(id)sender {
}
@end
