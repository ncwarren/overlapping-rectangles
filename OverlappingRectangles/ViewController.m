//
//  ViewController.m
//  OverlappingRectangles
//
//  Created by Nick Warren on 6/9/18.
//  Copyright © 2018 Nick Warren. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <RectangleViewDelegate>
@property (weak, nonatomic) IBOutlet UISlider *rect1WidthValue;
@property (weak, nonatomic) IBOutlet UISlider *rect1HeightValue;

@property (weak, nonatomic) IBOutlet UISlider *rect2WidthValue;
@property (weak, nonatomic) IBOutlet UISlider *rect2HeightValue;

@property (weak, nonatomic) IBOutlet UILabel *overlapLabel;

@end

@implementation ViewController
RectangleView *rect1;
RectangleView *rect2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    rect1 = [[RectangleView alloc] initWithFrame: CGRectMake(100, 250, 100, 100)];
    rect2 = [[RectangleView alloc] initWithFrame: CGRectMake(250, 250, 100, 100)];
    
    rect1.delegate = self;
    rect2.delegate = self;
    
    [self.view addSubview:rect1];
    [self.view addSubview:rect2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rect1WidthUpdate:(id)sender {
    CGRect frameRect = rect1.frame;
    frameRect.size.width = self.rect1WidthValue.value;
    rect1.frame = frameRect;
    [self detectOverlap];
}

- (IBAction)rect1HeightUpdate:(id)sender {
    CGRect frameRect = rect1.frame;
    frameRect.size.height = self.rect1HeightValue.value;
    rect1.frame = frameRect;
    [self detectOverlap];
}

- (IBAction)rect2WidthUpdate:(id)sender {
    CGRect frameRect = rect2.frame;
    frameRect.size.width = self.rect2WidthValue.value;
    rect2.frame = frameRect;
    [self detectOverlap];
}

- (IBAction)rect2HeightUpdate:(id)sender {
    CGRect frameRect = rect2.frame;
    frameRect.size.height = self.rect2HeightValue.value;
    rect2.frame = frameRect;
    [self detectOverlap];
}

- (void)detectOverlap {
    float rect1XMin = rect1.frame.origin.x;
    float rect1XMax = rect1.frame.origin.x + rect1.frame.size.width;
    float rect1YMin = rect1.frame.origin.y;
    float rect1YMax = rect1.frame.origin.y + rect1.frame.size.height;
    
    float rect2XMin = rect2.frame.origin.x;
    float rect2XMax = rect2.frame.origin.x + rect2.frame.size.width;
    float rect2YMin = rect2.frame.origin.y;
    float rect2YMax = rect2.frame.origin.y + rect2.frame.size.height;
    
    BOOL xOverlap = [self float:rect1XMin between:rect2XMin and:rect2XMax] || [self float:rect2XMin between:rect1XMin and:rect1XMax];
    BOOL yOverlap = [self float:rect1YMin between:rect2YMin and:rect2YMax] || [self float:rect2YMin between:rect1YMin and:rect1YMax];
    
    if (xOverlap && yOverlap){
        self.overlapLabel.text = @"Overlap!";
    }
    else {
        self.overlapLabel.text = @"No overlap!";
    }
}

- (BOOL)float:(float)aFloat between:(float)minValue and:(float)maxValue {
    if (aFloat >= minValue && aFloat <= maxValue) {
        return YES;
    } else {
        return NO;
    }
}
- (void)rectangleViewDidMove:(RectangleView *)rectangleView {
    [self detectOverlap];
}

@end
