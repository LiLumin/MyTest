//
//  ViewController.m
//  cs
//
//  Created by LLMPro on 16/12/3.
//  Copyright © 2016年 LLMPro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)NSMutableArray * array;

@end

@implementation ViewController

{
    
    UIActivityIndicatorView* _activity;
    BOOL _isRefresh;
    UIView* _headView;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;

    
    [self creatUI];
    

    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)creatUI{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self initwithData];
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    _tableView.tableHeaderView = _headView;

    _headView.backgroundColor = [UIColor clearColor];
    
    _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    
    [_headView addSubview:_activity];
    _activity.frame = CGRectMake(_headView.frame.size.width/2, _headView.frame.size.height/2, 20, 20);
    
    _headView.hidden = YES;

}
-(void)testTableView
{
    //等待2s
    _headView.hidden = NO;
    [_activity startAnimating];
    _isRefresh = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [_array addObject:@"haode"];
        [_tableView reloadData];
        [_activity stopAnimating];
        _headView.hidden = YES;
        _isRefresh = NO;
    });
    
    
    
    
    
}

- (void)initwithData{

    _array = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",nil];
    
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{




    return _array.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = _array[indexPath.row];
    
    return cell;


}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<=0  && _isRefresh==NO)
    {
        [self testTableView];
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
