//
//  AddCowSecondViewController.m
//  Cow Tracker v2
//
//  Created by Eric Rhodes on 12/28/17.
//  Copyright © 2017 Eric Rhodes. All rights reserved.
//

#import "AddCowSecondViewController.h"

@interface AddCowSecondViewController ()

@end

@implementation AddCowSecondViewController
{
    bool isSubmitted;
    NSString* requestBack;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _notesTextView.delegate = self;
    isSubmitted = false;
    
    [self.view setUserInteractionEnabled:true];
    
    //What you get back from the request
    requestBack = NULL;
    
    if(!isSubmitted)
    {
        [_submitButton setTitle:@"Submit" forState: UIControlStateNormal];
    }else{
        [_submitButton setTitle:@"OK" forState: UIControlStateNormal];

    }
}





- (IBAction)nextButtonPressed:(id)sender {
    
    
    if(!isSubmitted){
        
        //__block NSString* result = NULL;
        
        
        //Save all data
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        //User information
        NSString* userName = [prefs stringForKey:@"userID"];
        NSString* accessToken = [prefs stringForKey:@"accessToken"];
        NSLog(@"ACCESS TOKEN: %@", accessToken);
        //Variables to be put inthe request
        NSString *name = [prefs stringForKey:@"tempName"];
        NSString *brand = [prefs stringForKey:@"tempBrand"];
        NSString *parent1 = [prefs stringForKey:@"tempParent1"];
        NSString *parent2 = [prefs stringForKey:@"tempParent2"];
        NSString *birthDate = [prefs stringForKey:@"tempBirthDate"];
        NSString *datePurchased = [prefs stringForKey:@"tempDatePurchased"];
        NSString *currentWeight = [prefs stringForKey:@"tempCurrentWeight"];
        NSString *birthWeight = [prefs stringForKey:@"tempBirthWeight"];
        
        NSString *amountPaid = _amountPaidTextField.text;
        NSString *vaccinations = _vaccinationsTextField.text;
        NSString *notes = _notesTextView.text;
        NSString *boughtFrom = _boughtFromTextField.text;
        
        
        //SEND THE REQUEST HERE...
        //NSString *url = [NSString stringWithFormat:@"http://erhodes.oucreate.com/Cows/addCow.php?userID=%@&name=%@&brand=%@&token=%@&parent1=%@&parent2=%@&dateBirth=%@&datePurchased=%@&boughtFrom=%@&weightCurrent=%@&amountBought=%@&vaccinations=%@&calfInfo=%@&weightBirth=%@", userName, name, brand, accessToken, parent1, parent2, birthDate, datePurchased, boughtFrom, currentWeight, amountPaid, vaccinations, notes, birthWeight];
        
        //NSString* url = [NSString stringWithFormat:@"http://erhodes.oucreate.com/Cows/addCow.php?userID=%@&name=%@&token=%@&brand=%@&parent1=%@&parent2=%@&dateBirth=%@&datePurchased=%@&boughtFrom=%@&weightCurrent=%@&amountBought=%@&vaccinations=%@&calfInfo=%@&weightBirth=%@", userName, name, accessToken, brand, parent1, parent2, birthDate, datePurchased, boughtFrom, currentWeight, amountPaid, vaccinations, notes, birthWeight];
        
        //NSString* url = [NSString stringWithFormat:@"http://erhodes.oucreate.com/Cows/addCow.php"];
        
        //NSLog(@"Url: %@", url);
        
        //URL 2
        //NSString *url2 = [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        
        /*NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"GET"];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSLog(@"requestReply: %@", requestReply);
            
            requestBack = requestReply;*/
        
        /*NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"GET"];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSLog(@"requestReply: %@", requestReply);
            
            result = requestReply;
            
        }] resume];*/
        
        NSString* url = [NSString stringWithFormat:@"http://erhodes.oucreate.com/Cows/addCow.php"];

        
        
        NSString *post = [NSString stringWithFormat:@"userID=%@&name=%@&token=%@&brand=%@&parent1=%@&parent2=%@&dateBirth=%@&datePurchased=%@&boughtFrom=%@&weightCurrent=%@&amountBought=%@&vaccinations=%@&calfInfo=%@&weightBirth=%@", userName, name, accessToken, brand, parent1, parent2, birthDate, datePurchased, boughtFrom, currentWeight, amountPaid, vaccinations, notes, birthWeight];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];

        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];

        if(conn) {
            NSLog(@"Connection Successful");
        } else {
            NSLog(@"Connection could not be made");
        }
        
        
        
        
        //Waits til the request is finished
        //while(requestBack == NULL);
        
        //Make popup
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:@"Cow added to database"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        
        
    }else{
        
        //Go back
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Main"];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//UIModalTransitionStyleFlipHorizontal
        [self presentViewController:vc animated:YES completion:NULL];
        
    }
    
    //Load data
    //NSString *textToLoad = [prefs stringForKey:@"keyToFindText"];
    
    
    
    
    //ViewController *NVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddCowSecondViewController"];
    //[self presentViewController:NVC animated:YES completion:nil];
    
}


// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"DATA: %@", stringData);
    requestBack = stringData;
    isSubmitted = true;
    [_submitButton setTitle:@"OK" forState: UIControlStateNormal];

    
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    isSubmitted = false;
    [_submitButton setTitle:@"Submit" forState: UIControlStateNormal];
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //Probably dont need to add anything here...
}



- (IBAction)cancelButtonPressed:(id)sender {
    
    //Go back
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Main"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//UIModalTransitionStyleFlipHorizontal
    [self presentViewController:vc animated:YES completion:NULL];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_vaccinationsTextField resignFirstResponder];
    [_notesTextView resignFirstResponder];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self performSelectorOnMainThread:@selector(keyboardDidShow:) withObject:nil waitUntilDone:NO];

}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [self performSelectorOnMainThread:@selector(keyboardDidHide:) withObject:nil waitUntilDone:NO];

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
    
    [_amountPaidTextField resignFirstResponder];
    [_boughtFromTextField resignFirstResponder];
    [_vaccinationsTextField resignFirstResponder];
    [_notesTextView resignFirstResponder];
    
    
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
    // Assign new frame to your view
    //[self.view setFrame:CGRectMake(0,-110,320,460)]; //here taken -110 for example i.e. your view will be scrolled to -110. change its value according to your requirement.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    if([self.notesTextView isFirstResponder]){
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = f.origin.y - 180;
            //self.view.frame = f;
            [self.view setFrame:f];
        }];
    }else if([self.vaccinationsTextField isFirstResponder]){
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = f.origin.y - 40;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
