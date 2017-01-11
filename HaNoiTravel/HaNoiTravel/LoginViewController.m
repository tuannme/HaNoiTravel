//
//  LoginViewController.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/10/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "LoginViewController.h"
#import <FirebaseAuth/FirebaseAuth.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "MainViewController.h"
#import "SignUpSegue.h"

@import GoogleSignIn;

@interface LoginViewController ()<UITextFieldDelegate,GIDSignInDelegate,GIDSignInUIDelegate,FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIButton *loginBt;

@property (weak, nonatomic) IBOutlet UITextField *emailTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;

@property (weak, nonatomic) IBOutlet UILabel *forgotPwLb;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbLoginBt;
@property (weak, nonatomic) IBOutlet UIButton *createAccBt;


- (IBAction)loginAction:(id)sender;
- (IBAction)loginGoogleAction:(id)sender;

@end

@implementation LoginViewController{
    BOOL loginSuccess;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _fbLoginBt.delegate = self;
    _fbLoginBt.layer.cornerRadius = 20;
    _fbLoginBt.clipsToBounds = YES;
  
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
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgotPwAction)];
    [_forgotPwLb addGestureRecognizer:tapGesture];
    _forgotPwLb.userInteractionEnabled = YES;

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

- (IBAction)loginGoogleAction:(id)sender {
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    [[GIDSignIn sharedInstance] signIn];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue isKindOfClass:[SignUpSegue class]]) {
        // Set the start point for the animation to center of the button for the animation
        ((SignUpSegue *)segue).originatingPoint = self.createAccBt.center;
    }
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    //return loginSuccess;
    return YES;
}


- (void)perform{
    
}

#pragma mark - GOOGLE LOGIN
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if (error == nil) {
        GIDAuthentication *authentication = user.authentication;
        FIRAuthCredential *credential = [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
                                                                         accessToken:authentication.accessToken];
        [self loginWithCredential:credential];
    } else{
        NSLog(@"%@", error.localizedDescription);
    }
}
- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    
    
}


#pragma mark - FB LOGIN
- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error {
    if (error == nil) {
        FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                         credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                         .tokenString];
        [self loginWithCredential:credential];
    } else {
        NSLog(@"%@", error.localizedDescription);
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    
}

- (void) loginWithCredential:(FIRAuthCredential*)credential{
    
    [[FIRAuth auth] signInWithCredential:credential
                              completion:^(FIRUser *user, NSError *error) {
                                  if (!error) {
                                      
                                      UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                      MainViewController *mainVC = [sb instantiateViewControllerWithIdentifier:@"MainViewController"];
                                      [self.navigationController pushViewController:mainVC animated:YES];
                                      
                                      return;
                                  }
                              }
     ];
}
@end
