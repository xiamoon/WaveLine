//
//  WaveView.h
//  WaveLine
//
//  Created by kaleo on 2018/4/16.
//  Copyright © 2018年 liqian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaveView : UIView

@property (nonatomic, assign) CGFloat paddingLeft; // paddingLeft and paddingRight.
@property (nonatomic, assign) CGFloat numberOfWaves; // Wave numbers in this view.
@property (nonatomic, assign) CGFloat waveSpeed; // Assign 1~12. default is 8.
@property (nonatomic, assign) CGFloat foreAmplitude; // 波形高度
@property (nonatomic, assign) CGFloat backAmplitude; // 波形高度
@property (nonatomic, strong) UIColor *foreLineColor;
@property (nonatomic, strong) UIColor *backLineColor;
@property (nonatomic, assign) CGFloat foreLineWidth;
@property (nonatomic, assign) CGFloat backLineWidth;

- (void)startWaving;
- (void)pauseWaving;
- (void)deallocWave;

- (void)updateWaveWithForeAmplitude:(CGFloat)foreAmplitude;

@end
