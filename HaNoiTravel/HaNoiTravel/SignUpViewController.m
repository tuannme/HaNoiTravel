//
//  SignUpViewController.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/11/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "SignUpViewController.h"

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
}
@end
