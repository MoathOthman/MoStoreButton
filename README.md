MoStoreButton
=============

simple-to-use iOS 7 Appstore like button




#Requirements

- Xcode 5 
- iOS 7.0 + 
- ARC

#Screen shot
[![https://gyazo.com/93e8c6aee64bb50ffe0449c5fa342da2](https://i.gyazo.com/93e8c6aee64bb50ffe0449c5fa342da2.gif)](https://gyazo.com/93e8c6aee64bb50ffe0449c5fa342da2)

![screenShot](https://dl.dropboxusercontent.com/u/33359624/iOS%20Simulator%20Screen%20shot%20Aug%2014%2C%202014%2C%203.31.35%20PM.png)<iframe width="315" height="539" src="https://dl.dropboxusercontent.com/u/33359624/Screen%20Recorded2014-08-14%2015_52_46.mov" frameborder="0"> </iframe>


#INSTALL
## Manual
you can drag and drop the MOStoreButton class into your project
## CocoaPods
Add
`pod 'MOStoreButton'`
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

	

	
