//
//  AddCowFirstViewController.m
//  Cow Tracker v2
//
//  Created by Eric Rhodes on 12/24/17.
//  Copyright © 2017 Eric Rhodes. All rights reserved.
//

#import "AddCowFirstViewController.h"

@interface AddCowFirstViewController ()

@end

@implementation AddCowFirstViewController
{
    NSString* parent1;
    NSString* parent2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backButtonPressed:(id)sender {
    //Go Back
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Main"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//UIModalTransitionStyleFlipHorizontal
    [self presentViewController:vc animated:YES completion:NULL];
    
}

- (IBAction)cancelButtonPressed:(id)sender {
    //Also go back
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Main"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//UIModalTransitionStyleFlipHorizontal
    [self presentViewController:vc animated:YES completion:NULL];
    
}


- (IBAction)nextButtonPressed:(id)sender {
    
    bool nilTextFound = false;
    /*if(![_nameTextField.text  isEqual: @""])
    {
        if(![_brandTextField.text  isEqual: @""])
        {
            if(![_parent1TextField.text  isEqual: @""])
            {
                if(![_parent2TextField.text  isEqual: @""])
                {
                    if(![_birthDateTextField.text  isEqual: @""])
                    {
                        if(![_datePurchasedTextField.text  isEqual: @""])
                        {
                            if(![_currentWeightTextField.text  isEqual: @""])
                            {
                                
                            }else{
                                nilTextFound = true;
                            }
                        }else{
                            nilTextFound = true;
                        }
                    }else{
                        nilTextFound = true;
                    }
                }else{
                    nilTextFound = true;
                }
            }else{
                nilTextFound = true;
            }
        }else{
            nilTextFound = true;
        }
    }else{
        nilTextFound = true;
    }*/
    
    if(nilTextFound)
    {
        NSLog(@"Please fill out all fields!");
        [_errorText setText:@"Please fill out all fields!"];
        
    }else{
        
        parent1 = NULL;
        parent2 = NULL;
        
        [self loadParent:_parent1TextField.text];
        while(parent1 == NULL);
        
        [self loadParent:_parent2TextField.text];
        while(parent2 == NULL);

        NSLog(@"Parents \n");
        NSLog(@"%@", parent1);
        NSLog(@"%@", parent2);
        
        
        //Save all data
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        //Saves temp data for next view controllers
        [prefs setObject:_nameTextField.text forKey:@"tempName"];
        [prefs setObject:_brandTextField.text forKey:@"tempBrand"];
        [prefs setObject:parent1 forKey:@"tempParent1"];
        [prefs setObject:parent2 forKey:@"tempParent2"];
        [prefs setObject:_birthDateTextField.text forKey:@"tempBirthDate"];
        [prefs setObject:_datePurchasedTextField.text forKey:@"tempDatePurchased"];
        [prefs setObject:_currentWeightTextField.text forKey:@"tempCurrentWeight"];
        [prefs setObject:_birthWeight.text forKey:@"tempBirthWeight"];
        
        //Load data
        //NSString *textToLoad = [prefs stringForKey:@"keyToFindText"];
        
        
        
        
        //ViewController *NVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddCowSecondViewController"];
        //[self presentViewController:NVC animated:YES completion:nil];
        [self performSegueWithIdentifier:@"Second" sender:self];
    }
    
    
}


//Returns the CowID of the parent name
-(void)loadParent:(NSString*)parent
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString* userName = [prefs stringForKey:@"userID"];
    NSString* accessToken = [prefs stringForKey:@"accessToken"];
    
    NSString* userID = userName;
    NSString* token = accessToken;
    
    
    __block NSString* result = NULL;
    
    //send request and get ID for parent
    //Send request
    NSString* url = [NSString stringWithFormat:@"http://erhodes.oucreate.com/Cows/getParent.php?userID=%@&name=%@&token=%@", userID, parent, token];
    
    NSLog(@"%@", url);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
        
        result = requestReply;
        
        if(parent1 == NULL)
        {
            parent1 = requestReply;
        }else if(parent2 == NULL)
        {
            parent2 = requestReply;
        }
        
    }] resume];
}



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"Test");
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"END");    
}

//Returns the keyboard
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_nameTextField resignFirstResponder];
    [_brandTextField resignFirstResponder];
    [_parent1TextField resignFirstResponder];
    [_parent2TextField resignFirstResponder];
    [_birthDateTextField resignFirstResponder];
    [_datePurchasedTextField resignFirstResponder];
    [_currentWeightTextField resignFirstResponder];
    [_birthWeight resignFirstResponder]; // YOU didnt name this text field right lol
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [self performSelectorOnMainThread:@selector(keyboardDidHide:) withObject:nil waitUntilDone:NO];
    
    return NO;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [self performSelectorOnMainThread:@selector(keyboardDidShow:) withObject:nil waitUntilDone:NO];
    
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    
    CGRect f = self.view.frame;
    [self.view setFrame:f];
    // Assign new frame to your view
    //[self.view setFrame:CGRectMake(0,-110,320,460)]; //here taken -110 for example i.e. your view will be scrolled to -110. change its value according to your requirement.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    if([_birthWeight isFirstResponder]){
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = f.origin.y - 60;
            //self.view.frame = f;
            [self.view setFrame:f];
        }];
    }else if([_currentWeightTextField isFirstResponder]){
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = f.origin.y - 40;
            //self.view.frame = f;
            [self.view setFrame:f];
        }];
    }else{
    
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = f.origin.y - 20;
            //self.view.frame = f;
            [self.view setFrame:f];
        }];
    }
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    //[self.view setFrame:CGRectMake(0,0,320,460)];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        //self.view.frame = f;
        [self.view setFrame:f];
    }];
}



@end
