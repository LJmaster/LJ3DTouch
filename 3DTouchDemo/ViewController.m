//
//  ViewController.m
//  3DTouchDemo
//
//  Created by liujie on 16/7/29.
//  Copyright © 2016年 liujie. All rights reserved.
//

#import "ViewController.h"
#import "NewsDetailsViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>

@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self craetView];
    _dataArr = [[NSMutableArray alloc] initWithObjects:@"1",@"shi",@"100 ",@"  hahah ", nil];
    
    
    [_mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)craetView{

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    _mainTable = tableView;
    [self.view addSubview:_mainTable];
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _dataArr.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataArr[indexPath.row];
    
    if ([self respondsToSelector:@selector(traitCollection)]) {
        if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
            if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
                [self registerForPreviewingWithDelegate:self sourceView:cell];
            }
        }
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;


}

#pragma mark - UIViewControllerPreviewingDelegate
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    NSIndexPath *index = [self.mainTable indexPathForCell:(UITableViewCell *)[previewingContext sourceView]];
//    NewsListModel *model = ;
    
    NewsDetailsViewController *showVC = [[NewsDetailsViewController alloc]init];
    showVC.title = self.dataArr[index.row];
    
//    CGRect rect = CGRectMake(0, 0,  previewingContext.sourceView.ab_width, previewingContext.sourceView.ab_height);
//    previewingContext.sourceRect = rect;
    
    return showVC;
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction *action0 = [UIPreviewAction actionWithTitle:@"action0" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"%s, line = %d, action0 = %@, previewViewController = %@", __FUNCTION__, __LINE__, action, previewViewController);
        
    }];
    
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"action1" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"%s, line = %d, action1 = %@, previewViewController = %@", __FUNCTION__, __LINE__, action, previewViewController);
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"action2" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"%s, line = %d, action2 = %@, previewViewController = %@", __FUNCTION__, __LINE__, action, previewViewController);
    }];
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"action3" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"%s, line = %d, action2 = %@, previewViewController = %@", __FUNCTION__, __LINE__, action, previewViewController);
    }];
    
    //该按钮可以是一个组,点击该组时,跳到组里面的按钮.
    UIPreviewActionGroup *actionGroup = [UIPreviewActionGroup actionGroupWithTitle:@"actionGroup" style:UIPreviewActionStyleSelected actions:@[action2, action3]];
    //直接返回数组.
    return  @[action0,action1,actionGroup];
}
#pragma mark - UIViewControllerPreviewingDelegate
-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self showViewController:viewControllerToCommit sender:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
