//
//  ProductDetailViewController.m
//  PulseDemoApp
//
//  Created by Blake Ball on 2/11/14.
//  Copyright (c) 2014 IBM MIL. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "MCRotatingCarousel.h"
#import "CustomerInformationViewController.h"
#import "MILTransitionAnimator.h"

@interface ProductDetailViewController ()<MCRotatingCarouselDataSource, MCRotatingCarouselDelegate>{
    NSMutableArray *_images;
}

- (IBAction)dismiss:(id)sender;
- (IBAction)showCustomerForm:(id)sender;
- (IBAction)requestClicked:(id)sender;

@end

@implementation ProductDetailViewController{
    
}

-(void)viewDidLoad
{
    //self.view.bounds = CGRectMake(150, 0, 768, 768);
    [super viewDidLoad];
    _images = [[NSMutableArray alloc] init];
    
    [_images addObject:@"angle1" ];
    [_images addObject:@"angle2"];
    [_images addObject:@"angle3"];
    
    
    MCRotatingCarousel *carousel = [[MCRotatingCarousel alloc]initWithFrame:CGRectMake(0, 60, 768, 550)];
    carousel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    carousel.delegate = self;
    carousel.dataSource = self;
    //carousel.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    //carousel.pageControl.pageIndicatorTintColor = [UIColor cyanColor];
    carousel.pageControl.pageIndicatorTintColor = [UIColor clearColor];
    carousel.pageControl.currentPageIndicatorTintColor = [UIColor clearColor];
    [self.view addSubview:carousel];
    
    [carousel reloadData];

}

#pragma mark - MCRotatingCarouselDataSource
-(UIView *)rotatingCarousel:(MCRotatingCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    //Create your view here - it could be any kind of view, eg. a UIImageView.
    //UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    //view.backgroundColor = self.items[index];
    
    NSLog(@"Image was %@",_images[index]);
    UIView *imageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 185, 250)];
    
    //UIImageView *imageView = [[UIImageView alloc] initWithImage:];
    //[imageView setImage:[UIImage imageNamed:@"Home"]];
    [imageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:_images[index]]]];
    imageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    imageView.layer.borderWidth = 1;
    //imageView.frame = CGRectMake(0, 0, 150, 150);
    //imageView.center = imageView.superview.center;
    
    /*self.view.backgroundColor = [UIColor lightGrayColor];
    self.view.layer.borderWidth = 1;*/
    
    return imageView;
}

-(NSUInteger)numberOfItemsInRotatingCarousel:(MCRotatingCarousel *)carousel
{
    return _images.count;
}

#pragma mark - MCRotatingCarouselDelegate
-(void)rotatingCarousel:(MCRotatingCarousel *)carousel didSelectView:(UIView *)view atIndex:(NSUInteger)index
{
    NSLog(@"did select item at index: %i",index);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleTapBehind:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint flocation = [sender locationInView:nil]; //Passing nil gives us coordinates in the window
        
        //Then we convert the tap's location into the local view's coordinate system, and test to see if it's in or outside. If outside, dismiss the view.
        
        CGPoint tap = [self.view convertPoint:flocation fromView:self.view.window];
        CGPoint tapBar = [self.navigationController.navigationBar convertPoint:flocation fromView:self.view.window];
        if (![self.view pointInside:tap withEvent:nil] && ![self.navigationController.navigationBar pointInside:tapBar withEvent:nil])
        {
            // Remove the recognizer first so it's view.window is valid.
            [self.view.window removeGestureRecognizer:sender];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showCustomerForm:(id)sender {
    CustomerInformationViewController *customerForm = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomerForm"];
    customerForm.transitioningDelegate = self;
    customerForm.modalPresentationStyle = UIModalPresentationCustom;
    customerForm.view.frame = CGRectMake(368, 0, 400, 768);
    [self addChildViewController:customerForm];
    [self.view addSubview:customerForm.view];
    /*[self presentViewController:customerForm animated:YES completion:^{
        NSLog(@"Completed");
    }];*/
    
}

- (IBAction)requestClicked:(id)sender {
    [self showCustomerForm:sender];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    CustomerInformationViewController *vc = segue.destinationViewController;
    vc.transitioningDelegate = self;
    vc.modalTransitionStyle = UIModalPresentationCustom;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    MILTransitionAnimator *animator = [MILTransitionAnimator new];
    [animator setBounds:CGRectMake(630, 0, 400, 768)];
    animator.presenting = YES;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    MILTransitionAnimator *animator = [MILTransitionAnimator new];
    return animator;
}


@end
