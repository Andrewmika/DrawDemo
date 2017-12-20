//
//  PieChartProgressViewController.m
//  DrawDemo
//
//  Created by Andrew Shen on 20/12/2017.
//  Copyright © 2017 小小厨师的厨房. All rights reserved.
//

#import "PieChartProgressViewController.h"
#import "PieChartProgress.h"
@interface PieChartProgressViewController ()

@property (weak, nonatomic) IBOutlet PieChartProgress *chartProgress;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@end

@implementation PieChartProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.chartProgress configPercentage:self.slider.value];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)p_percentChanged:(UISlider *)sender {
    CGFloat value = sender.value;
    [self.chartProgress configPercentage:value];
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
