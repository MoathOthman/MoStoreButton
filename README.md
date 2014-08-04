MoStoreButton
=============

simple-to-use iOS 7 Appstore like button




#Requirements

- Xcode 5 
- iOS 7.0 + 
- ARC



#USAGE

### Adding the Button
   Here we should  set  the titles,finishedDownloadingButtonTitle, and buttonDelegate !!!. 
 
   	MOStoreButton*storeButton1 =[[MOStoreButton alloc]initWithFrame:CGRectMake(100, 260,80, 40) andColor:[UIColor blueColor]];
   
    storeButton1.buttonDelegate=self;
    storeButton1.titleLabel.font =[UIFont systemFontOfSize:17];
    storeButton1.finishedDownloadingButtonTitle =@"Open";
    [storeButton1 setTitles:@[@"free",@"INSTALL"]];
    [self.view addSubview:storeButton1]; 


### Delegate

We Care here about the currentIndex which determine the state of the button transition, see the demo for more clarification

	-(void)storeButtonFired:(MOStoreButton *)button{
    
    NSLog(@"click  %i",button.currentIndex);
    
	}

	

	