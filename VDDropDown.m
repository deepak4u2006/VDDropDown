//
//  VDDropDown.m
//  VDDropDown
//
//  Created by Vishwa Deepak on 13/10/15.
//  Copyright © 2015 mFino. All rights reserved.
//

#import "VDDropDown.h"
#import "QuartzCore/QuartzCore.h"
#import "WebService.h"

@interface VDDropDown ()
{
    CGRect Frame;
}
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIButton *btnSender;
@property(nonatomic, retain) NSArray *list;
@property(nonatomic, retain) NSArray *imageList;
@property(nonatomic, retain) NSString *titleStr;

@end

@implementation VDDropDown
@synthesize table;
@synthesize btnSender;
@synthesize list;
@synthesize imageList;
@synthesize delegate;
@synthesize animationDirection;

//- (id)showDropDown:(UIButton *)b:(CGFloat *)height:(NSArray *)arr:(NSArray *)imgArr:(NSString *)direction;
- (id)showDropDown:(UIButton *)butn withHeight:(CGFloat *)height usingArray:(NSArray *)arr andImageArray:(NSArray *)imgArr inDirection: (NSString *)direction
{
    btnSender = butn;
    animationDirection = direction;
    self.table = (UITableView *)[super init];
    
    Frame = btnSender.superview.superview.frame;
    
    if (self) {
        // Initialization code
        CGRect btn = butn.frame;
        self.list = [NSArray arrayWithArray:arr];
        self.imageList = [NSArray arrayWithArray:imgArr];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, -5);
        }else if ([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-2, 5);
        }
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, Frame.origin.y+btn.size.height+20, btn.size.width, 0)];
        table.delegate = self;
        table.dataSource = self;
        table.layer.cornerRadius = 0;
        table.backgroundColor = [UIColor clearColor];
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.separatorColor = [UIColor grayColor];
        [table setSeparatorInset:UIEdgeInsetsZero];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y-*height, btn.size.width, *height);
        } else if([direction isEqualToString:@"down"]) {
//          self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, *height);
            self.frame = CGRectMake([UIScreen mainScreen].bounds.origin.x, [UIScreen mainScreen].bounds.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }
        table.frame = CGRectMake(btn.origin.x, Frame.origin.y+btn.size.height+64, btn.size.width, *height);
        [UIView commitAnimations];
//        [butn.superview addSubview:self];
//        [butn.superview bringSubviewToFront:self];
        [self addSubview:table];
    }
    
    UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(tapped)];
    tapView.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapView];
    tapView.delegate = self;
    
    return self;
}

- (id)showDropDown:(UIButton *)butn withHeight:(CGFloat *)height usingArray:(NSArray *)arr andImageArray:(NSArray *)imgArr inDirection: (NSString *)direction inDropTitle: (NSString *)titleStr
{
    btnSender = butn;
    animationDirection = direction;
    self.table = (UITableView *)[super init];
    
    Frame = btnSender.superview.superview.frame;
    
    if (self) {
        // Initialization code
        CGRect btn = butn.frame;
        self.list = [NSArray arrayWithArray:arr];
        self.imageList = [NSArray arrayWithArray:imgArr];
        self.titleStr=titleStr;
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, -5);
        }else if ([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-2, 5);
        }
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
            //table = [[UITableView alloc] initWithFrame:CGRectMake(0, Frame.origin.y+btn.size.height+10, btn.size.width, 0)];
       table = [[UITableView alloc] initWithFrame:CGRectMake(0, Frame.origin.y+btn.size.height+10, btn.size.width, 0) style:UITableViewStyleGrouped];
        table.layer.cornerRadius=3.0f;

        table.delegate = self;
        table.dataSource = self;
        table.layer.cornerRadius = 0;
        table.backgroundColor = [UIColor whiteColor];
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.separatorColor = [UIColor groupTableViewBackgroundColor];
        [table setSeparatorInset:UIEdgeInsetsZero];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y-*height, btn.size.width, *height);
        } else if([direction isEqualToString:@"down"]) {
            //          self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, *height);
            self.frame = CGRectMake([UIScreen mainScreen].bounds.origin.x, [UIScreen mainScreen].bounds.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }
        table.frame = CGRectMake(btn.origin.x, Frame.origin.y+btn.size.height+64, btn.size.width, 250);
        [UIView commitAnimations];
        //        [butn.superview addSubview:self];
        //        [butn.superview bringSubviewToFront:self];
        [self addSubview:table];
    }
    
    UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                action:@selector(tapped)];
    tapView.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapView];
    tapView.delegate = self;
    
    return self;
}

-(void)tapped
{
    [self hideDropDown:btnSender];
    [self myDelegate:nil];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


-(void)hideDropDown:(UIButton *)b {
    CGRect btn = b.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if ([animationDirection isEqualToString:@"up"]) {
        self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
    }else if ([animationDirection isEqualToString:@"down"]) {
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
    }
    table.frame = CGRectMake(0, Frame.origin.y+btn.size.height+20, btn.size.width, 0);
    [UIView commitAnimations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
        return 1.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 1.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
/*    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    if ([self.imageList count] == [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
        cell.imageView.image = [imageList objectAtIndex:indexPath.row];
    } else if ([self.imageList count] > [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
        if (indexPath.row < [imageList count]) {
            cell.imageView.image = [imageList objectAtIndex:indexPath.row];
        }
    } else if ([self.imageList count] < [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
        if (indexPath.row < [imageList count]) {
            cell.imageView.image = [imageList objectAtIndex:indexPath.row];
        }
    }
    
    cell.textLabel.textColor = [UIColor grayColor];
    
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = v;
    
    return cell;
 */
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font =SourceSansProRegular(kJVFieldFontSize);
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.numberOfLines=0;
    }
    if ([self.list count]>0) {
        if ([self.titleStr isEqualToString:@"Category"])
        {
            cell.textLabel.text =[[list objectAtIndex:indexPath.row]valueForKey:@"description"];
            //cell.imageView.image = [imageList objectAtIndex:indexPath.row];
        }
        else if ([self.titleStr isEqualToString:@"BillerCategory"])
            {
            cell.textLabel.text =[[list objectAtIndex:indexPath.row]valueForKey:@"description"];
                //cell.imageView.image = [imageList objectAtIndex:indexPath.row];
            }
        else if ([self.titleStr isEqualToString:@"Card"])
            {
            cell.textLabel.text =[[list objectAtIndex:indexPath.row]valueForKey:@"displayName"];
                //cell.imageView.image = [imageList objectAtIndex:indexPath.row];
            }
        else if ([self.titleStr isEqualToString:@"Biller"])
        {
            cell.textLabel.text =[[list objectAtIndex:indexPath.row]valueForKey:@"description"];
            
        }
        else if ([self.titleStr isEqualToString:@"Circle"])
            {
            cell.textLabel.text =[list objectAtIndex:indexPath.row];
            
            }
        else
        {
            cell.textLabel.text =[list objectAtIndex:indexPath.row];
        }
        
    } else if ([self.imageList count] > [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
        if (indexPath.row < [imageList count]) {
            cell.imageView.image = [imageList objectAtIndex:indexPath.row];
        }
    } else if ([self.imageList count] < [self.list count]) {
        cell.textLabel.text =[list objectAtIndex:indexPath.row];
        if (indexPath.row < [imageList count]) {
            cell.imageView.image = [imageList objectAtIndex:indexPath.row];
        }
    }
    
    cell.textLabel.textColor = [UIColor grayColor];
    
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor lightGrayColor];
    cell.selectedBackgroundView = v;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDown:btnSender];
    
    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    
    //For UIButton Class
    if ([btnSender respondsToSelector:@selector(setTitle:forState:)]) {
        [btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
        for (UIView *subview in btnSender.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                [subview removeFromSuperview];
            }
        }
        imgView.image = c.imageView.image;
        imgView = [[UIImageView alloc] initWithImage:c.imageView.image];
        imgView.frame = CGRectMake(5, 5, 25, 25);
        [btnSender addSubview:imgView];
    }
    //FOr UITextField Class
    else if ([btnSender respondsToSelector:@selector(setText:)]){
        [(UITextField *)btnSender setText: c.textLabel.text];
    }   
    [self myDelegate : (NSIndexPath *)indexPath];
}

- (void) myDelegate : (NSIndexPath *)indexPath
{
    [self.delegate vdDropDownTableDidSelectRowAtIndexPath:indexPath];
    [self.delegate vdDropDownDelegateMethod:self];
}

-(void)dealloc {
    //    [super dealloc];
    //    [table release];
    //    [self release];
}



@end
