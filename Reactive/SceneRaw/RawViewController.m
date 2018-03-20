//
//  RawViewController.m
//  Reactive
//
//  Created by dengjiangzhou on 2018/3/20.
//  Copyright © 2018年 dengjiangzhou. All rights reserved.
//

#import "RawViewController.h"



//
#import "ReactiveObjC/ReactiveObjC.h"


@interface RawViewController()



@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (nonatomic, copy) NSString *username;


@property (weak, nonatomic) IBOutlet UIButton *racButton;



@end

@implementation RawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    
    self.racButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"racButton was pressed");
        return [RACSignal empty];
    }];
    
    

    
#if 0
    [[RACObserve(self, username) filter:^BOOL(NSString * newName) {
        return [newName hasPrefix: @"de"];
    }] subscribeNext:^(NSString * newName) {
        NSLog(@"new user name, %@", newName);
    }];
#endif
    
    
#if 0
    [RACObserve(self, username) subscribeNext:^(NSString * newName) {
        NSLog(@"new user name, %@", newName);
    }];
    
#endif
    
}





- (IBAction)comfirmButton:(UIButton *)sender {
    
    self.username = self.nameTextField.text;
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end



/*
 不会的 :
 
 RAC(self, createEnabled)
 
 
 */
