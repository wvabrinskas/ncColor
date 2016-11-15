
@interface _UIBackdropViewSettings
- (void)setColorTint:(id)arg1;
- (void)setUsesColorTintView:(BOOL)arg1;
- (void)setStyle:(int)arg1;
- (id)initWithDefaultValues;
- (void)setBlurRadius:(CGFloat)arg1;
- (void)setBlurHardEdges:(int)arg1;
- (void)setBlurQuality:(id)arg1;
-(void)setTintColor:(id)arg1;

@end
@interface _UIBackdropView : UIView
- (_UIBackdropViewSettings *)outputSettings;
-(id)initWithFrame:(CGRect)frame autosizesToFitSuperview:(BOOL)size settings:(id)settings;
-(void)setBlurRadius:(CGFloat)arg1;
-(void)setRequiresColorStatistics:(BOOL)arg1;
-(void)setUsesColorTintView:(BOOL)arg1;
-(void)setColorTintAlpha:(float)arg1;
-(void)setColorTintMaskAlpha:(float)arg1;
-(void)setColorTint:(id)arg1;
-(void)applySettings:(id)arg1;
- (void)prepareForTransitionToSettings:(id)arg1;
-(void)computeAndApplySettingsForTransition;
- (void)addColorTintViewIfNeededForSettings:(id)arg1;
@end


@interface SBNotificationCenterViewController
@property (nonatomic,readonly) _UIBackdropView * backdropView; 
@end

%hook SBNotificationCenterViewController 

-(void)viewWillAppear:(BOOL)arg1 {
	%orig;
	_UIBackdropViewSettings *settings = [[%c(_UIBackdropViewSettingsColored) alloc] initWithDefaultValues];
	[settings setColorTint:[UIColor blueColor]];
	[self.backdropView.outputSettings setUsesColorTintView:YES];
	[self.backdropView addColorTintViewIfNeededForSettings:settings];
	[self.backdropView prepareForTransitionToSettings:settings];
        [self.backdropView computeAndApplySettingsForTransition];
	[self.backdropView applySettings:settings];
}

%end
