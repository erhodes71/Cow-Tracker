//
//  SignInViewController.m
//  Cow Tracker v2
//
//  Created by Eric Rhodes on 10/8/17.
//  Copyright © 2017 Eric Rhodes. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController
{
    NSString* dbToken;
    NSString* dbUserID;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_star1 setHidden:true];
    [_star2 setHidden:true];
    [_errorMessage setHidden:true];
    
    [_emailTextField setDelegate:self];
    [_passwordTextField setDelegate:self];
    
}





- (IBAction)singInButtonPressed:(id)sender {
    
    NSLog(@"Test");
    
    //Gets the texts of both fields
    NSString* emailValue = _emailTextField.text;
    NSString* passwordValue = _passwordTextField.text;
    
    if([emailValue isEqualToString:@""]|| [passwordValue isEqualToString:@""])
    {
        [_star1 setHidden:false];
        [_star2 setHidden:false];
        [_errorMessage setText:@"Please enter email and password"];
        [_errorMessage setHidden:false];
        
    }else{
        [_star1 setHidden:true];
        [_star2 setHidden:true];
        [_errorMessage setHidden:true];
        
        //Send request
        dbToken = NULL;
        [self loginUser:emailValue :passwordValue];
        
        while(dbToken == NULL);
        
        if(dbToken.length == 50){
            NSLog(@"TESTETS");
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:dbToken forKey:@"accessToken"];
            [prefs setObject:passwordValue forKey:@"password"];
            [prefs setObject:emailValue forKey:@"userID"];
            
            //Go to previous view
            [self manageCows];
            
        }else{
            NSLog(@"User is not in system");
            [_errorMessage setText:@"Please create an account."];
            [_errorMessage setHidden:false];
            [_star1 setHidden:false];
            [_star2 setHidden:false];
        }
    
    }
    
    //[self manageCows];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [UIView animateWithDuration:0.25 animations:^{
        //CGRect frame = textField.frame;
        //frame.origin.y -= 100;
        //textField.frame = frame;
        [self.view setFrame:CGRectMake(0,-110,320,460)];
    }];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    
    
    
    [self.view endEditing:YES];
    return YES;
}

- (IBAction)test:(id)sender {
    NSLog(@"Test");
}



-(BOOL)textFieldShouldReturn:(UITextField*) textField
{
    NSLog(@"TestTest");
    [_passwordTextField resignFirstResponder];
    [_emailTextField resignFirstResponder];
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        //CGRect frame = textField.frame;
        //frame.origin.y += 100;
        //textField.frame = frame;
        CGSize s = self.view.frame.size;
        [self.view setFrame:CGRectMake(0,0,s.width,s.height)];

    }];
    
    
    
    return YES;
}

-(void)manageCows{
    [self performSegueWithIdentifier:@"manage" sender:self];
    
}

-(void)loginUser: (NSString*) userID :(NSString*) password
{
    
    NSString* url = [NSString stringWithFormat:@"http://erhodes.oucreate.com/Cows/accountSignIn.php?username=%@&password=%@", userID, password];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
        
        NSString* newToken = requestReply;
        
        //Set new Token
        dbToken = newToken;
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:newToken forKey:@"accessToken"];
        
        //FOR LOADING DATA
        //NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        //NSString *textToLoad = [prefs stringForKey:@"keyToFindText"];
        
        
        
    }] resume];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
