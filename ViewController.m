//
//  ViewController.m
//  Final
//
//  Created by Eman Ghobrial on 11/11/15.
//  Copyright © 2015 Eman Ghobrial. All rights reserved.
//

#import "ViewController.h"
#import "Stock.h"
#import "AFHTTPRequestOperationManager.h"

@interface ViewController ()

@end

@implementation ViewController

-(NSString*)loadFileFromApp :(NSString*)fileName withExtension:(NSString*)fileExt
{
    self.fileManager = [NSFileManager defaultManager];
    NSBundle *myBundle = [NSBundle mainBundle];
    NSString *fileUrlString = [myBundle pathForResource:fileName ofType:fileExt];
    NSURL *myUrl = [myBundle URLForResource:fileName withExtension:fileExt];
    if ([self.fileManager fileExistsAtPath:fileUrlString]) {
        NSLog(@"file exists");
        NSError *error1;
        NSString *myString = [NSString stringWithContentsOfURL:myUrl encoding:NSUTF8StringEncoding error:&error1];
        if (error1 == nil) {
            //success
          //  NSLog(@"the contents of the file are: %@", myString);
            return myString;
        } else {
            //error happened
            NSLog(@"My error is: %@", error1.description);
            NSLog(@"My error is: %ld %@", error1.code, error1.domain);
            return nil;
        }
    } else {
        //file not found
        return nil;
    }
}
-(NSString*) constructURL: (NSMutableString*)symbols
{
    NSString* myURl = [NSString stringWithFormat:@"http://finance.yahoo.com/webservice/v1/symbols/%@/quote?format=json&view=detail",symbols];
    return myURl;
}

-(IBAction)goButtonPressed:(id)sender
{
    NSString* fileContents = [self loadFileFromApp:@"stocks" withExtension:@"txt"];
    NSMutableString* mySymbols = [NSMutableString stringWithFormat:@""];
    self.myStocks = [NSMutableArray array];
    
    if (fileContents == nil) {
        //something went wrong
        NSString* text4UIerr = [NSString stringWithFormat:@"Error: Something went wrong please check the input file \n "];
        // self.myView.editable = NO;
        [self.mytextView setText:text4UIerr];
        
    } else {
        //all went right populate my stocks array if it is not nil
        NSArray* myStocks = [fileContents componentsSeparatedByString:@"\n"];
        
       if (self.myStocks != nil)
       {
        for (int i=0;i<myStocks.count-1;i++)
        {
            NSArray* temp = [myStocks[i] componentsSeparatedByString:@","];
            Stock* tempS = [[Stock alloc]initWithSymbol:temp[0] andPurchasePrice:[temp[1] floatValue] andNum:[temp[2]intValue] andBFee:[temp[3]floatValue]];
            [self.myStocks addObject:tempS];
            NSString* tempStr = [NSString stringWithFormat:@"%@,",temp[0]];
            [mySymbols appendString:tempStr];
            
        }
       }
    }
        NSString* myURL = [self constructURL:mySymbols];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager GET:myURL parameters:nil success:^(AFHTTPRequestOperation *operation, id stockObject) {
             NSMutableString* text4UI = [NSMutableString stringWithFormat:@"My Stocks Gain/Loss\n\n"];
            if ([stockObject isKindOfClass:[NSDictionary class]])
            {
                NSDictionary   *listDict = (NSDictionary*)stockObject[@"list"];
                NSArray  *resourceArray = listDict[@"resources"];
                for (int i = 0; i<resourceArray.count;i++)
                {
                    NSString* tempsym = resourceArray[i][@"resource"][@"fields"][@"symbol"];
                    NSString* tempgorlStr = nil;
                   // NSLog(@"Stock Symbol %@ ", tempsym);
                    for (Stock* nextStock2 in self.myStocks )
                    {
                        if (nextStock2.symbol == tempsym)
                        {
                            float tempcp = [resourceArray[i][@"resource"][@"fields"][@"price"] floatValue];
                           // NSLog(@"Stock current price %0.2f",tempcp);
                            float tempgorl = [nextStock2 calGainLose:tempcp];
                            if (tempgorl < 0)
                            {
                                //negative (loss)
                                 tempgorlStr = [NSString stringWithFormat:@"Loss = ($ %0.2f) ",tempgorl];
                            }else{
                                 tempgorlStr = [NSString stringWithFormat:@"Gain = + $ %0.2f ",tempgorl];
                            }
                         //   NSLog(@"Stock gain / Loss %0.2f",tempgorl);
                            [text4UI appendFormat:@"%@ %@\n",nextStock2.symbol,tempgorlStr];
                        }
                    }
                //NSLog(@"%@", text4UI);
                [self.mytextView setText:text4UI];
            }
        }
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (error != nil) {
                NSString *description = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                if (description != nil) {
                    NSString *errorString = description;
                    NSLog(@"Error: %@", errorString);
                }
            }
        }];
        
      }

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mytextView.editable = NO;
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
