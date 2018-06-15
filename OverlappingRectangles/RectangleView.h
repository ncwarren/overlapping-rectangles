//
//  RectangleView.h
//  OverlappingRectangles
//
//  Created by Nick Warren on 6/9/18.
//  Copyright © 2018 Nick Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RectangleView;
@protocol RectangleViewDelegate <NSObject>
- (void)rectangleViewDidMove:(RectangleView*)rectangleView;
@end

@interface RectangleView: UIView
{
    CGPoint lastLocation;
}
@property (nonatomic, weak) id <RectangleViewDelegate> delegate;
@end


