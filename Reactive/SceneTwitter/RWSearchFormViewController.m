//
//  RWSearchFormViewController.m
//  TwitterInstant
//
//  Created by Colin Eberhardt on 02/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "RWSearchFormViewController.h"

//
#import "RWSearchResultsViewController.h"


//
#import <ReactiveObjC/ReactiveObjC.h>

#import <ReactiveObjC/RACEXTScope.h>

@interface RWSearchFormViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchText;

@property (strong, nonatomic) RWSearchResultsViewController *resultsViewController;

@property (strong, nonatomic) RACDisposable *subscription;

@end

@implementation RWSearchFormViewController

- (void)viewDidLoad{
    [super viewDidLoad];
  
    self.title = @"Twitter Instant";
  
    [self styleTextField:self.searchText];
  
    self.resultsViewController = self.splitViewController.viewControllers[1];
    
    @weakify(self);
    // @autoreleasepool {} __attribute__((objc_ownership(weak))) __typeof__(self) self_weak_ = (self);;
    
    [[self.searchText.rac_textSignal map:^id _Nullable(NSString * _Nullable text) {
        return [self isValidSearchText: text] ? [UIColor whiteColor] : [UIColor yellowColor];
    }]
     subscribeNext:^(UIColor *color) {
         @strongify(self);
         self.searchText.backgroundColor = color;
     }];
/*
 
 The @weakify and @strongify statements above are macros defined in the Extended Objective-C library, and they are also included in ReactiveCocoa. The @weakify macro allows you to create shadow variables which are weak references (you can pass multiple variables if you require multiple weak references), the @strongify macro allows you to create strong references to variables that were previously passed to @weakify.
 
 
 Note: If you’re interested in finding out what @weakify and @strongify actually do, within Xcode select Product -> Perform Action -> Preprocess “RWSearchForViewController”. This will preprocess the view controller, expand all the macros and allow you to see the final output.
 
 
 */
    
    

    
    
    
    
    /*
    RACSignal *backgroundColorSignal = [self.searchText.rac_textSignal map:^id _Nullable(NSString * _Nullable text) {
        return [self isValidSearchText: text] ? [UIColor whiteColor] : [UIColor yellowColor];
    }];
    self.subscription = [backgroundColorSignal subscribeNext:^(UIColor * color) {
        self.searchText.backgroundColor = color;
    }];
     
     
     
     
     In order to support this model, ReactiveCocoa maintains and retains its own global set of signals. If it has one or more subscribers, then the signal is active. If all subscribers are removed, the signal can be de-allocated. For more information on how ReactiveCocoa manages this process see the Memory Management documentation.
     That leaves on final question: How do you unsubscribe from a signal? After a completed or error event, a subscription removes itself automatically (you’ll learn more about this shortly). Manual removal may be accomplished via RACDisposable.
     The subscription methods on RACSignal all return an instance of RACDisposable that allows you to manually remove the subscription via the dispose method. Here is a quick example using the current pipeline:
     
     */
    
}



- (BOOL)isValidSearchText: (NSString *)text{
    return text.length > 2;
}



- (void)styleTextField:(UITextField *)textField {
  CALayer *textFieldLayer = textField.layer;
  textFieldLayer.borderColor = [UIColor grayColor].CGColor;
  textFieldLayer.borderWidth = 2.0f;
  textFieldLayer.cornerRadius = 0.0f;
}


#pragma mark - Deng Add


- (IBAction)dIsposeThis:(UIButton *)sender {
    
  //  [self.subscription dispose];// 失效了
    
}





@end


#pragma mark - Step One

/*
 
 // 宏 魔法
 [[self.searchText.rac_textSignal map:^id _Nullable(NSString * _Nullable text) {
 return [self isValidSearchText: text] ? [UIColor whiteColor] : [UIColor yellowColor];
 }]
 subscribeNext:^(UIColor *color) {
 self.searchText.backgroundColor = color;
 }];
 
 
 Wondering what that’s all about? The above code:
 Takes the search text field’s text signal
 Transforms it into a background color that indicates whether it is valid or not
 Then applies this to the text field’s backgroundColor property in the subscribeNext: block.
 Build and run to observe how the text field now indicates an invalid entry with a yellow background if the current search string is too short.
 
 
 // 宏 魔法
 RAC(self.searchText, backgroundColor) = [self.searchText.rac_textSignal map:^UIColor * _Nullable(NSString * _Nullable text) {
 return [self isValidSearchText: text] ? [UIColor whiteColor] : [UIColor yellowColor];
 }];
 */


#pragma mark - Step Two



/*

__weak RWSearchFormViewController *bSelf = self;

[[self.searchText.rac_textSignal map:^id _Nullable(NSString * _Nullable text) {
    return [self isValidSearchText: text] ? [UIColor whiteColor] : [UIColor yellowColor];
}]
 subscribeNext:^(UIColor *color) {
     bSelf.searchText.backgroundColor = color;
 }];





 The subscribeNext: block uses self in order to obtain a reference to the text field. Blocks capture and retain values from the enclosing scope, therefore if a strong reference exists between self and this signal, it will result in a retain cycle. Whether this matters or not depends on the lifecycle of the self object. If its lifetime is the duration of the application, as is the case here, it doesn’t really matter. But in more complex applications, this is rarely the case.
 In order to avoid this potential retain cycle, the Apple documentation for Working With Blocks recommends capturing a weak reference to self. With the current code you can achieve this as follows:
 
 
 
 // More:
 
 
 
 In the above code bself is a reference to self that has been marked as __weak in order to make it a weak reference. Notice that the subscribeNext: block now uses the bself variable. This doesn’t look terribly elegant!
 The ReactiveCocoa framework inlcudes a little trick you can use in place of the above code.
 */
