//
//  MainMenuViewController.m
//  Cow Tracker v2
//
//  Created by Eric Rhodes on 10/1/17.
//  Copyright © 2017 Eric Rhodes. All rights reserved.
//

#import "MainMenuViewController.h"
#import "SWRevealViewController.h"

@interface MainMenuViewController ()
{

    NSString* dbToken;
    NSString* dbDate;
}

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.homeButton setTarget: self.revealViewController];
        [self.homeButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    NSString* tempForSAVEDDATE_TOKEN = @"";
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [_activityIndicator startAnimating];
    //[prefs setObject:tempForSAVEDDATE_TOKEN forKey:@"accessToken"];
    //[prefs setObject:@"" forKey:@"password"];
    //[prefs setObject:@"" forKey:@"userID"];
    
    //Goes from here
    //[self userBranch];
    
    
    //Update the time*
    //Else
    //Login
    
    //If not current user, use pop-up to create account...

    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self userBranch];
    
}

-(void)userVerification
{
    bool isUserVarified = false;
    while(!isUserVarified){
        
        //IF STATEMENT HERE FOR CHECKING IF USER IS ON PHONE
        dbToken = NULL;
        dbDate = NULL;
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString* user = [prefs stringForKey:@"userID"];
        [self getTokenAndDate:user];
        
        //NEED TO DO LOGIN HERE THEN AND SEE IF THE USER IS IN SYSTEM
        
        
        
        //Authenticate the user
        
        //Check token status
        //Login if timed out
        
        //Get current token saved on device
        //Get token & time from DB
        while(dbToken == NULL || dbDate == NULL);
        
        //NSLog(@"%@", dbDate);
        //NSLog(@"%@", dbToken);
        
        //Compare
        //If good and time is not past 20 min: procede
        //NSArray* dateTest = [dbDate componentsSeparatedByString:@":"];
        //NSLog(@"%@",dateTest[0]);
        
        //WHERE DID I LEAVE OFF??????
        //---------------------------
        //YOU NEED TO NARROW DOWN IF THE MIDDLE PART OF THE RETURN IS GREATER THAN 20 MIN... EASY
        //THEN MOVE ON TO THE STEPS BELOW
        //TRY AND GET THIS SKELITION DONE
        //MAKE SURE ITS ORGANIZED AND MAKES SENSE USING...
        //THIS WEEK WE FOCUS ON MAKING IT UI user FRIENDLY
        
        int timeDiffernece = [dbDate integerValue];;
        //NSLog(@"TIME: %@", dbDate);
        //NSLog(@"ALSO: %d", timeDiffernece);
        
        
        if(timeDiffernece > 20)
        {
            NSLog(@"THIS SESSION HAS TIMED OUT");
            //LOGIN THE USER
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

            NSString* user = [prefs stringForKey:@"userID"];
            NSString* pass = [prefs stringForKey:@"password"];
            
            [self loginUser:user:pass];
            
        }else{
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            //NSString *textToLoad = [prefs stringForKey:@"keyToFindText"];
            //USER IT GOOD TO MOVE FORWARD
            NSString* accessToken = [prefs stringForKey:@"accessToken"];
            
            NSString* user = [prefs stringForKey:@"userID"];
            NSString* pass = [prefs stringForKey:@"password"];
            
            if([dbToken isEqualToString:accessToken])
            {
                isUserVarified = true;
                NSLog(@"USER IS VALID");
                
                dbToken = NULL;
                
                //NEED TO UPDATE THE TIME OF VERIFICATION
                [self updateTime:user :accessToken];
                while(dbToken != NULL);
                
                isUserVarified = true;
                [_waitingScreen setHidden:true];
                [_activityIndicator stopAnimating];
                
                
                //Send request to get the information with current token
                
                
                return;
                
            }else{
                NSLog(@"THIS SESSION HAS TIMED OUT");
                
                dbToken = NULL;
                //LOGIN THE USER
                [self loginUser:user:pass];
                while(dbToken != NULL);
                return;

            }
            
        }
    }
    
    return;
}

-(void)loadUserData
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString* user = [prefs stringForKey:@"userID"];
    NSString* pass = [prefs stringForKey:@"password"];
}

-(void)userBranch
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString* userName = [prefs stringForKey:@"userID"];
    NSString* password = [prefs stringForKey:@"password"];
    NSString* accessTokenDev = [prefs stringForKey:@"accessToken"];
    
    if([userName isEqualToString:@""])
    {
        NSLog(@"No current user on device");
        //Make popup and it should stay there
        [self SignUpTransition];
        
        
    }else{
        
        [self userVerification];
    }

    return;
}

-(void)updateTime: (NSString* )userID: (NSString* )token
{
    NSString* url = [NSString stringWithFormat:@"http://erhodes.oucreate.com/Cows/updateTime.php?userID=%@&token=%@", userID, token];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
        
    }] resume];
}

-(void)getTokenAndDate: (NSString*) userID
{
    
    NSString* url = [NSString stringWithFormat:@"http://erhodes.oucreate.com/Cows/getCurrentToken.php?userID=%@", userID];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
        
        NSArray* array1 = [requestReply componentsSeparatedByString:@","];
        NSString* token1 = [array1[0] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSString* date1 = [array1[1] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        
        NSString* token = [token1 stringByReplacingOccurrencesOfString:@"[" withString:@""];
        NSString* date = [date1 stringByReplacingOccurrencesOfString:@"]" withString:@""];
        
        
        dbToken = token;
        dbDate = date;
        
        //NSLog(@"%@", dbDate);
        //NSLog(@"%@", dbToken);
        
       
    }] resume];
    
    

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

-(void)SignUpTransition{
    [self performSegueWithIdentifier:@"SignIn" sender:self];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
