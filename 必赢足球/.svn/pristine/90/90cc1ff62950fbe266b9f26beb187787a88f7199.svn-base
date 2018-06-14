//
//  CHShowPhotoView.m
//  ChildHoodStemp
//
//  Created by zandavid on 15/7/31.
//  Copyright (c) 2015年 caobohua. All rights reserved.
//

#import "CHShowPhotoView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "CHProgressImgeView.h"
#import "Utils.h"
#import "BUIView.h"

#define kTouchLabelBaseTag              100
#define kUIActionSheetBaseTag           200

static const float AGPhotoBrowserAnimationDuration = 0.25;

@interface CHShowPhotoView () <
    UITableViewDataSource,
    UITableViewDelegate,
    UIGestureRecognizerDelegate,
    UIAlertViewDelegate,
    UIActionSheetDelegate>
{
	CGPoint _startingPanPoint;
	BOOL _wantedFullscreenLayout;
    BOOL _navigationBarWasHidden;
	CGRect _originalParentViewFrame;
	NSInteger _currentlySelectedIndex;
    
    UIView *_mainView;
    UIView *_showView;
    BOOL _showMore;
    CGSize likeSize;
    BOOL isComment;
    CGPoint _currentCenter;
    UIView *_contentView;
    BOOL _showComment;
    BOOL _isShow;
    NSString *_tmpCommentStr;
    float _viewWidth;
    UIPageControl *_pageControl;
    
    BOOL _isEdit;               //是不是显示导航条
    UIView *_customNavigationView;
    UILabel *_numLb;
    
    UIButton *btnRight;
    
    UIButton *checkBtn;
    
    UIButton *finishedBtn;
    
    BOOL isChecked;
    
    BOOL isShowEditMenu;
    
}


@property (nonatomic, strong) UITableView *photoTableView;

@property (nonatomic, assign, getter = isDisplayingDetailedView) BOOL displayingDetailedView;

@end


static NSString *CellIdentifier = @"AGPhotoBrowserCell";

@implementation CHShowPhotoView

const int CHPhotoBrowserThresholdToCenter = 150;

- (id)initWithFrame:(CGRect)frame andEdit:(BOOL)isEdit
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _isEdit = isEdit;
        _viewWidth = 203;
        // Initialization code
        _showMore = NO;
        _showComment = NO;
        
        isChecked = NO;
        
		[self setupView];
    }
    return self;
}

- (void)createCustomNavBar{
    _customNavigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    _customNavigationView.backgroundColor = kMajorColor;
    [self addSubview:_customNavigationView];
    
    _numLb = [[UILabel alloc] initClearColorWithFrame:CGRectMake(0, 0, _customNavigationView.width_, 44)];
    _numLb.font = kFontSuper_b;
    _numLb.textColor = kColorWhite;
    _numLb.textAlignment = NSTextAlignmentCenter;
    [_customNavigationView addSubview:_numLb];
    
    CGFloat segmentWidth = 105;
    
    // 左按钮
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeft setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    btnLeft.frame = CGRectMake(0, _numLb.minY, segmentWidth, _numLb.height_);
    btnLeft.adjustsImageWhenHighlighted = NO;
    btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnLeft.titleLabel.font = kFontMiddle;
    btnLeft.titleEdgeInsets = UIEdgeInsetsMake(0, kEdgeInsetsLeft + 5, 0, 0);
    btnLeft.imageEdgeInsets = UIEdgeInsetsMake(0, kEdgeInsetsLeft, 0, 0);
    btnLeft.exclusiveTouch = YES;
    //[btnLeft setTitle:@"返回" forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(onBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [btnLeft setTitleColor:kColorWhite forState:UIControlStateNormal];
    [btnLeft setTitleColor:kColorLightGray forState:UIControlStateDisabled];
    [_customNavigationView addSubview:btnLeft];
    
    // 右按钮
    btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRight.frame = CGRectMake(_customNavigationView.width_ - segmentWidth, _numLb.minY, segmentWidth, _numLb.height_);
    btnRight.adjustsImageWhenHighlighted = NO;
    btnRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    btnRight.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kEdgeInsetsLeft);
    btnRight.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kEdgeInsetsLeft);
    btnRight.exclusiveTouch = YES;
    //[btnRight setTitle:@"删除" forState:UIControlStateNormal];
    [btnRight setImage:[UIImage imageNamed:@"删除按钮"] forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(onDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
    [_customNavigationView addSubview:btnRight];
    
    // 完成按钮
    finishedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    finishedBtn.frame = CGRectMake(_customNavigationView.width_ - 60 - 15, (_numLb.maxY - 24)/2, 60, 24);
    finishedBtn.adjustsImageWhenHighlighted = NO;
    finishedBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [finishedBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    finishedBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    finishedBtn.layer.borderWidth = 1;
    finishedBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //finishedBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kEdgeInsetsLeft);
    finishedBtn.exclusiveTouch = YES;
    //[finishedBtn setImage:[UIImage imageNamed:@"04完成"] forState:UIControlStateNormal];
    [finishedBtn addTarget:self action:@selector(onFinishedBtn) forControlEvents:UIControlEventTouchUpInside];
    [_customNavigationView addSubview:finishedBtn];
    
    
    
    
    checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    checkBtn.frame = CGRectMake(self.frame.size.width - 9 - 25, self.frame.size.height - 29 - 25, 25, 25);
    
     [checkBtn setImage:[UIImage imageNamed:@"03复选框未选透明"] forState:UIControlStateNormal];
    
    [checkBtn addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:checkBtn];
    
    [self bringSubviewToFront:checkBtn];
    
    finishedBtn.hidden = YES;
    checkBtn.hidden = YES;
}

-(void)checkAction
{
    if (!isChecked) {
        
        [checkBtn setImage:[UIImage imageNamed:@"03复选框选中"] forState:UIControlStateNormal];
        
    }else
    {
        [checkBtn setImage:[UIImage imageNamed:@"03复选框未选透明"] forState:UIControlStateNormal];
    }
    
    
    if ([_delegate respondsToSelector:@selector(photoBrowser:OnChecked:checked:atIndex:)]) {
        [_delegate photoBrowser:self OnChecked:nil checked:!isChecked atIndex:_currentlySelectedIndex];
    }
    
    isChecked = !isChecked;
}

-(void)showEditMenu
{
    finishedBtn.hidden = NO;
    checkBtn.hidden = NO;
    
    isShowEditMenu = YES;
}


-(void)hideDeleteBtn
{
    btnRight.hidden = YES;
}

- (void)onBackBtn{
    _customNavigationView.hidden = YES;
    if ([_delegate respondsToSelector:@selector(showPhotoView:didTapOnDoneButton:)]) {
        self.displayingDetailedView = NO;
        [_delegate showPhotoView:self didTapOnDoneButton:nil];
    }
}

- (void)onFinishedBtn{
    
    [self onBackBtn];
}

- (void)onDeleteBtn{
    if ([_delegate respondsToSelector:@selector(photoBrowser:didTapOnDeleteButton:atIndex:)]) {
        [_delegate photoBrowser:self didTapOnDeleteButton:nil atIndex:_currentlySelectedIndex];
    }
    
    if([_dataSource numberOfPhotosForShowPhotoView:self]>0)
    {
        if ([_dataSource numberOfPhotosForShowPhotoView:self]==1) {
            _numLb.text = [NSString stringWithFormat:@"%d/%d",_currentlySelectedIndex ,[_dataSource numberOfPhotosForShowPhotoView:self]];
        }else
        {
            _numLb.text = [NSString stringWithFormat:@"%d/%d",_currentlySelectedIndex + 1,[_dataSource numberOfPhotosForShowPhotoView:self]];
        }
        
        [self.photoTableView reloadData];
    }else
    {
        [self onBackBtn];
    }
    
}


- (void)setupView
{
    
	self.userInteractionEnabled = NO;
	self.backgroundColor = [UIColor colorWithWhite:0. alpha:0.];
    _currentlySelectedIndex = 0;
    
    _mainView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_mainView];
    
    _showView = [[UIView alloc] initWithFrame:_mainView.bounds];
    [_mainView addSubview:_showView];
    
    [_showView addSubview:self.photoTableView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _mainView.height_ - 20, self.width_, 0)];
    [_mainView addSubview:_pageControl];
    
    if (_isEdit) {
        [self createCustomNavBar];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _pageControl.numberOfPages = [_dataSource numberOfPhotosForShowPhotoView:self];
	return [_dataSource numberOfPhotosForShowPhotoView:self];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	cell.backgroundColor = [UIColor clearColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHProgressImgeView *imageView = (CHProgressImgeView *)[cell.contentView viewWithTag:1];
    imageView.backgroundColor = [UIColor clearColor];
	if (!imageView) {
        
        // //////
        UIScrollView *backView = [[UIScrollView alloc] initWithFrame:self.bounds];
        backView.maximumZoomScale = 3.0f;
        backView.minimumZoomScale = 1.0f;
        if (self.subVc) {
            backView.delegate = self.subVc;
        }
        
//        backView.backgroundColor = [UIColor redColor];
        backView.bounces = NO;
        backView.showsHorizontalScrollIndicator = NO;
        backView.showsVerticalScrollIndicator = NO;
        // /////////
        
//        imageView = [[CHProgressImgeView alloc] initWithFrame:self.bounds];
        imageView = [[CHProgressImgeView alloc] initWithFrame:self.bounds];
		imageView.userInteractionEnabled = YES;
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressBtn:)];
        [longPressGesture setDelegate:self];
        longPressGesture.minimumPressDuration=1;//默认0.5秒
        [imageView addGestureRecognizer:longPressGesture];
		
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_doneButtonTapped:)];
        [imageView addGestureRecognizer:tapGesture];
        
        
//		UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_imageViewPanned:)];
//		panGesture.delegate = self;
//		panGesture.maximumNumberOfTouches = 1;
//		panGesture.minimumNumberOfTouches = 1;
//		[imageView addGestureRecognizer:panGesture];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		imageView.tag = 1;
        
//		CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
//		CGPoint origin = imageView.frame.origin;
//		imageView.transform = transform;
//        CGRect frame = imageView.frame;
//        frame.origin = origin;
//        imageView.frame = frame;
        
        CGAffineTransform transform2 = CGAffineTransformMakeRotation(M_PI_2);
        CGPoint origin2 = backView.frame.origin;
        backView.transform = transform2;
        CGRect frame2 = backView.frame;
        frame2.origin = origin2;
        backView.frame = frame2;
		
        [backView addSubview:imageView];
		[cell.contentView addSubview:backView];
//        [cell.contentView addSubview:imageView];
	}
    id object = [_dataSource showPhotoView:self imageAtIndex:indexPath.row];
    if ([object isKindOfClass:[NSString class]]) {
        NSString *uri = [NSString stringWithFormat:@"%@", [_dataSource showPhotoView:self imageAtIndex:indexPath.row]];
        NSString *uri1 = [NSString stringWithFormat:@"%@", [_dataSource showPhotoView:self imageAtIndex:indexPath.row]];
        NSString *uri2 = [NSString stringWithFormat:@"%@", [_dataSource showPhotoView:self imageAtIndex:indexPath.row]];
        

        UIImage *img1 = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:uri1];
        UIImage *img2 = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:uri2];
        
        if ([[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:uri]) {
            imageView.progressLb.hidden = YES;
        }else{
            imageView.progressLb.hidden = NO;
        }
        
        
        if (img2) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:uri] placeholderImage:img2 options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                [imageView setProgress:receivedSize* 1.0/expectedSize* 1.0];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                imageView.image = image;
                [imageView setProgress:1];
            }];
        }else if (img1){
            [imageView sd_setImageWithURL:[NSURL URLWithString:uri] placeholderImage:img1 options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                [imageView setProgress:receivedSize* 1.0/expectedSize * 1.0];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                imageView.image = image;
                [imageView setProgress:1];
            }];

            
        }else{
            [imageView sd_setImageWithURL:[NSURL URLWithString:uri] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                [imageView setProgress:receivedSize* 1.0/expectedSize* 1.0];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                imageView.image = image;
                [imageView setProgress:1];
            }];

        }
        
    }else {
        UIImage *img = nil;
        if ([object isKindOfClass:[NSMutableDictionary class]]) {
            NSMutableDictionary *dic = (NSMutableDictionary *)object;
            img = [UIImage imageWithData:dic[@"data"]];
        }
        imageView.image = img;
    }
    
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self _doneButtonTapped:nil];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGPoint targetContentOffset = scrollView.contentOffset;
    
	UITableView *tv = (UITableView*)scrollView;
	NSIndexPath *indexPathOfTopRowAfterScrolling = [tv indexPathForRowAtPoint:
													targetContentOffset
													];
	CGRect rectForTopRowAfterScrolling = [tv rectForRowAtIndexPath:
										  indexPathOfTopRowAfterScrolling
										  ];
	targetContentOffset.y = rectForTopRowAfterScrolling.origin.y;
	
	int index = floor(targetContentOffset.y / CGRectGetWidth(self.frame));
	
	_currentlySelectedIndex = index;
    
    if (self.elcAssets) {
         ELCAsset *elcAsset = [self.elcAssets objectAtIndex:index];
        if (elcAsset.selected) {
            [checkBtn setImage:[UIImage imageNamed:@"03复选框选中"] forState:UIControlStateNormal];
            
        }else
        {
            [checkBtn setImage:[UIImage imageNamed:@"03复选框未选透明"] forState:UIControlStateNormal];
        }
    }
    
    if (_isEdit) {
        if (_customNavigationView.minY >= 0) {
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _customNavigationView.minY = -44;
            } completion:nil];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        _pageControl.currentPage = _currentlySelectedIndex;
        if (_isEdit) {
            _numLb.text = [NSString stringWithFormat:@"%d/%d",_currentlySelectedIndex + 1,[_dataSource numberOfPhotosForShowPhotoView:self]];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControl.currentPage = _currentlySelectedIndex;
    if (_isEdit) {
        _numLb.text = [NSString stringWithFormat:@"%d/%d",_currentlySelectedIndex + 1,[_dataSource numberOfPhotosForShowPhotoView:self]];
    }
}


#pragma mark - Public methods

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
	
	[UIView animateWithDuration:AGPhotoBrowserAnimationDuration
					 animations:^(){
						 self.backgroundColor = [UIColor colorWithWhite:0. alpha:1.];
						 
						 [[UIApplication sharedApplication] setStatusBarHidden:YES];
					 }
					 completion:^(BOOL finished){
						 if (finished) {
							 self.userInteractionEnabled = YES;
							 self.displayingDetailedView = YES;
							 self.photoTableView.alpha = 1.;
							 [self.photoTableView reloadData];
						 }
					 }];
}

- (void)showFromIndex:(NSInteger)initialIndex
{
    checkBtn.hidden = YES;
    
	if (initialIndex < [_dataSource numberOfPhotosForShowPhotoView:self]) {
		[self.photoTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:initialIndex inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
	
	[self show];
    _pageControl.currentPage = _currentlySelectedIndex;
    if (_isEdit) {
        _numLb.text = [NSString stringWithFormat:@"%d/%d",_currentlySelectedIndex + 1,[_dataSource numberOfPhotosForShowPhotoView:self]];
    }

}


- (void)showFromIndex:(NSInteger)initialIndex checked:(BOOL)checked elcAssets:(NSMutableArray *)elcAssets
{
    checkBtn.hidden = YES;
    
    self.elcAssets = elcAssets;
    
    if (checked) {
        
        [checkBtn setImage:[UIImage imageNamed:@"03复选框选中"] forState:UIControlStateNormal];
        
    }else
    {
        [checkBtn setImage:[UIImage imageNamed:@"03复选框未选透明"] forState:UIControlStateNormal];
    }
    
    
    if (initialIndex < [_dataSource numberOfPhotosForShowPhotoView:self]) {
        [self.photoTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:initialIndex inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    
    [self show];
    _pageControl.currentPage = _currentlySelectedIndex;
    if (_isEdit) {
        _numLb.text = [NSString stringWithFormat:@"%d/%d",_currentlySelectedIndex + 1,[_dataSource numberOfPhotosForShowPhotoView:self]];
    }
    
}

- (void)hideWithCompletion:( void (^) (BOOL finished) )completionBlock
{
	[UIView animateWithDuration:AGPhotoBrowserAnimationDuration
					 animations:^(){
						 self.photoTableView.alpha = 0.;
						 self.backgroundColor = [UIColor colorWithWhite:0. alpha:0.];
						 
						 [[UIApplication sharedApplication] setStatusBarHidden:NO];
					 }
					 completion:^(BOOL finished){
						 self.userInteractionEnabled = NO;
                         [self removeFromSuperview];
						 if(completionBlock) {
							 completionBlock(finished);
						 }
					 }];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIView *imageView = [gestureRecognizer view];
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:[imageView superview]];
        
        // -- Check for horizontal gesture
        if (fabsf(translation.x) > fabsf(translation.y)) {
            return YES;
        }
        
        return NO;
    }else{
        return YES;
    }
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }

    return YES;
}

#pragma mark - longPressBtn
-(void)longPressBtn:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        UIActionSheet *addPictureAS = [[UIActionSheet alloc] initWithTitle:nil
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                    destructiveButtonTitle:nil
                                                         otherButtonTitles:@"保存到手机",nil];
        addPictureAS.tag = kUIActionSheetBaseTag;
        addPictureAS.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        [addPictureAS showInView:self withCompletionHandler:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                UITableViewCell *cell = [self tableView:_photoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentlySelectedIndex inSection:0]];
                UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:1];
                if (imgView.image) {
                    UIImageWriteToSavedPhotosAlbum(imgView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
                }
            }
        }];
        

    }
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}


#pragma mark - Recognizers
- (void)_imageViewPanned:(UIPanGestureRecognizer *)recognizer
{
    return;
	UIImageView *imageView = (UIImageView *)recognizer.view;
	
	if (recognizer.state == UIGestureRecognizerStateBegan) {
        // -- Show back status bar
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
		// -- Disable table view scrolling
		self.photoTableView.scrollEnabled = NO;
		// -- Hide detailed view
		self.displayingDetailedView = NO;
		_startingPanPoint = imageView.center;
		return;
	}
	
	if (recognizer.state == UIGestureRecognizerStateEnded) {
		// -- Enable table view scrolling
		self.photoTableView.scrollEnabled = YES;
		// -- Check if user dismissed the view
		CGPoint endingPanPoint = [recognizer translationInView:self];
		CGPoint translatedPoint = CGPointMake(_startingPanPoint.x - endingPanPoint.y, _startingPanPoint.y);
		int heightDifference = abs(floor(_startingPanPoint.x - translatedPoint.x));
		
		if (heightDifference <= CHPhotoBrowserThresholdToCenter) {
            
			// -- Back to original center
			[UIView animateWithDuration:AGPhotoBrowserAnimationDuration
							 animations:^(){
								 self.backgroundColor = [UIColor colorWithWhite:0. alpha:1.];
								 imageView.center = self->_startingPanPoint;
							 } completion:^(BOOL finished){
                                 // -- Hide status bar
                                 [[UIApplication sharedApplication] setStatusBarHidden:YES];
								 // -- show detailed view?
								 self.displayingDetailedView = YES;
							 }];
		} else {
			// -- Animate out!
			typeof(self) weakSelf __weak = self;
			[self hideWithCompletion:^(BOOL finished){
				typeof(weakSelf) strongSelf __strong = weakSelf;
				if (strongSelf) {
					imageView.center = strongSelf->_startingPanPoint;
				}
			}];
		}
	} else {
		CGPoint middlePanPoint = [recognizer translationInView:self];
		CGPoint translatedPoint = CGPointMake(_startingPanPoint.x - middlePanPoint.y, _startingPanPoint.y);
		imageView.center = translatedPoint;
		int heightDifference = abs(floor(_startingPanPoint.x - translatedPoint.x));
		CGFloat ratio = (_startingPanPoint.x - heightDifference)/_startingPanPoint.x;
		self.backgroundColor = [UIColor colorWithWhite:0. alpha:ratio];
	}
}


#pragma mark - Setters

- (void)setDisplayingDetailedView:(BOOL)displayingDetailedView
{
	_displayingDetailedView = displayingDetailedView;
	
	CGFloat newAlpha;
	
	if (_displayingDetailedView) {
		newAlpha = 1.;
	} else {
		newAlpha = 0.;
	}
	
    __block CGRect frame = _contentView.frame;
	[UIView animateWithDuration:AGPhotoBrowserAnimationDuration
					 animations:^(){
                         if (_contentView) {
                             if (newAlpha == 0.) {
                                 frame.origin.y += 40;
                             }else{
                                 frame.origin.y -= 40;
                             }
                             [_contentView setFrame:frame];
                         }
					 }];
}


#pragma mark - Getters
- (UITableView *)photoTableView
{
	if (!_photoTableView) {
		CGRect screenBounds = [[UIScreen mainScreen] bounds];
		_photoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(screenBounds), CGRectGetWidth(screenBounds))];
		_photoTableView.dataSource = self;
		_photoTableView.delegate = self;
		_photoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_photoTableView.backgroundColor = [UIColor clearColor];
		_photoTableView.rowHeight = screenBounds.size.width;
		_photoTableView.pagingEnabled = YES;
		_photoTableView.showsVerticalScrollIndicator = NO;
		_photoTableView.showsHorizontalScrollIndicator = NO;
		_photoTableView.alpha = 0.;
		
		// -- Rotate table horizontally
		CGAffineTransform rotateTable = CGAffineTransformMakeRotation(-M_PI_2);
		CGPoint origin = _photoTableView.frame.origin;
		_photoTableView.transform = rotateTable;
		CGRect frame = _photoTableView.frame;
		frame.origin = origin;
		_photoTableView.frame = frame;
	}
	
	return _photoTableView;
}


#pragma mark - Private methods
- (void)_doneButtonTapped:(UIButton *)sender
{
    if (_isEdit) {
        if (_customNavigationView.minY < 0) {
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _customNavigationView.minY = 0;
            } completion:nil];
            
            if (isShowEditMenu) {
                checkBtn.hidden = NO;
            }
            
        }else{
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _customNavigationView.minY = -44;
            } completion:nil];
            
            checkBtn.hidden = YES;
            
        }

        return;
    }
	if ([_delegate respondsToSelector:@selector(showPhotoView:didTapOnDoneButton:)]) {
		self.displayingDetailedView = NO;
        [_delegate showPhotoView:self didTapOnDoneButton:sender];
	}
}

@end
