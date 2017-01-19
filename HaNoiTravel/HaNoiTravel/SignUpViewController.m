//
//  SignUpViewController.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/11/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "SignUpViewController.h"
#import "NSString+Utils.h"
#import "Utils.h"
#import "DUSpinnerView.h"
#import "LoginViewController.h"


@import Firebase;

@interface SignUpViewController ()

- (IBAction)closeAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *policyLb;
@property (weak, nonatomic) IBOutlet UIView *signUpView;

@property (weak, nonatomic) IBOutlet UITextField *emailTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;
@property (weak, nonatomic) IBOutlet UITextField *repasswordTf;
@property (weak, nonatomic) IBOutlet UIButton *signUpBt;

- (IBAction)signUpAction:(id)sender;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _signUpBt.clipsToBounds = YES;
    _signUpBt.layer.cornerRadius = 5.0f;
    
    _signUpBt.layer.masksToBounds = NO;
    _signUpBt.layer.shadowOpacity = 1.f;
    _signUpBt.layer.shadowOffset = CGSizeMake(0, 6);
    _signUpBt.layer.shadowColor = [UIColor colorWithRed:254.0/255.0 green:181/255.0 blue:173/255.0 alpha:1.0].CGColor;
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPolicy)];
    _policyLb.userInteractionEnabled = YES;
    [_policyLb addGestureRecognizer:tapGesture];
    
    self.view.clipsToBounds = YES;
    self.view.layer.cornerRadius = 6.0f;
}

- (void) showPolicy{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Terms & conditions" message:@"This is policy" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeAction:(id)sender {
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}
- (IBAction)signUpAction:(id)sender {
    if(_emailTf.text.length && [_emailTf.text isValidEmail]){
        if(_passwordTf.text.length >= 6){
            if( [_passwordTf.text isEqualToString:_repasswordTf.text]){
                
                [[DUSpinnerView shareInstance] startLoading];
                
                [[FIRAuth auth]
                 createUserWithEmail:_emailTf.text
                 password:_passwordTf.text
                 completion:^(FIRUser *_Nullable user,
                              NSError *_Nullable error) {
                     
                     if(error == nil){
                         UIViewController *loginVC = self.parentViewController;
                         if([loginVC isKindOfClass:[LoginViewController class]]){
                             [(LoginViewController*)loginVC emailTf].text = _emailTf.text;
                             [(LoginViewController*)loginVC passwordTf].text = _passwordTf.text;
                         }
                         [self closeAction:nil];
                         [Utils showAlert:nil message:@"sign up success !"];
                     }else{
                         [Utils showAlert:nil message:[error.userInfo objectForKey:@"NSLocalizedDescription"]];
                     }
                     [[DUSpinnerView shareInstance] stopLoading];
                     
                 }];
                
            }else{
                [Utils showAlert:nil message:@"Password don't match !Try again !"];
            }
        }else{
            [Utils showAlert:nil message:@"Please use at least 6 characters"];
        }
    }else{
        [Utils showAlert:nil message:@"Please enter a valid email !"];
    }
    
    
}
@end
