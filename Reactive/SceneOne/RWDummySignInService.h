//
//  RWDummySignInService.h
//  RWReactivePlayground
//
//  Created by Colin Eberhardt on 18/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RWSignInResponse)(BOOL);

@interface RWDummySignInService : NSObject

- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(RWSignInResponse)completeBlock;

@end



/*
 
 This service takes a username, a password and a completion block as parameters. The given block is run when the sign-in is successful or when it fails. You could use this interface directly within the subscribeNext: block that currently logs the button touch event, but why would you? This is the kind of asynchronous, event-based behavior that ReactiveCocoa eats for breakfast!
 Note: A dummy service is being used in this tutorial for simplicity, so that you don’t have any dependencies on external APIs. However, you’ve now run up against a very real problem, how do you use APIs not expressed in terms of signals?
 
 */
