//
//  ViewController.m
//  Starbucks API Explorer
//
//  Created by Ravi on 8/7/13.
//  Copyright (c) 2013 Starbucks. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize userInput;
@synthesize userParams;
@synthesize userOutput;
@synthesize username;
@synthesize password;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Submit:(id)sender {
    ResponseViewer.text =  [self makeRequest];
}


- (NSString*) getAccessToken {
    NSString *urlString = @"https://test.openapi.starbucks.com/v1/oauth/token";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSMutableData *body = [NSMutableData data];
    NSString *requestBody = [NSString stringWithFormat:@"grant_type=password&username=%@&password=%@client_id=4eb5g2zdsbu2vuq3ndu6x4mx&client_secret=JbDMvr5ptGsfxxq4NvSX5RaV&scope=test_scope&api_key=4eb5g2zdsbu2vuq3ndu6x4mx", username.text, password.text];

    [body appendData:[[NSString stringWithFormat:@"%@\r\n", requestBody] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // set request body
    [request setHTTPBody:body];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    //return and test
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", returnString);
    
    NSData *JSONData = [returnString dataUsingEncoding:NSUTF8StringEncoding];
    
    userOutput.text = returnString;
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    
    return [json objectForKey:@"access_token"];
    
}

- (NSString*) makeRequest {
    NSString *urlString = [NSString stringWithFormat:@"https://test.openapi.starbucks.com/%@", userInput.text];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:[NSString stringWithFormat:@"%@", _method.accessibilityValue]];
    
    if ([_outputType.accessibilityValue compare:@"Json" options:NSCaseInsensitiveSearch] == TRUE)[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    if ([_outputType.accessibilityValue compare:@"XML" options:NSCaseInsensitiveSearch] == TRUE)[request setValue:@"application/xml" forHTTPHeaderField:@"Accept"];
    
    
    if ([_method.accessibilityValue compare:@"POST" options:NSCaseInsensitiveSearch] == TRUE)
    {
        NSMutableData *body = [NSMutableData data];
        NSString *requestBody = userParams.text;
    
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", requestBody] dataUsingEncoding:NSUTF8StringEncoding]];
    
        // set request body
        [request setHTTPBody:body];
    }
    
    //return and test
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", returnString);
    userOutput.text = returnString;
    return returnString;
    
}
    
@end
