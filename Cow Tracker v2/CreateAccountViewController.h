//
//  CreateAccountViewController.h
//  Cow Tracker v2
//
//  Created by Eric Rhodes on 10/12/17.
//  Copyright © 2017 Eric Rhodes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateAccountViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *reEnteredPassword;


@property (weak, nonatomic) IBOutlet UIView *accountSetUpview;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UILabel *outPutText;

@property (weak, nonatomic) IBOutlet UILabel *loadingText;

@property (weak, nonatomic) IBOutlet UIButton *okayButton;

@end
