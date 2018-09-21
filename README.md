
# 快速创建一个声音、录音波形图。

![](/IMB_VmAmLU.gif)

# 特性：
- 支持定制
```objectivec
@property (nonatomic, assign) CGFloat paddingLeft; // paddingLeft and paddingRight.
@property (nonatomic, assign) CGFloat numberOfWaves; // Wave numbers in this view.
@property (nonatomic, assign) CGFloat waveSpeed; // Assign 1~12. default is 8.
@property (nonatomic, assign) CGFloat foreAmplitude; // 波形高度
@property (nonatomic, assign) CGFloat backAmplitude; // 波形高度
@property (nonatomic, strong) UIColor *foreLineColor;
@property (nonatomic, strong) UIColor *backLineColor;
@property (nonatomic, assign) CGFloat foreLineWidth;
@property (nonatomic, assign) CGFloat backLineWidth;
```
- 快速启动、停止和销毁
```objective
- (void)startWaving;
- (void)pauseWaving;
- (void)deallocWave;
```

- 实时更新波形高度
```objectivec
- (void)updateWaveWithForeAmplitude:(CGFloat)foreAmplitude;
```
