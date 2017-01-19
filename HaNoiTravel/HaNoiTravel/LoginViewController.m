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
#import "SpinnerView.h"
#import "Utils.h"
#import "User.h"
#import "NSString+Utils.h"

@import GoogleSignIn;

@interface LoginViewController ()<UITextFieldDelegate,GIDSignInDelegate,GIDSignInUIDelegate,FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIButton *loginBt;

@property (weak, nonatomic) IBOutlet UILabel *forgotPwLb;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbLoginBt;
@property (weak, nonatomic) IBOutlet UIButton *createAccBt;


- (IBAction)loginAction:(id)sender;
- (IBAction)loginGoogleAction:(id)sender;
- (IBAction)loginFaceBookAction:(id)sender;

@end

@implementation LoginViewController{
    
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
    
    /*
     CAGradientLayer *layer = [self blueGradient];
     layer.frame = [[UIScreen mainScreen] bounds];
     [self.view.layer insertSublayer:layer atIndex:0];
     */
}

- (CAGradientLayer*) blueGradient {
    
    UIColor *colorOne = [UIColor colorWithRed:(120/255.0) green:(135/255.0) blue:(150/255.0) alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:(57/255.0)  green:(79/255.0)  blue:(96/255.0)  alpha:1.0];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    return headerLayer;
    
}

- (CAGradientLayer*) greyGradient {
    
    UIColor *colorOne = [UIColor colorWithWhite:0.9 alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.85 alpha:1.0];
    UIColor *colorThree     = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.7 alpha:1.0];
    UIColor *colorFour = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.4 alpha:1.0];
    
    NSArray *colors =  [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor, colorFour.CGColor, nil];
    
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:0.02];
    NSNumber *stopThree     = [NSNumber numberWithFloat:0.99];
    NSNumber *stopFour = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, stopFour, nil];
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    return headerLayer;
    
}


- (void) forgotPwAction{
    
    if(_emailTf.text.isValidEmail){
        [Utils showAlert:@"" message:[NSString stringWithFormat:@"Do you want reset password account %@",_emailTf.text] completion:^(BOOL action){
            if(action){
                [[SpinnerView shareInstance] startAnimation];
                
                [[FIRAuth auth] sendPasswordResetWithEmail:_emailTf.text
                                                completion:^(NSError *_Nullable error) {
                                                    
                                                    if(error == nil){
                                                        [Utils showAlert:nil message:@"Please check your email to reset password !"];
                                                    }else{
                                                        [Utils showAlert:@"Falure !" message:[error.userInfo objectForKey:@"NSLocalizedDescription"]];
                                                    }
                                                    [[SpinnerView shareInstance] stopAnimation];
                                                }];
            }
        }];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginAction:(id)sender {
    
    if(_emailTf.text.length && _passwordTf.text.length){
        
        [[SpinnerView shareInstance] startAnimation];
        
        [[FIRAuth auth] signInWithEmail:_emailTf.text
                               password:_passwordTf.text
                             completion:^(FIRUser *user, NSError *error) {
                                 
                                 [[SpinnerView shareInstance] stopAnimation];
                                 if(error == nil){
                                     [self setUser:user];
                                     [self gotoMainViewController];
                                 }else{
                                     [Utils showAlert:@"Login falure !" message:[error.userInfo objectForKey:@"NSLocalizedDescription"]];
                                 }
                             }];
    }
}

- (IBAction)loginGoogleAction:(id)sender {
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    [[GIDSignIn sharedInstance] signIn];
    [[SpinnerView shareInstance] startAnimation];
}

- (IBAction)loginFaceBookAction:(id)sender {
    [[SpinnerView shareInstance] startAnimation];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue isKindOfClass:[SignUpSegue class]]) {
        // Set the start point for the animation to center of the button for the animation
        ((SignUpSegue *)segue).originatingPoint = self.createAccBt.center;
    }
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([identifier isEqualToString:@"loginSegue"]){
        return NO;
    }
    return YES;
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
        [[SpinnerView shareInstance] stopAnimation];
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
        [[SpinnerView shareInstance] stopAnimation];
        NSLog(@"%@", error.localizedDescription);
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    
}

- (void) loginWithCredential:(FIRAuthCredential*)credential{
    
    [[FIRAuth auth] signInWithCredential:credential
                              completion:^(FIRUser *user, NSError *error) {
                                  [[SpinnerView shareInstance] stopAnimation];
                                  if (!error) {
                                      [self setUser:user];
                                      [self gotoMainViewController];
                                  }else{
                                      [Utils showAlert:@"Login falure !" message:error.userInfo.description];
                                  }
                              }
     ];
}

- (void) gotoMainViewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController *mainVC = [sb instantiateViewControllerWithIdentifier:@"MainViewController"];
    [self.navigationController pushViewController:mainVC animated:YES];
}

- (void) setUser:(FIRUser*)user{
    [[User shareInstance] setDisplayName:user.displayName];
    [[User shareInstance] setEmail:user.email];
    [[User shareInstance] setPhotoURL:user.photoURL];
}


@end
