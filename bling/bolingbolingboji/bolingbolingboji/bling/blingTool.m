//
//  blingTool.m
//  bolingbolingboji
//
//  Created by SmartFun on 2017/12/20.
//  Copyright © 2017年 SmartFun. All rights reserved.
//

#import "blingTool.h"
#import <CoreMotion/CoreMotion.h>

@interface blingTool()

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) UIDynamicItemBehavior *dynamicItemBehavior;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;

@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation blingTool

- (instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    CMMotionManager *manager = [[CMMotionManager alloc] init];
    self.motionManager = manager;
    if ([self.motionManager isDeviceMotionAvailable]) {
      
        manager.deviceMotionUpdateInterval = 1;
    
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                                withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
                                                    double gravityX = motion.gravity.x;
                                                    double gravityY = motion.gravity.y;
                                                    double xy = atan2(gravityX, gravityY);
                                                    self.gravityBehavior.angle = xy-M_PI_2;
                                                }];
    }
}

- (void)addBehaviorArea:(UIView *)temp{
    
    self.dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:temp];
    self.dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[]];
    self.dynamicItemBehavior.elasticity = 0.5;
    self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[]];
    self.collisionBehavior = [[UICollisionBehavior alloc]initWithItems:@[]];
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.dynamicAnimator addBehavior:_dynamicItemBehavior];
    [self.dynamicAnimator addBehavior:_gravityBehavior];
    [self.dynamicAnimator addBehavior:_collisionBehavior];
    
}

- (void)addBehaviorForItem:(id)sender{
    
    [self.dynamicItemBehavior addItem:sender];
    [self.gravityBehavior addItem:sender];
    [self.collisionBehavior addItem:sender];
    
}

- (void)removeItem:(id)sender{
    [self.dynamicItemBehavior removeItem:sender];
    [self.gravityBehavior removeItem:sender];
    [self.collisionBehavior removeItem:sender];
}

@end
