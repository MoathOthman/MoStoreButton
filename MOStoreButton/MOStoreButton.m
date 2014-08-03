

#import "MOStoreButton.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define Button_MIN_HEIGHT 25.0f
 #define PADDING 12.0f
#define kDefaultButtonAnimationTime 0.25f
#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees)/ 180)


@interface MOStoreButton()
{
    BOOL _isDownloading;
    BOOL shouldItBeCleared;
    BOOL _isLoading;
}
@property (strong, nonatomic) CAShapeLayer *shapeLayer;
@property (assign, nonatomic) CGFloat currentProgress;
@property (assign, nonatomic) CGFloat lastProgress;
@property (assign, nonatomic) BOOL animated;
@property (assign, nonatomic) CFTimeInterval duration;
@property(nonatomic,assign)id  delegate;
@property (nonatomic, assign) CGPoint customPadding;
 @property(strong, nonatomic) UIColor *buttonColor;

// Set delegate to allow callbacks (animataionDidFinish, etc)
@property(strong, nonatomic) id progressdelegate;

 @property (assign, nonatomic) CGFloat progressArcWidth;


@end

@implementation MOStoreButton

- (id)initWithFrame:(CGRect)frame andColor:(UIColor *)buttonColor
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _buttonColor=buttonColor;
        [self setup];
    }
    return self;
}

-(void)removeBorder{
    self.layer.borderColor =[UIColor clearColor].CGColor;
    //
    self.layer.borderWidth=1.0;
}
-(void)addborders{
    self.layer.borderColor =_buttonColor.CGColor;
    //
    self.layer.borderWidth=1.0;
    //
    self.layer.cornerRadius =5;
    
}
-(void)setup{
   
    [self addborders];
    [self setTitleColor:_buttonColor forState:UIControlStateNormal];
    
     [self addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];


    [self setupAnimationVariables];
    shouldItBeCleared =NO;
    _currentIndex =0;
    
    [self setNeedsDisplay];
}
-(void)setupAnimationVariables{
    self.progressdelegate = nil;
    self.currentProgress = 0.0f;
    self.lastProgress = 0.0f;
    self.animated = YES;
     self.duration = 0.5;
    self.progressArcWidth = 2.0f;
}
-(NSUInteger)chooseNextIndex{
    
    NSUInteger heighestIndex= _titles.count-1;
    if (_currentIndex ==heighestIndex) {
        _currentIndex =0;
    }else{
        _currentIndex+=1;
    }
    return _currentIndex ;
}
-(void)startDownloading{
    if (!_isLoading) {
        return;
    }

        [self.layer removeAllAnimations];
        _isLoading=NO;
         [self setProgress:.0 animated:NO];
        shouldItBeCleared=NO;
        [self setNeedsDisplay];
        
        [self.layer addSublayer:_shapeLayer];
        [self removeBorder];
        [self updateButtonAnimated:YES toString:@"   "completed:^{
            
        } isloading:YES];
        _isDownloading =YES;
 
         
        [self refreshShapeLayerCircled:YES];
 }
-(void)startLoading{
    [self updateButtonAnimated:YES toString:@"   " completed:^{
           [self setNeedsDisplay];
//        CALayer*layer=  [self addCircleShape];
        [self.layer removeAllAnimations];
        [self removeBorder];
        [self setProgress:.0 animated:NO];
        
        shouldItBeCleared=NO;
        _isLoading =YES;
        _isDownloading =YES;
        
        CAAnimation *spinningAnimation = [self animationForSpinning];
        [self.layer addAnimation:spinningAnimation forKey:@"animationOpacity"];
        
    } isloading:YES];


    
  }
-(CALayer*)addCircleShape{
 
    
        UIBezierPath *outerCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x -self.frame.origin.x, self.center.y -self.frame.origin.y) radius:(self.frame.size.height-2)/2 startAngle:0 endAngle:DEGREES_TO_RADIANS(340) clockwise:YES];
        
        
        CAShapeLayer *centerline = [CAShapeLayer layer];
        centerline.path = outerCircle.CGPath;
        centerline.strokeColor = [UIColor redColor].CGColor;
        centerline.fillColor = [UIColor clearColor].CGColor;
        centerline.lineWidth = 2.0;
        
        [self.layer addSublayer:centerline];
        
        
 
    
    return nil;
}
- (CAAnimation *)animationForSpinning
{
    // Create a transform to rotate in the z-axis
    float radians = DEGREES_TO_RADIANS(90);
    CATransform3D transform;
    transform = CATransform3DMakeRotation(radians, 0, 0, 1.0);
    
    // Create a basic animation to animate the layer's transform
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:transform];
    animation.duration = .5;
    animation.cumulative = YES;
    animation.repeatCount = INFINITY;
    return animation;
}

#pragma mark when button pressed
- (void)buttonPressed:(id)sender {
    
    _isLoading =NO;
    [self.layer removeAllAnimations];
     [_shapeLayer removeAllAnimations];
    [_buttonDelegate storeButtonFired:self];

    if (!_isInTestingMode && _currentIndex == -1) {
        return;
    }
    
    if (_currentIndex==(_titles.count-1) && !_isDownloading) {
 
        [self startLoading];
     }else{
         
         [self setButtonWithoutAnimationOrDrawing:_titles[[self chooseNextIndex]]];
    }


 }
-(void)setButtonWithoutAnimationOrDrawing:(NSString*)title{
    
    [self stopDownloader];
    
    _isDownloading=NO;
    [self setProgress:.0f animated:NO];
    [self refreshShapeLayerCircled:YES];
    [self addborders];
    shouldItBeCleared =YES;
    [_shapeLayer removeFromSuperlayer];
    [self setNeedsDisplay];
    
    [self updateButtonAnimated:YES toString:title completed:nil isloading:NO];
    
}
-(void)stopDownloader{
    
    [self setupAnimationVariables];

    
}

-(void)awakeFromNib{
    [self setup];
}



#pragma mark drawRect
- (void)drawRect:(CGRect)rect
{
    if (_isLoading) {
        UIBezierPath *outerCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x -self.frame.origin.x, self.center.y -self.frame.origin.y) radius:(self.frame.size.height-2)/2 startAngle:0 endAngle:DEGREES_TO_RADIANS(340) clockwise:YES];
        [self.buttonColor setStroke];
        outerCircle.lineWidth = 1;
        [outerCircle stroke];
        
        return;
    }
    if (_currentIndex !=1 || shouldItBeCleared) {
       
        
        return;
    }
    // Outer circle
    CGRect newRect = ({
        CGRect insetRect = CGRectInset(rect, 1.5f, 1.5f);
        CGRect newRect = insetRect;
        newRect.size.width = MIN(CGRectGetMaxX(insetRect), CGRectGetMaxY(insetRect));
        newRect.size.height = newRect.size.width;
        newRect.origin.x = insetRect.origin.x + (CGRectGetWidth(insetRect) - CGRectGetWidth(newRect)) / 2;
        newRect.origin.y = insetRect.origin.y + (CGRectGetHeight(insetRect) - CGRectGetHeight(newRect)) / 2;
        newRect;
    });
    UIBezierPath *outerCircle = [UIBezierPath bezierPathWithOvalInRect:newRect];
    
    [self.buttonColor setStroke];
    outerCircle.lineWidth = 1;
    [outerCircle stroke];
}



-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if (flag) {
        NSLog(@"finished");
        _currentIndex =-1;
         [self setButtonWithoutAnimationOrDrawing:_finishedDownloadingButtonTitle];
    }
    
}
 - (void)updateButtonAnimated:(BOOL)animated toString:(NSString*)tostring completed:(void (^)(void))completed isloading:(BOOL)isLoading{
         // hide text, then start animation
        [UIView animateWithDuration:kDefaultButtonAnimationTime animations:^{
            
            [self setTitle:@"" forState:UIControlStateNormal];

            
            // calculate optimal new size
            CGSize sizeThatFits = [self sizeThatFits:CGSizeZero ofString:tostring];
            
             // set outer frame changes
            self.titleEdgeInsets = UIEdgeInsetsMake(2.0, self.titleEdgeInsets.left, 0.0, 0.0);
            CGRect cr = self.frame;
            
            cr.size.width = sizeThatFits.width;
            cr.size.height=sizeThatFits.height;
            if (cr.size.width>self.frame.size.width) {
                cr.origin.x -= (cr.size.width -self.frame.size.width);
            }else{
                cr.origin.x += (-cr.size.width +self.frame.size.width);;
                
            }
            
            
            if (isLoading) {
                if (cr.size.width > cr.size.height) {
                    cr.origin.x +=(cr.size.width - cr.size.height);
 
                }
                cr.size.width =cr.size.height;
            }
            self.frame = cr;
             if (isLoading) {
                 self.layer.cornerRadius =self.frame.size.width/2;

            }
        } completion:^(BOOL finished) {
            [self setTitle:tostring forState:UIControlStateNormal];
            if (completed) {
                completed();

            }
        }];
        
}

-(void)setTitles:(NSArray *)titles{
     
     [self updateButtonAnimated:NO toString:titles[0] completed:nil isloading:NO];
    _titles=titles;
}
- (CGSize)sizeThatFits:(CGSize)size ofString:(NSString*)string {
     CGSize newSize = [string sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    CGFloat newWidth = newSize.width + (PADDING * 2);
    
    CGFloat newHeight = Button_MIN_HEIGHT > newSize.height ? Button_MIN_HEIGHT : newSize.height ;
//    NSLog(@"new height is %f",newSize.height);
    CGSize sizeThatFits = CGSizeMake(newWidth, newHeight);
    return sizeThatFits;
}


- (CGPathRef)progressPath:(BOOL)isCircled
{
    // Offset
    CGFloat offset = - M_PI_2;
    
    // EndAngle
    CGFloat endAngle =  self.currentProgress * 2 * M_PI + offset;
    
    // Center
    CGRect rect = self.bounds;
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    
    // Radius
    CGFloat radius = MIN(center.x, center.y) - self.progressArcWidth / 2 -1 ;
    
    // Inner arc
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:center
                                                           radius:radius
                                                       startAngle:offset
                                                         endAngle:endAngle
                                                        clockwise:1];
    if (!isCircled) {
        arcPath =[UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 1) ];
     }
    return arcPath.CGPath;
}


#pragma mark - Getters methods

- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.strokeColor = self.buttonColor.CGColor;
        _shapeLayer.lineWidth = self.progressArcWidth;
        _shapeLayer.fillColor = nil;
        _shapeLayer.lineJoin = kCALineJoinBevel;
        _shapeLayer.speed=1.0f;
        [self.layer addSublayer:_shapeLayer];
    }
    
    return _shapeLayer;
}

#pragma mark - Private methods

- (void)refreshShapeLayerCircled:(BOOL)isCircled
{
    // Update path
    self.shapeLayer.path = [self progressPath:isCircled ];
    
    // Animation
    if (self.currentProgress != self.lastProgress && self.animated &&isCircled) {
        // From value
        CGFloat fromValue = (1 * self.lastProgress) / self.currentProgress;
      
        // Animation
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.delegate = self;
        pathAnimation.duration = self.duration;
        pathAnimation.fromValue = @(fromValue);
        pathAnimation.toValue = @(1.0f);
        [self.shapeLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    }
    
    // Update lastProgress
    self.lastProgress = self.currentProgress;
}

#pragma mark - Public methods

- (void)setProgress:(CGFloat)progress animated:(BOOL)animate
{
    if (self.currentProgress == 0.0f) {
        [self startDownloading];

    }
    if (progress==0.0) {
        
         self.shapeLayer.speed=1;
        
    }
    self.currentProgress = MAX(MIN(progress, 1.0f), 0.0f);
    self.animated = animate;
    [self setNeedsLayout];
    
    [self refreshShapeLayerCircled:YES];

}



-(void)dealloc{
    
    [self stopDownloader];
    _shapeLayer =nil;
    
    
    
}


@end
