//
//  aszOverViewViewController.m
//  DTPApp
//
//  Created by alex zaikman on 7/9/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszOverViewViewController.h"
#import "aszRowNode.h"
#import "aszOverViewCell.h"
#import "aszT2KApi.h"
#import "aszUtils.h"
#import "CDVWebViewDelegate.h"
#import "CDVViewController.h"


@interface aszOverViewViewController ()

@property (nonatomic,strong) aszRowNode *root;
@property (nonatomic,strong) NSDictionary *rawData;

-(void)initData:(NSDictionary*)raw;


@property (nonatomic,weak) aszRowNode *selectedNode;
@property (nonatomic,strong) NSString *courseId;

@end

@implementation aszOverViewViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
       
        _classId = [[NSNumber alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [aszT2KApi getCourse: [self.classId stringValue ] OnSuccess:^(NSString *msg) {
    
      
       
        if(msg){
            self.rawData = [aszUtils jsonToDictionarry: msg];
            [self initData:self.rawData];
            [self.tableView reloadData];
        }
        
    }  OnFaliure:^(NSString *error) {
        
    }];
    
    
    

    
    self.tableView.delegate = self;
    self.tableView.dataSource= self;
    
    
       
 //   [self.root toggleAllTo:YES];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)initData:(NSDictionary*)raw
{
    
    NSDictionary *data = [raw objectForKey:@"data"];
    [self.navigationItem setTitle:[data valueForKey:@"title"]];
    
    NSDictionary *toc = [data objectForKey:@"toc"];
    
    self.courseId = [raw objectForKey:@"id"];
    
    
    self.root = [[aszRowNode alloc]initWithValue:[toc valueForKey:@"title"]];
        
    self.root.overview = [toc valueForKey:@"overview"];
    
    self.root.cid = [toc valueForKey:@"cid"] ;
    
    [self recPopulate:self.root withData:toc];


}

-(void)recPopulate:(aszRowNode*)root withData:(NSDictionary*) data
{
    NSArray *tocItems = [data objectForKey:@"tocItems"];
    
    for (NSDictionary * tocitem in tocItems){
        
        aszRowNode *node = [[aszRowNode alloc]initWithValue:[tocitem valueForKey:@"title"]];
        
        node.overview = [tocitem valueForKey:@"overview"];
        
        node.cid = [tocitem valueForKey:@"cid"] ;
        
        [root addChild:node];
        
        [self recPopulate:node withData:tocitem];
        
    }
    
    NSArray *items = [data objectForKey:@"items"];
    
    for (NSDictionary * item in items){
        
        aszRowNode *node = [[aszRowNode alloc]initWithValue:[item valueForKey:@"title"]];
        
        node.overview = [item valueForKey:@"description"];
        
        node.cid = [item valueForKey:@"cid"] ;
        
        [root addChild:node];

        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.root visibleCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"tableCell";
    aszOverViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    
    NSArray *nodes = [self.root getVisibleSubTree];
    
    int index = indexPath.row;
    
    aszRowNode* node = (aszRowNode*)nodes[index];
    
    cell.value = node.value;
    cell.level = [node level];
    cell.expanded = [node isExpandded];
    cell.selfNode=node;
    
    [cell appplyState];
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = indexPath.row;
    aszRowNode *node = [[self.root getVisibleSubTree] objectAtIndex:index];

    self.selectedNode = node;
    
    if(![node isLeaf]){
         [self performSegueWithIdentifier:@"overviewDescription" sender:self];
    }else{
        
        
        [self performSegueWithIdentifier:@"dl" sender:self];
        
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"overviewDescription"]){
        
        
        [segue.destinationViewController performSelector:@selector(setT:)
                                              withObject: self.selectedNode.value];
        
        
        [segue.destinationViewController performSelector:@selector(setO:)
                                              withObject:  self.selectedNode.overview];

        
    }
    else if([[segue identifier] isEqualToString:@"dl"]){
        
        
        [segue.destinationViewController performSelector:@selector(setCourseId:)
                                              withObject: self.courseId];
        
        
        [segue.destinationViewController performSelector:@selector(setLessonId:)
                                              withObject:  self.selectedNode.cid];
        
        
    }
}



@end
