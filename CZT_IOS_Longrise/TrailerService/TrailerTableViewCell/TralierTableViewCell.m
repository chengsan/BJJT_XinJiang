//
//  TralierTableViewCell.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/25.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "TralierModel.h"
#import "TralierTableViewCell.h"

@implementation TralierTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(TralierModel *)model{
    self.InternetNameLabel.text = model.servicename;
    self.adressNameLabel.text = model.serviceaddress;
    self.telephoneLabel.text = model.servicetel;
    self.servicetel = model.servicetel;
}

- (IBAction)phoneCallClicked:(id)sender {
    [self.delegate callWithPhoneNumber:_servicetel];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
