//
//  LoginViewController.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/10/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "LoginViewController.h"
#import <FirebaseAuth/FirebaseAuth.h>


@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIButton *loginBt;

@property (weak, nonatomic) IBOutlet UITextField *emailTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;

@property (weak, nonatomic) IBOutlet UILabel *forgotPwLb;
@property (weak, nonatomic) IBOutlet UILabel *createAccLb;

- (IBAction)loginAction:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _loginView.layer.cornerRadius = 5.0f;
    _loginView.clipsToBounds = YES;
    
    _loginView.layer.borderWidth = 1.0;
    _loginView.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor;
    
    _loginBt.layer.cornerRadius = 5.0f;
    _loginBt.clipsToBounds = YES;
    
    _loginBt.layer.masksToBounds = NO;
    _loginBt.layer.shadowOpacity = 1.f;
    _loginBt.layer.shadowOffset = CGSizeMake(0, 6);
    _loginBt.layer.shadowColor = [UIColor colorWithRed:254.0/255.0 green:181/255.0 blue:173/255.0 alpha:1.0].CGColor;
    
    _emailTf.delegate = self;
    _passwordTf.delegate = self;
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgotPwAction)];
    [_forgotPwLb addGestureRecognizer:tapGesture1];
    _forgotPwLb.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createNewAccAction)];
    [_createAccLb addGestureRecognizer:tapGesture2];
    _createAccLb.userInteractionEnabled = YES;
    
}

- (void) forgotPwAction{
    
}

- (void) createNewAccAction{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginAction:(id)sender {
    
    if(_emailTf.text.length && _passwordTf.text.length){
        
        [[FIRAuth auth] signInWithEmail:_emailTf.text
                               password:_passwordTf.text
                             completion:^(FIRUser *user, NSError *error) {
                                 
                                 NSLog(@"error %@",error);
                                 
                                 
                             }];
    }
    
    
}
@end
