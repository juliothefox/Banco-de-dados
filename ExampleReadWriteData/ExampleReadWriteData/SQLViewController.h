//
//  SQLViewController.h
//  ExampleReadWriteData
//
//  Created by Júlio Menezes Noronha on 29/05/14.
//  Copyright (c) 2014 Júlio César Menezes Noronha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface SQLViewController : UIViewController

@property IBOutlet UITextField *txtAutor;
@property IBOutlet UITextField *txtTitulo;
@property IBOutlet UITextField *txtPreco;
@property IBOutlet UILabel*lbStatus;
@property NSString *databasePath;

@property sqlite3 *livros;

@end
