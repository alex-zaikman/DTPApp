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


@interface aszOverViewViewController ()

@property (nonatomic,strong) aszRowNode *root;

@end

@implementation aszOverViewViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource= self;
    
    self.root = [[aszRowNode alloc]initWithValue:@"root"];
    
    [self.root addChild:[[aszRowNode alloc]initWithValue:@"a"]];
    [self.root addChild:[[aszRowNode alloc]initWithValue:@"b"]];
    [self.root addChild:[[aszRowNode alloc]initWithValue:@"c"]];
    [self.root addChild:[[aszRowNode alloc]initWithValue:@"d"]];
    
    NSArray *levelOne = [self.root getChildren];
    
    for (aszRowNode *node in levelOne){
        
        aszRowNode *tmpnode =[[aszRowNode alloc]initWithValue:[node.value stringByAppendingString:@"1"]];
        [tmpnode addChild:[[aszRowNode alloc]initWithValue:[node.value stringByAppendingString:@"1.1"]]];
        [tmpnode addChild:[[aszRowNode alloc]initWithValue:[node.value stringByAppendingString:@"1.2"]]];
        [tmpnode addChild:[[aszRowNode alloc]initWithValue:[node.value stringByAppendingString:@"1.3"]]];
        [node addChild:tmpnode];
        
        [node addChild:[[aszRowNode alloc]initWithValue:[node.value stringByAppendingString:@"2"]]];
        [node addChild:[[aszRowNode alloc]initWithValue:[node.value stringByAppendingString:@"3"]]];
        [node addChild:[[aszRowNode alloc]initWithValue:[node.value stringByAppendingString:@"4"]]];
        
    }
    
 //   [self.root toggleAllTo:YES];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = indexPath.row;
    aszRowNode *node = [[self.root getVisibleSubTree] objectAtIndex:index];
  //  [node togale];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Click"
                                                    message:node.value
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    

    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
