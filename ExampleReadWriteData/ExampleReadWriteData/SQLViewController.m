//
//  SQLViewController.m
//  ExampleReadWriteData
//
//  Created by Júlio Menezes Noronha on 29/05/14.
//  Copyright (c) 2014 Júlio César Menezes Noronha. All rights reserved.
//

#import "SQLViewController.h"

@interface SQLViewController ()

@end

@implementation SQLViewController
@synthesize  txtAutor,txtTitulo,txtPreco,lbStatus;

-(IBAction)save:(id)sender
{
    sqlite3_stmt *sta_cursor;
    
    const char *dbpath = [_databasePath UTF8String];
    
    if(sqlite3_open(dbpath, &_livros) == SQLITE_OK){
        
        NSString *insertSQL = [NSString stringWithFormat:@"insert into books(autor,titulo,preco) values(\"%@\",\"%@\",%@)",txtAutor.text,txtTitulo.text,txtPreco.text];
        
        const char *insert_sta = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(_livros, insert_sta, -1, &sta_cursor, NULL);
        
        if(sqlite3_step(sta_cursor) == SQLITE_DONE){
            
            lbStatus.text = @"Livro adicionado";
            txtAutor.text = nil;
            txtPreco.text = nil;
            txtTitulo.text = nil;
            
        }else{
            lbStatus.text = @"Falha ao adicionar livro";
        }
        sqlite3_finalize(sta_cursor);
        sqlite3_close(_livros);
    }
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(IBAction)find:(id)sender
{
    NSLog(@"chamou");
    sqlite3_stmt *sta_cursor;
    
    const char *dbpath = [_databasePath UTF8String];
    
    if(sqlite3_open(dbpath, &_livros) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"select titulo, preco from books where autor = \"%@\"",txtAutor.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if(sqlite3_prepare_v2(_livros, query_stmt, -1, &sta_cursor, NULL) == SQLITE_OK){
            if(sqlite3_step(sta_cursor) == SQLITE_ROW){
                NSString *titulo = [[NSString alloc]initWithUTF8String: (const char*) sqlite3_column_text(sta_cursor, 0)];
                
                NSString *preco = [[NSString alloc]initWithUTF8String: (const char*) sqlite3_column_text(sta_cursor, 1)];
                
                txtTitulo.text = titulo;
                txtPreco.text = preco;
                lbStatus.text = @"Livro encontrado";
                
                titulo = nil;
                preco = nil;
                
            }else{
                txtTitulo.text = nil;
                txtPreco.text = nil;
                lbStatus.text = @"Livro nao encontrado";
            }
            sqlite3_finalize(sta_cursor);
        }
        sqlite3_close(_livros);
    }
}

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
    [super viewDidLoad];
    
    NSString *booksDir = @"/tmp/";
    
    _databasePath = [[NSString alloc]initWithString:[booksDir stringByAppendingPathComponent:@"books.db"]];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if([fileMgr fileExistsAtPath:_databasePath] == NO){
        
        const char *dbpath = [_databasePath UTF8String];
        
        if(sqlite3_open(dbpath,&_livros) == SQLITE_OK){
            char *errMsg;
            
            const char *sql_stmt = "CREATE TABLE books (id integer primary key autoincrement, autor text, titulo text, preco integer)";
            
            if(sqlite3_exec(_livros, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
                lbStatus.text = @"Erro ao criar tabela";
            }
            sqlite3_close(_livros);
        }else{
            lbStatus.text = @"Erro ao abrir/criar banco de dados";
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    txtAutor = nil;
    txtPreco = nil;
    txtTitulo = nil;
    lbStatus = nil;
}

@end
