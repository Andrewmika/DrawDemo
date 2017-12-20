//
//  CircleChartViewController.m
//  DrawDemo
//
//  Created by Andrew Shen on 20/12/2017.
//  Copyright © 2017 小小厨师的厨房. All rights reserved.
//

#import "CircleChartViewController.h"
#import "CircleChartView.h"
@interface CircleChartViewController ()

@property (weak, nonatomic) IBOutlet CircleChartView *chartView;
@end

@implementation CircleChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.chartView configAmountArray:@[@1,@2,@3] totalAssets:6 colorsArray:@[[UIColor greenColor],[UIColor yellowColor],[UIColor cyanColor]] lineWidth:70];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
