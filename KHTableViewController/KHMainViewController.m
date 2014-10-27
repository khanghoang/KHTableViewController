//
//  KHMainViewController.m
//  KHAwesomeImage
//
//  Created by Triệu Khang on 11/10/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "KHMainViewController.h"
#import "ViewController.h"
#import "KHFreshTodayImagesViewController.h"
#import "KHFreshTodayCollectionViewController.h"

typedef NS_ENUM (NSUInteger, kMainViewControllerSegmentValue) {
	kMainViewControllerSegmentValuePopular = 0,
	kMainViewControllerSegmentValueFreshToday = 1
};

@interface KHMainViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentType;
@property (strong, nonatomic) UIViewController *popularVC;
@property (strong, nonatomic) UIViewController *freshTodayVC;

@property (strong, nonatomic) UIViewController *currentChildVC;

@end

@implementation KHMainViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self onSegment:self.segmentType];
}

- (IBAction)onSegment:(UISegmentedControl *)segment {
	[self _changeChildViewControllerWithType:segment.selectedSegmentIndex];
}

- (UIViewController *)popularVC {
	if (!_popularVC) {
		ViewController *vc = [[UIStoryboard storyboardWithName:@"Popular" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([ViewController class])];
		_popularVC = vc;
	}

	return _popularVC;
}

- (UIViewController *)freshTodayVC {
	if (!_freshTodayVC) {
		KHFreshTodayImagesViewController *vc = [[UIStoryboard storyboardWithName:@"FreshToday" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([KHFreshTodayImagesViewController class])];
		_freshTodayVC = vc;
	}

	return _freshTodayVC;
}

- (void)_changeChildViewControllerWithType:(kMainViewControllerSegmentValue)type {
	[self _removeCurrentChildViewController];
	ViewController *vc = nil;

	if (type == kMainViewControllerSegmentValuePopular) {
		vc = [[UIStoryboard storyboardWithName:@"Popular" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([ViewController class])];
    } else {
		vc = [[UIStoryboard storyboardWithName:@"FreshTodayCollection" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([KHFreshTodayCollectionViewController class])];
    }

	[vc willMoveToParentViewController:self];
	[self.view addSubview:vc.view];
	[self addChildViewController:vc];
	[vc didMoveToParentViewController:self];

	self.currentChildVC = vc;
}

- (void)_removeCurrentChildViewController {
	[self.currentChildVC willMoveToParentViewController:nil];
	[self.currentChildVC.view removeFromSuperview];
	[self.currentChildVC didMoveToParentViewController:nil];
	self.currentChildVC = nil;
}

@end
