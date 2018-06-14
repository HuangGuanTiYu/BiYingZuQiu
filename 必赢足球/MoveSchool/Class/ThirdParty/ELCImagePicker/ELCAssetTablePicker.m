//
//  AssetTablePicker.m
//
//  Created by zandavid on 15/7/31.
//  Copyright (c) 2015年 caobohua. All rights reserved.
//

#import "ELCAssetTablePicker.h"
#import "ELCAssetCell.h"
#import "ELCAsset.h"
#import "ELCAlbumPickerController.h"
#import "CHShowPhotoView.h"
#import "UIImage+Utils.h"
#import "ColorTypeTools.h"

@interface ELCAssetTablePicker ()< AGPhotoBrowserDataSource,
AGPhotoBrowserDelegate>
{
    UIBarButtonItem *doneButtonItem;
    
    NSMutableArray *selectedAssets;
}

@property (nonatomic, assign) int columns;

@property (nonatomic, strong) CHShowPhotoView *browserView;

@end

@implementation ELCAssetTablePicker

@synthesize parent = _parent;;
@synthesize selectedAssetsLabel = _selectedAssetsLabel;
@synthesize assetGroup = _assetGroup;
@synthesize elcAssets = _elcAssets;
@synthesize singleSelection = _singleSelection;
@synthesize columns = _columns;


- (void)viewDidLoad
{
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableView setAllowsSelection:NO];

    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    self.elcAssets = tempArray;
    
    
    selectedAssets = [[NSMutableArray alloc] init];
	
    self.tableView.backgroundColor = kViewBackgroundColor;
    
    self.view.backgroundColor = kViewBackgroundColor;
    
    if (self.immediateReturn) {
        
    } else {
        doneButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(doneAction:)];
        
        //doneButtonItem.tintColor = kCommonGreenTextColor;
        
        [self.navigationItem setRightBarButtonItem:doneButtonItem];
        //[self.navigationItem setTitle:@"Loading..."];
        
        
        
        NSString *groupName = [self.assetGroup valueForProperty:ALAssetsGroupPropertyName];
        if ([[groupName lowercaseString] isEqualToString:@"camera roll"])
            groupName = @"相机胶卷";
        [self.navigationItem setTitle:@"选择照片"];
    }

	[self performSelectorInBackground:@selector(preparePhotos) withObject:nil];
    self.navigationItem.leftBarButtonItem = [ColorTypeTools itemWithImageName:@"common_back" highImageName:@"" addTarget:self action:@selector(backC)];
    //    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
}
-(void)backC{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.columns = self.view.bounds.size.width / CellWidth;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    self.columns = self.view.bounds.size.width / CellWidth;
    [self.tableView reloadData];
}

- (void)preparePhotos
{
    //NSLog(@"enumerating photos");
    [self.assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if(result == nil) {
            return;
        }

        ELCAsset *elcAsset = [[ELCAsset alloc] initWithAsset:result];
        [elcAsset setParent:self];
        [self.elcAssets addObject:elcAsset];
     }];
    //NSLog(@"done enumerating photos");
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        // scroll to bottom
        NSInteger section = [self numberOfSectionsInTableView:self.tableView] - 1;
        NSInteger row = [self tableView:self.tableView numberOfRowsInSection:section] - 1;
        if (section >= 0 && row >= 0) {
            NSIndexPath *ip = [NSIndexPath indexPathForRow:row
                                                 inSection:section];
            [self.tableView scrollToRowAtIndexPath:ip
                                  atScrollPosition:UITableViewScrollPositionBottom
                                          animated:NO];
        }
        
        //[self.navigationItem setTitle:self.singleSelection ? @"Pick Photo" : @"Pick Photos"];
    });
}

- (void)doneAction:(id)sender
{	
	NSMutableArray *selectedAssetsImages = [[NSMutableArray alloc] init];
	    
	for(ELCAsset *elcAsset in selectedAssets) {

		if([elcAsset selected]) {
			
			[selectedAssetsImages addObject:[elcAsset asset]];
		}
	}

    [self.parent selectedAssets:selectedAssetsImages];

}

- (void)assetUnSelected:(id)asset
{
    int count = 0;
    
    for(ELCAsset *elcAsset in self.elcAssets) {
        
        if([elcAsset selected]) {
            
            count ++;
            
        }
    }
    
    
    [selectedAssets removeObject:asset];
    
    if (count==0) {
        doneButtonItem.title = @"选择";
    }else
    {
        doneButtonItem.title = [NSString stringWithFormat:@"已选(%d)",count];
    }
    
    
    
}

- (void)assetSelected:(id)asset
{
    [selectedAssets addObject:asset];
    
    if (self.singleSelection) {

        for(ELCAsset *elcAsset in self.elcAssets) {
            if(asset != elcAsset) {
                elcAsset.selected = NO;
            }
        }
        [self.tableView reloadData];
    }
    
    int count = 0;
    
    for(ELCAsset *elcAsset in self.elcAssets) {
        
        if([elcAsset selected]) {
            
            count ++;
            
        }
    }
    
    
    if (count==0) {
        doneButtonItem.title = @"选择";
    }else
    {
        doneButtonItem.title = [NSString stringWithFormat:@"已选(%d)",count];
    }
    
    
    if (self.immediateReturn) {
        NSArray *singleAssetArray = [NSArray arrayWithObject:[asset asset]];
        [(NSObject *)self.parent performSelector:@selector(selectedAssets:) withObject:singleAssetArray afterDelay:0];
    }
}

#pragma mark UITableViewDataSource Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ceil([self.elcAssets count] / (float)self.columns);
}

- (NSArray *)assetsForIndexPath:(NSIndexPath *)path
{
    int index = path.row * self.columns;
    int length = MIN(self.columns, [self.elcAssets count] - index);
    return [self.elcAssets subarrayWithRange:NSMakeRange(index, length)];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"Cell";
        
    ELCAssetCell *cell = (ELCAssetCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {		        
        cell = [[ELCAssetCell alloc] initWithAssets:[self assetsForIndexPath:indexPath] reuseIdentifier:CellIdentifier];
        cell.delegate = self;
    } else {		
		[cell setAssets:[self assetsForIndexPath:indexPath]];
	}
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int count = ceil([self.elcAssets count] / (float)self.columns);
    
    if (count>0 && indexPath.row == count -1) {
        return 120;
    }else
    {
        return 100;
    }
    
	
}

- (BOOL)isValidTapped
{
    return [self.parent selectedNumber:[self totalSelectedAssets]];
}

- (int)totalSelectedAssets {
    
    int count = 0;
    
    for(ELCAsset *asset in self.elcAssets) {
		if([asset selected]) {   
            count++;	
		}
	}
    
    return count;
}


-(void)showPhotoFromIndex:(ELCAsset *)asset
{
    
    NSInteger index = [self.elcAssets indexOfObject:asset];
    
    [self.browserView showFromIndex:index checked:asset.selected elcAssets:self.elcAssets];
}


#pragma mark - AGPhotoBrowser datasource
- (NSInteger)numberOfPhotosForShowPhotoView:(CHShowPhotoView *)photoBrowser{
    return [self.elcAssets count];
}

- (id)showPhotoView:(CHShowPhotoView *)photoBrowser imageAtIndex:(NSInteger)index{
    
    ELCAsset *asset = [self.elcAssets objectAtIndex:index];
    
    ALAssetRepresentation *assetRep = [asset.asset defaultRepresentation];
    
    CGImageRef imgRef = [assetRep fullScreenImage];
    UIImage *img = [UIImage imageWithCGImage:imgRef
                                       scale:[UIScreen mainScreen].scale
                                 orientation:UIImageOrientationUp];

    CGFloat scale = [UIImage scaleForPickImage:img maxWidthPixelSize:kImageMaxWidthPixelSize];
    UIImage *newImage = [UIImage scaleImage:img scale:scale];
    img = nil;
    NSData *imgData = UIImageJPEGRepresentation(newImage, 0.5);
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)index],@"key",imgData,@"data",@"",@"url", nil];
    
    return dic;
}


#pragma mark - AGPhotoBrowser delegate
- (void)showPhotoView:(CHShowPhotoView *)photoBrowser didTapOnDoneButton:(UIButton *)doneButton{
    // -- Dismiss
    //NSLog(@"Dismiss the photo browser here");
    [self.browserView hideWithCompletion:^(BOOL finished){
        [self.browserView removeFromSuperview];
        self.browserView = nil;
    }];
    
}

- (void)photoBrowser:(AGPhotoBrowserView *)photoBrowser didTapOnDeleteButton:(UIButton *)actionButton atIndex:(NSInteger)index{
    [self.elcAssets removeObjectAtIndex:index];
}

- (void)photoBrowser:(CHShowPhotoView *)photoBrowser OnChecked:(UIButton *)actionButton checked:(BOOL)checked atIndex:(NSInteger)index
{
    
    ELCAsset *elcAsset = [self.elcAssets objectAtIndex:index];
    
    elcAsset.selected = checked;
    
    [self.tableView reloadData];
}

#pragma mark - Getters
- (CHShowPhotoView *)browserView
{
    if (!_browserView) {
        _browserView = [[CHShowPhotoView alloc] initWithFrame:self.view.bounds andEdit:YES];
        _browserView.delegate = self;
        _browserView.dataSource = self;
        _browserView.subVc = self;
        [_browserView hideDeleteBtn];
        [_browserView showEditMenu];
        
    }
    return _browserView;
}


@end
