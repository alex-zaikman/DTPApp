//
//  ViewClassesController.m
//  DTPApp
//
//  Created by alex zaikman on 7/8/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "ViewClassesController.h"
#import "aszClassesViewCell.h"
#import "aszDTPApi.h"
#import "aszUtils.h"


@interface ViewClassesController ()

@property (nonatomic,strong) NSArray* rawData;

@property (nonatomic,strong) NSNumber *selectedClass;

@property (nonatomic,assign) BOOL loggedin;

@end

@implementation ViewClassesController



-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"updateParent" object:nil];
        _rawData = [[NSArray alloc]init];
        _loggedin = NO;
    }
    return self;
}

-(void) refresh{
    
    [aszDTPApi getStudyClassesCall:^(NSString *msg) {
        
    
       NSString *decoddedJson = [aszUtils decodeFromPercentEscapeString:msg] ;
        
       [aszUtils LOG:decoddedJson];
        
       self.rawData =  [aszUtils jsonToArray: decoddedJson];
        
       [self.collectionView reloadData];
        
        self.loggedin=YES;
    }];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[aszClassesViewCell class] forCellWithReuseIdentifier:@"cell"];


}

-(void)viewDidAppear:(BOOL)animated{
    if(!self.loggedin)
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
    return [self.rawData count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
       
    aszClassesViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    int index = indexPath.row;
    
    NSDictionary *class = self.rawData[index];
    
    NSString *url = (NSString*)[class valueForKey:@"imageURL"] ;
    
    NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:[domain_def copy]] ;
    
    NSURL *bgImageURL = [NSURL URLWithString:[domain stringByAppendingString:url]];
    NSData *bgImageData = [NSData dataWithContentsOfURL:bgImageURL];
    UIImage *img = [UIImage imageWithData:bgImageData];
    
  //  [cell setBackgroundColor: [UIColor colorWithRed:255/255.0f green:237/255.0f blue:108/255.0f alpha:1.0f]];
    
    [cell setBackgroundView:[[UIImageView alloc]initWithImage:img]];
    
    NSString *className = (NSString*)[class valueForKey:@"name"] ;
    
    cell.lable.text = className;

    
    NSNumber *cid = (NSNumber*)[class valueForKey:@"id"];
    
    cell.tag =[cid integerValue] ;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

       aszClassesViewCell *currentCell = (aszClassesViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        
       self.selectedClass = @(currentCell.tag);
    
       [self performSegueWithIdentifier:@"overview" sender:self];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"overview"]){
        
        [segue.destinationViewController performSelector:@selector(setClassId:)
                                              withObject: self.selectedClass];
        
        
        
        
    }

       
}







@end


















