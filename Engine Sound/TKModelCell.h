//
//  TKModelCell.h
//  Engine Sound
//
//  Created by ASPCartman on 8/22/12.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKModelCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *modelLabel;
@property (nonatomic, strong) IBOutlet UILabel *companyNameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *thumbView;

@end
