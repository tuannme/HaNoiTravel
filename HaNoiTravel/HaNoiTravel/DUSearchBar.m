//
//  DUSearchBar.m
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/19/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "DUSearchBar.h"

static DUSearchBar *searchBar;

@implementation DUSearchBar

+ (id) shareInstance{
    
    CGFloat frameW = [[UIScreen mainScreen] bounds].size.width;
    
    searchBar = [[DUSearchBar alloc] initWithFrame:CGRectMake(0, 0,frameW, 60)];
    searchBar.backgroundColor = [UIColor clearColor];
    
    UIView *blueView = [[UIView alloc] initWithFrame:searchBar.frame];
    blueView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.7];
    [searchBar addSubview:blueView];
    
    UIButton *cancel = [[UIButton  alloc] initWithFrame:CGRectMake(frameW - 60, 0, 60, 60)];
    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [searchBar addSubview:cancel];
    [cancel addTarget:searchBar action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];

    UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, frameW - 80 , 40)];
    [searchField setBorderStyle:UITextBorderStyleNone];
    searchField.layer.cornerRadius = 10;
    searchField.clipsToBounds = YES;
    [searchBar addSubview:searchField];
    
    return searchBar;
}

- (void) cancelAction{
    CGRect frame = searchBar.frame;
    frame.origin.x = frame.size.width;
    
    [UIView animateKeyframesWithDuration:0.3 delay:0.0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        searchBar.frame = frame;
    }completion:^(BOOL completion){
        
    }];
    
}

- (void) showWithFrame:(CGRect)frame{
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:searchBar];
    
    frame.origin.x = -frame.size.width;
    searchBar.frame = frame;
    frame.origin.x = 0;
    
    [UIView animateKeyframesWithDuration:0.3 delay:0.0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        searchBar.frame = frame;
    }completion:^(BOOL completion){
        
    }];
    
}

@end
