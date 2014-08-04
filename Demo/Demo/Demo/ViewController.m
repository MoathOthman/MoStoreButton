//
//  ViewController.m
//  Demo
//
//  Created by moath othman on 6/18/14.
//  Copyright (c) 2014 com.w. All rights reserved.
//

#import "ViewController.h"
#import "MOStoreButton.h"
 @interface ViewController ()<MOStoreButtonDelegate>
{
    MOStoreButton *storeButton;
    float currentProgress;
}
 
@end

@implementation ViewController
-(void)updateProgress:(MOStoreButton*)button{
    if (currentProgress>=1) {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        
        return;
        
    }
    currentProgress+=0.04f;
    //    NSLog(@"current progress is %f",currentProgress);
    [button setProgress:currentProgress animated:YES];
    [self performSelector:@selector(updateProgress:) withObject:button afterDelay:.04];
}

-(void)startDownloading:(MOStoreButton*)button{
    //    [storeButton performSelector:@selector(startDownloading) withObject:nil afterDelay:2];
    currentProgress=0;
    [self performSelector:@selector(updateProgress:) withObject:button afterDelay:2];
    
}
-(void)storeButtonFired:(MOStoreButton *)button{
    
    NSLog(@"click  %i",button.currentIndex);
    if (button.currentIndex ==-1){
        // Clicked after downloading the ' open' button
        NSLog(@"button Finish state clicked ");

    }
    else if (button.currentIndex ==0){
        NSLog(@"buttonClickedFirstTime");
        // to cancel downloading selector if exists
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [NSObject cancelPreviousPerformRequestsWithTarget:button];
        currentProgress =0;
    }else if (button.currentIndex==1){
        
        NSLog(@"buttonClickedSecondTime");
        // to mimic download operation
        [self performSelector:@selector(startDownloading:) withObject:button afterDelay:2];
    }
}


#pragma mark view life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    currentProgress =0;
    
    
    
    /*setup first golden button to buy */
    
    storeButton =[[MOStoreButton alloc]initWithFrame:CGRectMake(100, 200, 80, 100) andColor:blueColor_macro];
    storeButton.buttonDelegate=self;
    storeButton.titleLabel.font =[UIFont systemFontOfSize:13];
    storeButton.isInTestingMode=YES;
    storeButton.finishedDownloadingButtonTitle=@"Open ~>";
    [storeButton setTitles:@[@"$0.99",@"buy"]];
    
    
    [self.view addSubview:storeButton];
    
    
    /*setup second but blue Free button*/
    
    MOStoreButton*storeButton1 =[[MOStoreButton alloc]initWithFrame:CGRectMake(100, 260, 80, 40) andColor:[UIColor blueColor]];
    storeButton1.buttonDelegate=self;
    storeButton1.titleLabel.font =[UIFont systemFontOfSize:17];
    storeButton1.finishedDownloadingButtonTitle =@"Open";
    [storeButton1 setTitles:@[@"free",@"INSTALL"]];
    
    
    [self.view addSubview:storeButton1];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
