//
//  ViewController.h
//  Starbucks API Explorer
//
//  Created by Ravi on 8/7/13.
//  Copyright (c) 2013 Starbucks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {

    IBOutlet UITextField *ResourceLocator;
    IBOutlet UITextView *ResponseViewer;
    IBOutlet UITextField *Params;
    IBOutlet UITextField *Login;
    IBOutlet UITextField *Password;
}
- (IBAction)Submit:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *method;
@property (strong, nonatomic) IBOutlet UISegmentedControl *outputType;
@property(strong, nonatomic) UITextField *userInput;
@property(strong, nonatomic) UITextView *userOutput;
@property(strong, nonatomic) UITextField *userParams;
@property(strong, nonatomic) UITextField *username;
@property(strong, nonatomic) UITextField *password;
@end
