//
//  CowDataViewController.h
//  Cow Tracker v2
//
//  Created by Eric Rhodes on 1/4/18.
//  Copyright © 2018 Eric Rhodes. All rights reserved.
//

#import "ViewController.h"

@interface CowDataViewController : ViewController

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) NSString* cowName;

@end
