//
//  SignInViewController.h
//  Cow Tracker v2
//
//  Created by Eric Rhodes on 10/8/17.
//  Copyright © 2017 Eric Rhodes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UILabel *star1;
@property (weak, nonatomic) IBOutlet UILabel *star2;

@property (weak, nonatomic) IBOutlet UILabel *errorMessage;


@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;



@end
