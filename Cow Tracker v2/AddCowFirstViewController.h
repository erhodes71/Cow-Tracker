//
//  AddCowFirstViewController.h
//  Cow Tracker v2
//
//  Created by Eric Rhodes on 12/24/17.
//  Copyright © 2017 Eric Rhodes. All rights reserved.
//

#import "ViewController.h"

@interface AddCowFirstViewController : ViewController<UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *brandTextField;

@property (weak, nonatomic) IBOutlet UITextField *parent1TextField;
@property (weak, nonatomic) IBOutlet UITextField *parent2TextField;

@property (weak, nonatomic) IBOutlet UITextField *birthDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *datePurchasedTextField;

@property (weak, nonatomic) IBOutlet UITextField *currentWeightTextField;


@property (weak, nonatomic) IBOutlet UITextField *birthWeight;




@property (weak, nonatomic) IBOutlet UINavigationBar *TitleUINavigationBar;





@property (weak, nonatomic) IBOutlet UILabel *errorText;




@end
