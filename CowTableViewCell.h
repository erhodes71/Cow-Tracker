//
//  CowTableViewCell.h
//  Cow Tracker v2
//
//  Created by Eric Rhodes on 10/29/17.
//  Copyright © 2017 Eric Rhodes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CowTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *weight;

@end
