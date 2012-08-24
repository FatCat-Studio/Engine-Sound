//
//  TKModelCell.m
//  Engine Sound
//
//  Created by ASPCartman on 8/22/12.
//  Copyright (c) 2012 Timofey Korchagin. All rights reserved.
//

#import "TKModelCell.h"

@implementation TKModelCell
@synthesize modelLabel;
@synthesize companyNameLabel;
@synthesize thumbView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		NSArray *nibArray = [[NSBundle mainBundle]loadNibNamed:@"TKModelCell"
															owner:self options:nil];
		self = [nibArray objectAtIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
