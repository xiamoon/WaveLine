//
//  WaveView.m
//  WaveLine
//
//  Created by kaleo on 2018/4/16.
//  Copyright © 2018年 liqian. All rights reserved.
//

#import "WaveView.h"

@interface WaveView () {
    CGFloat wave_Speed;
    UIBezierPath *_path;
}
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CAShapeLayer *waveLayer;
@property (nonatomic, strong) CAShapeLayer *waveLayerBack1;
@property (nonatomic, strong) CAShapeLayer *waveLayerBack2;
@end

@implementation WaveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupConstant];
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupConstant];
    [self setupUI];
}

- (void)setupConstant {
    _paddingLeft = 20.0;
    _numberOfWaves = 2.0;
    _waveSpeed = 8.0;
    _foreAmplitude = 18.0;
    _backAmplitude = 5.0;
    _foreLineColor = [UIColor greenColor];
    _backLineColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    _foreLineWidth = 2.0;
    _backLineWidth = 1.0;
}

- (void)setupUI {
    _waveLayerBack1 = [CAShapeLayer new];
    _waveLayerBack1.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _waveLayerBack1.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    _waveLayerBack1.fillColor = [UIColor clearColor].CGColor;
    _waveLayerBack1.lineWidth = _backLineWidth;
    _waveLayerBack1.strokeColor = _backLineColor.CGColor;
    [self.layer addSublayer:_waveLayerBack1];
    
    _waveLayerBack2 = [CAShapeLayer new];
    _waveLayerBack2.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _waveLayerBack2.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    _waveLayerBack2.fillColor = [UIColor clearColor].CGColor;
    _waveLayerBack2.lineWidth = _backLineWidth;
    _waveLayerBack2.strokeColor = _backLineColor.CGColor;
    [self.layer addSublayer:_waveLayerBack2];
    
    _waveLayer = [CAShapeLayer new];
    _waveLayer.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _waveLayer.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    _waveLayer.fillColor = [UIColor clearColor].CGColor; // 这个很重要
    _waveLayer.lineWidth = _foreLineWidth;
    _waveLayer.strokeColor = _foreLineColor.CGColor;
    [self.layer addSublayer:_waveLayer];
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave)];
    if (@available(iOS 10.0, *)) {
        _displayLink.preferredFramesPerSecond = 40.0;
    } else {
        _displayLink.frameInterval = 4;
    }
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [_displayLink setPaused:YES];
}

- (void)startWaving {
    [_displayLink setPaused:NO];
}

- (void)pauseWaving {
    [_displayLink setPaused:YES];
}

- (void)deallocWave {
    _waveLayer = nil;
    _waveLayerBack1 = nil;
    _waveLayerBack2 = nil;
    [_displayLink invalidate];
}

- (void)updateWaveWithForeAmplitude:(CGFloat)foreAmplitude {
    _foreAmplitude = foreAmplitude;
}

#pragma mark - Private.
- (void)updateWave {
    CGFloat period = (self.bounds.size.width - 2*_paddingLeft) / _numberOfWaves;
    CGFloat ω = (2*M_PI)/period;
    wave_Speed += (_waveSpeed*ω);
    
    [self updateWaveLayerBack1];
    [self updateWaveLayerBack2];
    [self updateWaveLayer];
}


// y = Asin(ωx+φ) + h
- (void)updateWaveLayer {
    CGFloat period = (self.bounds.size.width - 2*_paddingLeft) / _numberOfWaves;
    CGFloat centerY = self.bounds.size.height/2.0;
    
    CGFloat A = _foreAmplitude;
    CGFloat ω = (2*M_PI)/period;
    
    UIGraphicsBeginImageContext(self.bounds.size);
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat centerX = self.bounds.size.width*0.5;
    for (CGFloat x = _paddingLeft; x < self.bounds.size.width - _paddingLeft; x+=4) {
        CGFloat Aratio = 1- fabs(centerX - x) / centerX;
        CGFloat y = (A*Aratio)*sin(ω*x - ω*_paddingLeft - wave_Speed) + centerY;
        if (x == _paddingLeft) {
            [path moveToPoint:CGPointMake(x, y)];
        }else {
            [path addLineToPoint:CGPointMake(x, y)];
        }
    }
    UIGraphicsEndImageContext();
    _waveLayer.path = path.CGPath;
}

- (void)updateWaveLayerBack1 {
    CGFloat period = (self.bounds.size.width - 2*_paddingLeft) / _numberOfWaves;
    CGFloat centerY = self.bounds.size.height/2.0;
    
    CGFloat A = _backAmplitude;
    CGFloat ω = (2*M_PI)/period;
    
    UIGraphicsBeginImageContext(self.bounds.size);
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat centerX = self.bounds.size.width*0.5;
    for (CGFloat x = _paddingLeft; x < self.bounds.size.width - _paddingLeft; x+=4) {
        CGFloat Aratio = 1- fabs(centerX - x) / centerX;
        CGFloat y = (A*Aratio)*cos(ω*x - ω*_paddingLeft - wave_Speed) + centerY;
        if (x == _paddingLeft) {
            [path moveToPoint:CGPointMake(x, y)];
        }else {
            [path addLineToPoint:CGPointMake(x, y)];
        }
    }
    UIGraphicsEndImageContext();
    _waveLayerBack1.path = path.CGPath;
}

- (void)updateWaveLayerBack2 {
    CGFloat period = (self.bounds.size.width - 2*_paddingLeft) / _numberOfWaves;
    CGFloat centerY = self.bounds.size.height/2.0;
    
    CGFloat A = _backAmplitude;
    CGFloat ω = (2*M_PI)/period;
    
    UIGraphicsBeginImageContext(self.bounds.size);
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat centerX = self.bounds.size.width*0.5;
    for (CGFloat x = _paddingLeft; x < self.bounds.size.width - _paddingLeft; x+=4) {
        CGFloat Aratio = 1- fabs(centerX - x) / centerX;
        CGFloat y = (A*Aratio)*cos(ω*x - ω*_paddingLeft + ω*period*0.5 - wave_Speed) + centerY;
        if (x == _paddingLeft) {
            [path moveToPoint:CGPointMake(x, y)];
        }else {
            [path addLineToPoint:CGPointMake(x, y)];
        }
    }
    UIGraphicsEndImageContext();
    _waveLayerBack2.path = path.CGPath;
}

#pragma mark - Setters.
- (void)setForeLineColor:(UIColor *)foreLineColor {
    _foreLineColor = foreLineColor;
    _waveLayer.strokeColor = foreLineColor.CGColor;
}

- (void)setBackLineColor:(UIColor *)backLineColor {
    _backLineColor = backLineColor;
    _waveLayerBack1.strokeColor = backLineColor.CGColor;
    _waveLayerBack2.strokeColor = backLineColor.CGColor;
}

- (void)setForeLineWidth:(CGFloat)foreLineWidth {
    _foreLineWidth = foreLineWidth;
    _waveLayer.lineWidth = foreLineWidth;
}

- (void)setBackLineWidth:(CGFloat)backLineWidth {
    _backLineWidth = backLineWidth;
    _waveLayerBack1.lineWidth = backLineWidth;
    _waveLayerBack2.lineWidth = backLineWidth;
}

@end
