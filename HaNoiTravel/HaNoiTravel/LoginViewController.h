//
//  LoginViewController.h
//  HaNoiTravel
//
//  Created by Dreamup on 1/10/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;

- (IBAction)backAction:(id)sender;

@end
