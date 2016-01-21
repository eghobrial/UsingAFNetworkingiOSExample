//
//  ViewController.h
//  Final
//
//  Created by Eman Ghobrial on 11/11/15.
//  Copyright © 2015 Eman Ghobrial. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property NSFileManager *fileManager;
@property IBOutlet UITextView* mytextView;
@property IBOutlet UIButton* goButton;
@property NSMutableArray* myStocks;
-(NSString*)loadFileFromApp :(NSString*)fileName withExtension:(NSString*)fileExt;
-(NSString*) constructURL: (NSMutableString*)symbols;

-(IBAction)goButtonPressed:(id)sender;
@end

