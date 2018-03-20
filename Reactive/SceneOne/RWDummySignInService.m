//
//  RWDummySignInService.m
//  RWReactivePlayground
//
//  Created by Colin Eberhardt on 18/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "RWDummySignInService.h"

@implementation RWDummySignInService


- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(RWSignInResponse)completeBlock {

    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        BOOL success = [username isEqualToString:@"user"] && [password isEqualToString:@"pass"];
        completeBlock(success);
    });
}


@end



/*
 - (void)signInButtonTouched:(id)sender {
 // disable all UI controls
 self.signInButton.enabled = NO;
 self.signInFailureText.hidden = YES;
 
 // sign in
 [self.signInService signInWithUsername:self.usernameTextField.text
 password:self.passwordTextField.text
 complete:^(BOOL success) {
 self.signInButton.enabled = YES;
 self.signInFailureText.hidden = success;
 if (success) {
 [self performSegueWithIdentifier:@"signInSuccess" sender:self];
 }
 }];
 }
 
 */



