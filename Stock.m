//
//  Stock.m
//  TestStocks
//
//  Created by Eman on 10/27/15.
//  Copyright © 2015 EmanGhobrial. All rights reserved.
//

#import "Stock.h"

@implementation Stock
-(id) initWithSymbol:(NSString*)symbol andPurchasePrice:(float)pPrice andNum:(int)num andBFee:(float)bFee
{
    self = [super init];
    self.symbol = symbol;
    self.purchasePrice = pPrice;
    self.numofStocks = num;
    self.brokerageFee = bFee;
    return self;
}
-(float) calGainLose: (float)currentPrice
{
    float gainorlose = self.numofStocks * currentPrice - (self.numofStocks*self.purchasePrice+self.brokerageFee);
    return gainorlose;
}

@end
