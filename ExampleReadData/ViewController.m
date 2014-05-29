//
//  ViewController.m
//  ExampleReadData
//
//  Created by Júlio Menezes Noronha on 29/05/14.
//  Copyright (c) 2014 Júlio César Menezes Noronha. All rights reserved.
//

#import "ViewController.h"
#import "sqlite3.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    sqlite3 *myDataBase;
    
    NSString *path = @"/tmp/database.db";
    
    const char *dbpath = [path UTF8String];
    
    if(sqlite3_open(dbpath, &myDataBase) == SQLITE_OK){
        NSLog(@"Open successfully");
    }else{
        NSInteger i = sqlite3_errcode(myDataBase);
        
        NSLog(@"Error: %d",i);
    }
    
    sqlite3_stmt *sta;
    
    NSString *q = @"select col1, col2 from mytable";
    
    const char *query_string = [q UTF8String];
    
    if(sqlite3_prepare_v2(myDataBase, query_string, -1, &sta, NULL) == SQLITE_OK){
        NSLog(@"SQL OK");
    }else{
        NSInteger j = sqlite3_errcode(myDataBase);
        
        NSLog(@"Error: %d",j);
    }
    
    while (sqlite3_step(sta) == SQLITE_ROW) {
        NSInteger c1 = sqlite3_column_int(sta, 0);
        
        NSString *c2 = [[NSString alloc]initWithUTF8String: (const char*)sqlite3_column_text(sta, 1)];
        
        NSLog(@"Coluna 1 = %d\nColuna 2 = %@",c1,c2);
    }
    
    sqlite3_finalize(sta);
    
    sqlite3_close(myDataBase);
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
