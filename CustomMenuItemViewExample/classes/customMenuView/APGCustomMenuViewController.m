//
//  APGCustomMenuViewController.m
//  
//
//  Created by Antony Gardiner on 21/Jun/2013.
//  Copyright (c) 2013 MEA Mobile. All rights reserved.
//

#import "APGCustomMenuViewController.h"


@interface APGCustomMenuViewController ()

@end

@implementation APGCustomMenuViewController
{
  NSDateFormatter *formatter;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
      formatter = [[NSDateFormatter alloc] init];
      [formatter setTimeStyle:NSDateFormatterNoStyle];
      [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    
    return self;
}



- (IBAction)postAction:(id)sender
{
  
  NSLog(@"post action clicked");

}

@end
