//
//  AddCowSecondViewController.h
//  Cow Tracker v2
//
//  Created by Eric Rhodes on 12/28/17.
//  Copyright © 2017 Eric Rhodes. All rights reserved.
//

#import "ViewController.h"

@interface AddCowSecondViewController : ViewController<UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *amountPaidTextField;
@property (weak, nonatomic) IBOutlet UITextField *boughtFromTextField;
@property (weak, nonatomic) IBOutlet UITextView *vaccinationsTextField;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;


@property (weak, nonatomic) IBOutlet UIButton *submitButton;



@end
