//
//  DetailViewController.h
//  MasterDetail
//
//  Created by administrator on 16/3/10.
//  Copyright © 2016年 xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

