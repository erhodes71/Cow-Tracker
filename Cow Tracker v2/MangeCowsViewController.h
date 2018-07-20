//
//  MangeCowsViewController.h
//  Cow Tracker v2
//
//  Created by Eric Rhodes on 10/3/17.
//  Copyright © 2017 Eric Rhodes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MangeCowsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *homeButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;




@end
