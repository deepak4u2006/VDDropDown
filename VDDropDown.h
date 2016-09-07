//
//  VDDropDown.h
//  VDDropDown
//
//  Created by Vishwa Deepak on 13/10/15.
//  Copyright © 2015 mFino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VDDropDown;
@protocol VDDropDownnDelegate

- (void) vdDropDownDelegateMethod: (VDDropDown *) sender;
- (void) vdDropDownTableDidSelectRowAtIndexPath: (NSIndexPath *)indexPath;

@end

@interface VDDropDown : UIView<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
{
    NSString *animationDirection;
    UIImageView *imgView;
}
@property (nonatomic, retain) id <VDDropDownnDelegate> delegate;
@property (nonatomic, retain) NSString *animationDirection;

-(void)hideDropDown:(UIButton *)b;
- (id)showDropDown:(UIButton *)butn withHeight:(CGFloat *)height usingArray:(NSArray *)arr andImageArray:(NSArray *)imgArr inDirection: (NSString *)direction;

- (id)showDropDown:(UIButton *)butn withHeight:(CGFloat *)height usingArray:(NSArray *)arr andImageArray:(NSArray *)imgArr inDirection: (NSString *)direction  inDropTitle: (NSString *)titleStr;

@end
