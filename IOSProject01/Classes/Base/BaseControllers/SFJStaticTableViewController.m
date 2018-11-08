//
//  SFJStaticTableViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/6/27.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJStaticTableViewController.h"
#import "SFJSettingCell.h"

const UIEdgeInsets tableViewDefaultSeparatorInset = {0, 15, 0, 0};
const UIEdgeInsets tableViewDefaultLayoutMargins = {8, 8, 8, 8};

@interface SFJStaticTableViewController ()

@end

@implementation SFJStaticTableViewController

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sections[section].items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SFJTableItem *item = self.sections[indexPath.section].items[indexPath.row];
    
    SFJSettingCell *cell = [SFJSettingCell cellWithTableView:tableView andCellStyle:UITableViewCellStyleValue1];
    
    cell.item = item;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 普通的cell 点击
    SFJTableItem *item = self.sections[indexPath.section].items[indexPath.row];
    
    if (item.itemOperation) {
        item.itemOperation(indexPath);
        return;
    }

    // 需要跳转的cell点击
    if ([item isKindOfClass:[SFJTableArrowItem class]]) {
        SFJTableArrowItem *arrowItem = (SFJTableArrowItem *)item;
        // 有 点击可以跳转的控制器 时
        if (arrowItem.destVc) {
            UIViewController *vc = [[arrowItem.destVc alloc] init];
            if ([vc isKindOfClass:[UIViewController class]]) {
                vc.navigationItem.title = arrowItem.title;    //设置子控制器的 title
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sections[section].headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return self.sections[section].footerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.sections[indexPath.section].items[indexPath.row].cellHeight;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeadererInSection:(NSInteger)section
//{
//    return self.sections[section].headerHeight;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return self.sections[section].footerHeight;
//}

- (NSMutableArray<SFJTableSection *> *)sections
{
    if(_sections == nil)
    {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

-(SFJStaticTableViewController *(^)(SFJTableItem *))addItem{
    LMJWeak(self);
    if (!self.sections.firstObject) {
        [self.sections addObject:[SFJTableSection sectionWithItems:@[] andHeaderTitle:nil footerTitle:nil]];
    }
    return  ^SFJStaticTableViewController *(SFJTableItem *item) {
        [weakself.sections.firstObject.items addObject:item];
        return weakself;
    };
   
}
@end
