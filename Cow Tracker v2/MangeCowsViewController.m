//
//  MangeCowsViewController.m
//  Cow Tracker v2
//
//  Created by Eric Rhodes on 10/3/17.
//  Copyright © 2017 Eric Rhodes. All rights reserved.
//

#import "MangeCowsViewController.h"
#import "SWRevealViewController.h"
#import "CowTableViewCell.h"
#import "CowDataViewController.h"

@interface MangeCowsViewController ()

@end

@implementation MangeCowsViewController{

    NSArray *nameData;
    NSArray *weightData;
    int currentIndex;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    currentIndex = 0;
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.homeButton setTarget: self.revealViewController];
        [self.homeButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    
    nameData = [NSArray arrayWithObjects:@"", nil];
    weightData = [NSArray arrayWithObjects:@"", nil];
    
    NSLog(@"Test");
    NSArray* array1 = [self getTokenAndDate:@"erhodes71"];
    for (id obj in array1){
        NSLog(@"%@", obj);
    }
    //Authenticate the user
    
        //Check token status
        //Login if timed out
    
            //Get current token saved on device
            //Get token & time from DB
    
    
            //Compare
                //If good and time is not past 20 min: procede
                    //Update the time
                //Else
                    //Login
    
        //If not current user, use pop-up to create account...
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTableView:)];
    [self.tableView addGestureRecognizer:tap];
    
    
    [self loadListOfCattle];
}

//Add touch event to table view
-(void) didTapOnTableView:(UIGestureRecognizer*) recognizer {
    CGPoint tapLocation = [recognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
    
    if (indexPath) { //we are in a tableview cell, let the gesture be handled by the view
        recognizer.cancelsTouchesInView = NO;
        //NSLog(@"INDEX: %ld\n", (long)indexPath.row);
        currentIndex = (int)indexPath.row;
        [self presentCowData];
        
    } else { // anywhere else, do what is needed for your case
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"CowData"]) {
        
        // Get destination view
        CowDataViewController *vc = [segue destinationViewController];
        
        vc.cowName = [nameData objectAtIndex:currentIndex];
        //NSLog(@"Cow Name: %@", [nameData objectAtIndex:currentIndex]);
        
        // Pass the information to your destination view
        //[vc setSelectedButton:tagIndex];
    }
}


-(void)presentCowData
{
    [self performSegueWithIdentifier:@"CowData" sender:self];
}

//Pulls up view to handle adding a new cow
- (IBAction)addCow:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AddCow" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AddCowFirstViewController"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//UIModalTransitionStyleFlipHorizontal
    [self presentViewController:vc animated:YES completion:NULL];
    
    
}

-(NSArray* )getTokenAndDate: (NSString*) userID
{
    
    NSString* url = [NSString stringWithFormat:@"http://erhodes.oucreate.com/Cows/getCurrentToken.php?userID=%@", userID];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
    NSString *reply = @"";
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        [reply stringByAppendingString: @"String 2"];
        NSLog(@"requestReply: %@", requestReply);
    }] resume];
    
    NSData *objectData = [reply dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:objectData options:kNilOptions error: &error];
    
    return jsonArray;
}

//Gets the list of cattle
-(void)loadListOfCattle
{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString* userName = [prefs stringForKey:@"userID"];

    NSArray* array = NULL;
    
    NSString* accessToken = [prefs stringForKey:@"accessToken"];
    
    NSString* url = [NSString stringWithFormat:@"http://erhodes.oucreate.com/Cows/getListOfCows.php?userID=%@&token=%@&q=%@",userName,accessToken,@"QueryByName"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
        
        NSString *requestResult1 = [requestReply
                                         stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSString *requestResult2 = [requestResult1
                                         stringByReplacingOccurrencesOfString:@"]" withString:@""];
        NSString *requestResult3 = [requestResult2
                                    stringByReplacingOccurrencesOfString:@"[" withString:@""];
        
        NSLog(@"%@", requestResult3);
        
        NSArray* sets = [requestResult3 componentsSeparatedByString:@":"];
        nameData = [sets[0] componentsSeparatedByString:@","];
        weightData = [sets[1] componentsSeparatedByString:@","];
        
        //[_tableView reloadData]; <<-- This doesn't run on main thread... don't use...
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        
        NSLog(@"FINISHED");
    }] resume];

    
    
}


//Gets the number of rows in the section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [nameData count];
}


//Adds the cell based on the data
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"CowTableViewCell";
    
    CowTableViewCell *cell = (CowTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CowTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.name.text = [nameData objectAtIndex:indexPath.row];
    cell.weight.text = [weightData objectAtIndex:indexPath.row];
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
