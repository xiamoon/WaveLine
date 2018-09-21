//
//  ViewController.m
//  WaveLine
//
//  Created by kaleo on 2018/4/16.
//  Copyright © 2018年 liqian. All rights reserved.
//

#import "ViewController.h"
#import "WaveView.h"

@interface ViewController ()
@property (nonatomic, strong) WaveView *waveView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _waveView = [[WaveView alloc] initWithFrame:CGRectMake(50, 100, 375-100, 100)];
    [self.view addSubview:_waveView];
    [_waveView startWaving];
}

- (IBAction)sliderAction:(UISlider *)sender {
    [_waveView updateWaveWithForeAmplitude:50*sender.value];
    CGFloat speed = 8.0;
    if (sender.value > 0.8) {
        speed = sender.value * 10;
    }
    _waveView.waveSpeed = speed;
}

@end
