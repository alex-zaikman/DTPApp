//
//  ViewClassesController.m
//  DTPApp
//
//  Created by alex zaikman on 7/8/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "ViewClassesController.h"
#import "aszClassesViewCell.h"
#import "aszWebBrain.h"

@interface ViewClassesController ()

@end

@implementation ViewClassesController



-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"updateParent" object:nil];
    }
    return self;
}

-(void) refresh{
    #warning not implemented
    [self.view setNeedsDisplay];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[aszClassesViewCell class] forCellWithReuseIdentifier:@"cell"];


}

-(void)viewDidAppear:(BOOL)animated{
        [self login:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    [self performSegueWithIdentifier:@"login" sender:self];
}


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    #warning not implemented
    
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    #warning not implemented
    
    aszClassesViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *url;//= (NSString*)[(NSDictionary*)[(NSArray*)[self.data valueForKey:@"classes"] objectAtIndex:indexPath.item] valueForKey:@"classImageUrl"];
    
   // url = [[[NSUserDefaults standardUserDefaults] stringForKey:@"domain_preference"]  stringByAppendingString:url];
    
    
    
    NSURL *bgImageURL = [NSURL URLWithString:url];
    NSData *bgImageData = [NSData dataWithContentsOfURL:bgImageURL];
    UIImage *img = [UIImage imageWithData:bgImageData];
    
    [cell setBackgroundColor: [UIColor colorWithRed:255/255.0f green:237/255.0f blue:108/255.0f alpha:1.0f]];
    
    
    [cell setBackgroundView:[[UIImageView alloc]initWithImage:img]];
    
    //NSString *className = (NSString*)[(NSDictionary*)[(NSArray*)[self.data valueForKey:@"classes"] objectAtIndex:indexPath.item] valueForKey:@"className"];
    
   // cell.lable.text = className;
    
//    NSArray *classes = (NSArray*)[self.data valueForKey:@"classes"];
  //  NSUInteger index =  [indexPath indexAtPosition:[indexPath length]-1];
  //  NSDictionary *class = [classes objectAtIndex:index];
 //   NSNumber *cid = [class valueForKey:@"classId"];
    
    
 //   cell.tag =[cid integerValue] ;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
       #warning not implemented
  
       aszClassesViewCell *currentCell = [collectionView cellForItemAtIndexPath:indexPath];
    

    
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
       #warning not implemented

       
}







@end


















