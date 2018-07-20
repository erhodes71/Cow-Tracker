//
//  MainMenuViewController.h
//  Cow Tracker v2
//
//  Created by Eric Rhodes on 10/1/17.
//  Copyright © 2017 Eric Rhodes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIBarButtonItem *homeButton;


@property (weak, nonatomic) IBOutlet UILabel *totalCows;
@property (weak, nonatomic) IBOutlet UILabel *totalBulls;
@property (weak, nonatomic) IBOutlet UILabel *totalCalvs;


@property (weak, nonatomic) IBOutlet UILabel *currentMonthlyCost;
@property (weak, nonatomic) IBOutlet UILabel *totalEquity;


@property (weak, nonatomic) IBOutlet UIView *waitingScreen;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
