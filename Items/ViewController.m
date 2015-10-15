//
//  ViewController.m
//  Items
//
//  Created by Harsha on 13/10/15.
//  Copyright © 2015 www.myapp. All rights reserved.
//

#import "ViewController.h"
#import "ItemTableViewCell.h"
#import "DataManager.h"
#import "Item.h"
#import "DetailViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,DataManagerDelegate>{
    DataManager *_dataManager;
    NSMutableArray *_dataArray;
    NSInteger _index;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView registerNib:[UINib nibWithNibName:@"ItemTableViewCell" bundle:nil] forCellReuseIdentifier:@"ItemTableViewCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    _dataManager = [[DataManager alloc]init];
    _dataManager.delegate = self;
    [_dataManager start];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark NewsDataManagerDelegate methods
-(void)dataDownloaded:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [_tableView reloadData];
}

#pragma mark UITableViewDelegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemTableViewCell *cell = (ItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ItemTableViewCell" forIndexPath:indexPath];
    Item *item = [_dataArray objectAtIndex:indexPath.row];
    [cell loadDataWithArticle:item];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *segue = @"PresentDetailPageSegue";
    _index = indexPath.row;
    [self performSegueWithIdentifier:segue sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"PresentDetailPageSegue"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        DetailViewController *detailController = (DetailViewController *)[navigationController visibleViewController];
        detailController.item = [_dataArray objectAtIndex:_index];
    }
}

@end
