//
//  RWViewController.m
//  RWReactivePlayground
//
//  Created by Colin Eberhardt on 18/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "RWViewController.h"
#import "RWDummySignInService.h"



#import "ReactiveObjC/ReactiveObjC.h"

@interface RWViewController()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *signInFailureText;

@property (strong, nonatomic) RWDummySignInService *signInService;

@end

@implementation RWViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.signInService = [RWDummySignInService new];
  
    RACSignal *validUsernameSignal = [self.usernameTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable username) {
        return @([self isValidUsername: username]);
    }] ;
    
    RAC(self.usernameTextField, backgroundColor) = [validUsernameSignal map:^id _Nullable( NSNumber * usernameValid) {
        return usernameValid.boolValue ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    RACSignal *validPasswordSignal = [self.passwordTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable password) {
        return @([self isValidPassword: password]);
    }];
    RAC(self.passwordTextField, backgroundColor) = [validPasswordSignal map:^id _Nullable(NSNumber * passwordValid) {
        return passwordValid.boolValue ? [UIColor clearColor] : [UIColor yellowColor];
    }];

   // initially hide the failure message
   self.signInFailureText.hidden = YES;
    RACSignal * signUpActiveSignal = [RACSignal combineLatest: @[validUsernameSignal, validPasswordSignal] reduce:^id _Nullable(NSNumber * usernameValid, NSNumber * passwordValid){
        return @(usernameValid.boolValue && passwordValid.boolValue);
    }];
    /*
     The above code uses the combineLatest:reduce: method to combine the latest values emitted by validUsernameSignal and validPasswordSignal into a shiny new signal. Each time either of the two source signals emits a new value, the reduce block executes, and the value it returns is sent as the next value of the combined signal.
     Note: The RACSignal combine methods can combine any number of signals, and the arguments of the reduce block correspond to each of the source signals. ReactiveCocoa has a cunning little utility class, RACBlockTrampoline that handles the reduce block’s variable argument list internally. In fact, there are a lot of cunning tricks hidden within the ReactiveCocoa implementation, so it’s well worth pulling back the covers!
     */
    [signUpActiveSignal subscribeNext:^(NSNumber * signupActive) {
        self.signInButton.enabled = signupActive.boolValue;
    }];
    
    [[self.signInButton rac_signalForControlEvents: UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"Button Clicked");
    }];
    
    
}

- (BOOL)isValidUsername:(NSString *)username {
  return username.length > 3;
}

- (BOOL)isValidPassword:(NSString *)password {
  return password.length > 3;
}



#pragma mark - Signals and getters



- (RACSignal *) signInSignal{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self.signInService signInWithUsername:self.usernameTextField.text password:self.passwordTextField.text complete:^(BOOL success) {
            [subscriber sendNext: @(success)];
            [subscriber sendCompleted];
            
        }];
        return nil;
        //createSignal
    }];

}




@end

#pragma mark - step One

/*

// handle text changes for both text fields
[self.usernameTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
    NSLog(@"%@", x);
}];

 ReactiveCocoa signals (represented by RACSignal) send a stream of events to their subscribers. There are three types of events to know: next, error and completed. A signal may send any number of next events before it terminates after an error, or it completes. In this part of the tutorial you’ll focus on the next event. Be sure to read part two when it’s available to learn about error and completed events.
 
*/



#pragma mark - step Two


/*
 
 
 [[self.usernameTextField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
 NSString * text = value;
 return text.length > 3;
 }] subscribeNext:^(NSString * _Nullable x) {
 NSLog(@"%@", x);
 }];
 
 
 
 
 ReactiveCocoa has a large range of operators you can use to manipulate streams of events. For example, assume you’re only interested in a username if it’s more than three characters long. You can achieve this by using the filter operator. Update the code you added previously in viewDidLoad to the following:
 

 
 
 */


#pragma mark - step Three
/*
 At this point it’s worth noting that the output of the filter operation is also an RACSignal. You could arrange the code as follows to show the discrete pipeline steps:

RACSignal * usernameSourceSignal = self.usernameTextField.rac_textSignal;
RACSignal * filterUsernameSignal = [usernameSourceSignal filter:^BOOL(id  _Nullable value) {
    NSString *tmpStr = value;
    return tmpStr.length > 3;
}];
[filterUsernameSignal subscribeNext:^(id  _Nullable x) {
    NSLog(@"x 3rd: %@", x);
}];
 
  */
#pragma mark - step Four

/*
[[self.usernameTextField.rac_textSignal filter:^BOOL(NSString * text) {
    return text.length > 3;
}] subscribeNext:^(NSString * _Nullable x) {
    NSLog(@"%@", x);
}];


 The implicit cast from id to NSString, at the indicated location in the code above, is less than elegant. Fortunately, since the value passed to this block is always going to be an NSString, you can change the parameter type itself. Update your code as follows:
 */


#pragma mark - What’s An Event?


/*
 [[[self.usernameTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable text) {
 return @(text.length);
 }]
 filter:^BOOL(NSNumber * length) {
 return length.integerValue > 3;
 }]
 subscribeNext:^(id  _Nullable x) {
 NSLog(@"%@", x);
 }];
 
 The newly added map operation transforms the event data using the supplied block. For each next event it receives, it runs the given block and emits the return value as a next event. In the code above, the map takes the NSString input and takes its length, which results in an NSNumber being returned.
 */


#pragma mark - Creating Valid State Signals
/*
 RACSignal *validUsernameSignal = [self.usernameTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable username) {
 return @([self isValidUsername: username]);
 }] ;
 
 [[validUsernameSignal map:^id _Nullable( NSNumber * passwordValid) {
 return passwordValid.boolValue ? [UIColor clearColor] : [UIColor yellowColor];
 }]
 subscribeNext:^(UIColor * color) {
 self.usernameTextField.backgroundColor = color;
 }];
 
 
 
 
 As you can see, the above code applies a map transform to the rac_textSignal from each text field. The output is a boolean value boxed as a NSNumber.
 The next step is to transform these signals so that they provide a nice background color to the text fields. Basically, you subscribe to this signal and use the result to update the text field background color. One viable option is as follows:
 
 */


#pragma mark - step Seven

/*
 
 RAC(<#TARGET, ...#>)
 
 
 
 
 Conceptually you’re assigning the output of this signal to the backgroundColor property of the text field. However, the code above is a poor expression of this; it’s all backwards!
 Fortunately, ReactiveCocoa has a macro that allows you to express this with grace and elegance. Add the following code directly beneath the two signals you added to viewDidLoad:
 
 */


