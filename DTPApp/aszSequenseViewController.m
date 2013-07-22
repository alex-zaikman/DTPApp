//
//  aszSequenseViewController.m
//  DTPApp
//
//  Created by alex zaikman on 7/21/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszSequenseViewController.h"
#import "aszSequencesCell.h"
#import "aszUtils.h"


@interface aszSequenseViewController ()

@end

@implementation aszSequenseViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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

    return [self.los count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    aszLo* lo = (aszLo*)self.los[section];
    
    return [lo.seqs count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    aszSequencesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    int section = indexPath.section;
    int row = indexPath.row;
    
    aszLo *lo = self.los[section];
    NSArray *seqs = lo.seqs;
    aszSeq* seq = seqs[row];
    
    cell.textLabel.text = seq.stitle;
    
    
    NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:[domain_def copy]];
    NSString *url =   [domain stringByAppendingString:seq.thumbnailHref];
    NSURL *bgImageURL = [NSURL URLWithString:url];
    NSData *bgImageData = [NSData dataWithContentsOfURL:bgImageURL];
    
    cell.imageView.image =     [ [self class]  imageWithImage:[UIImage imageWithData:bgImageData] scaledToSize:CGSizeMake(300,200)] ;
    
    int tillnow=0;
    
    for(int i = 0 ; i<section ;i++)
        tillnow+= [self tableView:tableView numberOfRowsInSection:i];
    
    
    
    cell.tag = row + tillnow;
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   
    aszLo* lo = self.los[section];
    
    return lo.pedagogicalLoType;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

       aszSequencesCell *myCell = (aszSequencesCell*) [tableView cellForRowAtIndexPath:indexPath];
    
       NSNumber * index =@(myCell.tag);
    
    NSDictionary *dic = @{ @"index" : index} ;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"moveToPage:" object:self userInfo:dic];
    
    
    
      // [[NSNotificationCenter defaultCenter] postNotificationName:@"moveToPage:" object:index];
            
        
        
  
    
    
    
    
    
    
}


+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2.0) {
            UIGraphicsBeginImageContextWithOptions(newSize, YES, 2.0);
        } else {
            UIGraphicsBeginImageContext(newSize);
        }
    } else {
        UIGraphicsBeginImageContext(newSize);
    }
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
