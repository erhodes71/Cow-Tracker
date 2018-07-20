//
//  CowDataViewController.m
//  Cow Tracker v2
//
//  Created by Eric Rhodes on 1/4/18.
//  Copyright © 2018 Eric Rhodes. All rights reserved.
//

#import "CowDataViewController.h"

@interface CowDataViewController ()


@end

@implementation CowDataViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //This is a test
    
    [self.label setText:self.cowName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
