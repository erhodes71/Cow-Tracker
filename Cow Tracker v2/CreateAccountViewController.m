//
//  CreateAccountViewController.m
//  Cow Tracker v2
//
//  Created by Eric Rhodes on 10/12/17.
//  Copyright © 2017 Eric Rhodes. All rights reserved.
//

#import "CreateAccountViewController.h"

@interface CreateAccountViewController ()

@end

@implementation CreateAccountViewController
{

    int dsn;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_emailTextField setDelegate:self];
    [_passwordTextField setDelegate:self];
    [_reEnteredPassword setDelegate:self];
    
    [_accountSetUpview setHidden:true];
    
    
}


//Pressed the create account button
- (IBAction)createAccountButtonPressed:(id)sender {
    NSString* email = _emailTextField.text;
    NSString* password = _passwordTextField.text;
    NSString* rePassword = _reEnteredPassword.text;
    
    NSString* test = NULL;
    
    if(![password isEqualToString:@""] && ![email isEqualToString:@""]){
        
        if([password isEqualToString:rePassword])
        {
            //
            [_accountSetUpview setHidden:false];
            [_okayButton setHidden:true];
            [_activityIndicator startAnimating];
            
            //Send request
            NSString* url = [NSString stringWithFormat:@"http://erhodes.oucreate.com/Cows/createAccount.php?username=%@&password=%@", email, password];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:url]];
            [request setHTTPMethod:@"GET"];
            
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                NSLog(@"requestReply: %@", requestReply);
                
                NSString* result = requestReply;
                if([result isEqualToString:@"User is in system"])
                {
                    NSLog(@"User is in system");
                    //[_accountSetUpview setHidden:true];
                    _outPutText.text = @"User is in the system.";
                    [_okayButton setHidden:false];
                    dsn = 2;
                    
                }else{
                    //Save all data to the users device
                    NSLog(@"User data saved");
                    NSString* tempForSAVEDDATE_TOKEN = requestReply;
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    [prefs setObject:tempForSAVEDDATE_TOKEN forKey:@"accessToken"];
                    [prefs setObject:password forKey:@"password"];
                    [prefs setObject:email forKey:@"userID"];
                    _outPutText.text = @"User added.";
                    [_okayButton setHidden:false];
                    dsn = 1;
                }
                [_activityIndicator stopAnimating];
                [_activityIndicator setHidden:true];
                [_loadingText setHidden:true];
                NSLog(@"Finished");

                
                
            }] resume];
            
            
        }
        
    }
    
}

- (IBAction)okayButtonPressed:(id)sender {
    
    //Depending on what value is done
    switch (dsn) {
        case 1:
            //Account Created
            [self performSegueWithIdentifier:@"forward" sender:self];
            break;
        case 2:
            //User already Exists
            [self performSegueWithIdentifier:@"back" sender:self];
            break;
        case 3:
            //Invalid Email
            break;
            
        default:
            break;
    }
    
    
}

-(void)goBackToMainMenu
{
        //Use segue transistion
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    
    
    [self.view endEditing:YES];
    return YES;
}



-(BOOL)textFieldShouldReturn:(UITextField*) textField
{
    NSLog(@"TestTest");
    [_passwordTextField resignFirstResponder];
    [_emailTextField resignFirstResponder];
    [textField resignFirstResponder];
    
    
    
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
