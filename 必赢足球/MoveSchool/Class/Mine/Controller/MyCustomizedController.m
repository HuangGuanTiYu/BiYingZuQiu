//
//  MyCustomizedController.m
//  MoveSchool
//
//  Created by edz on 2017/9/17.
//
//

#import "MyCustomizedController.h"
#import "AFNetWW.h"
#import "MyOrderModel.h"
#import "MJExtension.h"
#import "UIImageView+CornerRadius.h"
#import "TagView.h"

@interface MyCustomizedController ()<TagViewDelegate>

@property (nonatomic, strong) TagView *tagView;

@end

@implementation MyCustomizedController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的定制";
    
    [self setUpUI];

}


- (void) setUpUI
{
    NSString *likeUrl = UserLabelList;
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         NSArray *selectedModels = [MyOrderModel objectArrayWithKeyValuesArray:responseDic];
         NSMutableArray *selectedItems = [NSMutableArray array];
         NSMutableArray *selectedIds = [NSMutableArray array];
         
         for (MyOrderModel *model in selectedModels) {
             [selectedItems addObject:model.name];
             [selectedIds addObject:model.ID];
         }
         
         NSString *likeUrl = SelectLabelType;
         
         [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
          {
              NSArray *selectedModels = [MyOrderModel objectArrayWithKeyValuesArray:responseDic];
              NSMutableArray *unSelectedItems = [NSMutableArray array];
              NSMutableArray *unSelectedIds = [NSMutableArray array];
              
              for (MyOrderModel *model in selectedModels) {
                  if (model.selected == 0) {
                      [unSelectedItems addObject:model.name];
                      [unSelectedIds addObject:model.ID];
                  }
              }
              
              self.tagView = [[TagView alloc] initWithFrame:self.view.bounds SelectedItems:selectedItems unselectedItems:unSelectedItems];
              self.tagView.delegate = self;
              self.tagView.selectedIds = selectedIds;
              self.tagView.unSelectedIds = unSelectedIds;
              [self.view addSubview:self.tagView];
              
          }fail:^(NSError *error) {
              
          }];
         
     }fail:^(NSError *error) {
         
     }];
    
}

//delegate
-(void)tagView:(TagView *)tagView editState:(BOOL)state
{

}

-(void)tagView:(TagView *)tagView selectedTag:(NSInteger)row
{
    NSLog(@"点击了%ld",(long)row);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

@end
