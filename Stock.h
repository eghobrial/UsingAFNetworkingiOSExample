//
//  Stock.h
//  TestStocks
//
//  Created by Eman on 10/27/15.
//  Copyright © 2015 EmanGhobrial. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stock : NSObject
@property NSString* symbol;
@property float purchasePrice;
@property int numofStocks;
@property float brokerageFee;
@property float currentPrice;
-(id) initWithSymbol:(NSString*)symbol andPurchasePrice:(float)pPrice andNum:(int)num andBFee:(float)bFee;
-(float) calGainLose: (float) currentPrice;


@end
