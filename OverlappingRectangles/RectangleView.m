//
//  RectangleView.m
//  OverlappingRectangles
//
//  Created by Nick Warren on 6/9/18.
//  Copyright © 2018 Nick Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RectangleView.h"

@implementation RectangleView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(detectPan:)];
        self.gestureRecognizers = @[panRecognizer];
        
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        UIColor *color = [UIColor colorWithHue:hue saturation:0.7 brightness:0.7 alpha:1];
        self.backgroundColor = color;
    }
    return self;
}

- (void) detectPan:(UIPanGestureRecognizer *) uiPanGestureRecognizer
{
    CGPoint translation = [uiPanGestureRecognizer translationInView:self.superview];
    self.center = CGPointMake(lastLocation.x + translation.x,
                              lastLocation.y + translation.y);

    [self.delegate rectangleViewDidMove:self];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superview bringSubviewToFront:self];
    
    lastLocation = self.center;
    
    [self.delegate rectangleViewDidMove:self];
}

@end
