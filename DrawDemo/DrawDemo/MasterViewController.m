//
//  MasterViewController.m
//  DrawDemo
//
//  Created by Andrew Shen on 20/12/2017.
//  Copyright © 2017 小小厨师的厨房. All rights reserved.
//

#import "MasterViewController.h"
#import "CircleChartViewController.h"
#import "PieChartProgressViewController.h"
@interface MasterViewController ()
@property (nonatomic, copy)  NSArray  *objects; // <##>
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.objects[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Class class;
    switch (indexPath.row) {
        case 0:
            class = [PieChartProgressViewController class];
            break;
        case 1:
            class = [CircleChartViewController class];
            break;
        default:
            break;
    }
    NSString *identifier = NSStringFromClass(class);
    UIViewController *VC = [mainSB instantiateViewControllerWithIdentifier:identifier];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - Init

- (NSArray *)objects {
    if (!_objects) {
        _objects = @[@"饼图进度条",@"环状图表"];
    }
    return _objects;
}

@end
