MoStoreButton
=============

simple-to-use iOS 7 Appstore like button




#Requirements

- Xcode 5 
- iOS 7.0 + 
- ARC

#Demo
[![https://gyazo.com/93e8c6aee64bb50ffe0449c5fa342da2](https://i.gyazo.com/93e8c6aee64bb50ffe0449c5fa342da2.gif)](https://gyazo.com/93e8c6aee64bb50ffe0449c5fa342da2)
[![https://gyazo.com/e79876ce7fd6f66faea87336e22e8b45](https://i.gyazo.com/e79876ce7fd6f66faea87336e22e8b45.gif)](https://gyazo.com/e79876ce7fd6f66faea87336e22e8b45)



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

#Author 
 * Twitter : [dark_torch](https://twitter.com/dark_torch)
 * Website: https://moathothman.com
 * Check my app PuzzPic http://apple.co/2a6Ow8W
	
