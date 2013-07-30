//
//  aszDlViewController.m
//  DTPApp
//
//  Created by alex zaikman on 7/11/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszDlPagerViewController.h"
#import "aszDlViewController.h"
#import "aszDTPApi.h"
#import "aszUtils.h"
#import "aszDls.h"

@implementation aszSeq

@end


@implementation aszLo

@end

@interface aszDlPagerViewController ()<NSURLConnectionDelegate>

-(void)prepLos:(NSArray *)learningObjects;

@property (nonatomic,strong) NSMutableArray *seqList;

-(CDVViewController*)dlWebViewForIndex:(int)index;
-(aszDlViewController*)vcForindex:(int)index Storyboard:(UIStoryboard*)storyboard;


@property (nonatomic,strong) NSMutableArray *cashe;

@end



@implementation aszDlPagerViewController



- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveToPage:) name:@"moveToPage:" object:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    self.seqList = [[NSMutableArray alloc]init];
    
    [aszDTPApi getLessonContent:self.courseId forLesson:self.lessonId Call:^(NSString *msg) {
        
        if(msg){
            self.rawData = [aszUtils jsonToDictionarry: msg];
        }

        if(!self.los)
            self.los = [[NSMutableArray alloc]init];
        
        [self prepLos:[[self.rawData objectForKey:@"data"] objectForKey:@"learningObjects" ]];
        
        
        self.delegate=self;
        self.dataSource=self;
        
        UIViewController *startingViewController = [self viewControllerAtIndex:0 storyboard:self.storyboard];
        
        NSArray *viewControllers = @[startingViewController];
        
        [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];

        [self.parentViewController reloadInputViews];
        
    }];
    

}

-(void)prepLos:(NSArray *)learningObjects
{
    [self.seqList removeAllObjects];
    
    for(int i=0 ; i<[learningObjects count] ;i++){
        
        aszLo *lo = [[aszLo alloc]init];
    
        lo.pedagogicalLoType = [(NSDictionary*)learningObjects[i] valueForKey:@"pedagogicalLoType"];
       
        lo.seqs = [[NSMutableArray alloc]init];
    
        NSArray *rawSeqs = [(NSDictionary*)learningObjects[i] valueForKey:@"sequences"];
        
        for(NSDictionary *rawSeq in rawSeqs){
           
            aszSeq *seq = [[aszSeq alloc]init];
           
            seq.stitle= [rawSeq valueForKey:@"title"] ;
            seq.thumbnailHref= [rawSeq valueForKey:@"thumbnailHref"];
            seq.contentHref= [rawSeq valueForKey:@"contentHref"];
            
            [lo.seqs addObject:seq];
            
            [self.seqList addObject:seq.contentHref];
        }
        
        
        [self.los addObject:lo];
    }
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"popSequences"]){
        
        [segue.destinationViewController performSelector:@selector(setLos:)
    withObject: self.los];
        
        
    }

}


- (aszDlViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    static aszDlViewController *mark;
    
    if(!mark)
        mark = [[aszDlViewController alloc]init];
    
    if(!self.dls){
        self.dls = [[aszDls alloc]initWithHrefs:self.seqList  forCourseId:self.courseId];
        self.size = [self.dls.dataArray count];
    }
    
    
    if(!self.cashe){//first run
        
        self.cashe = [[NSMutableArray alloc]init];
        
        for(int i = 0 ; i<self.size ; i++){
            [self.cashe addObject:mark];
        }
        
        for(int i = 0 ; i<MIN(4 , self.size ); i++){
            
            self.cashe[i] = [self vcForindex:i Storyboard:storyboard];
            
        }
        
    }

    //bounds check
    int inds = index;
    if(inds<0 || index>= self.size) return nil;
    
    
    //get target
    aszDlViewController *ret = self.cashe[index];
    
    if([ret isEqual: mark])//if not in cash
    {
        ret = [self vcForindex:index Storyboard:storyboard];
        self.cashe[index] = ret;
    }
    
    //fill around if nedded
    if( index+1<self.size && [self.cashe[index+1] isEqual: mark]){
         self.cashe[index+1] = [self vcForindex:index+1 Storyboard:storyboard];
    }

    if( index>0 && [self.cashe[inds-1] isEqual:mark]){
        self.cashe[index-1] = [self vcForindex:index-1 Storyboard:storyboard];
    }

    
    //clear around

        for(int i = 0 ; i<inds-1 && index!=0 ; i++){
            
            self.cashe[i]=mark;
            
        }
        for(int i = index+2 ; i<self.size ; i++){
            
               self.cashe[i]=mark;
            
        }
 
    
//   aszDlViewController * ret = [self vcForindex:index Storyboard:storyboard];

    return ret;
    
}

-(aszDlViewController*)vcForindex:(int)index Storyboard:(UIStoryboard*)storyboard{
    

    
        
    if(index>=0 && index<self.size){
        
        
        aszDlViewController *ret= [storyboard instantiateViewControllerWithIdentifier:@"aszDlViewController"];
        
        ret.dlCDVWebView = [self dlWebViewForIndex:index];
        
        [ret.view addSubview:ret.dlCDVWebView.view];
        
        //det page numbers
        ret.pageCount = self.size;
        ret.pageNum = index+1;

        //[ret.view addSubview:ret.dlCDVWebView.view];

        return ret;
    }
    
       
    return nil;
}

-(CDVViewController*)dlWebViewForIndex:(int)index{
    
    if(index<0 || index>=[self.dls.dataArray count]) return nil;
    
 
    if(!self.delegates){
        
               
        NSMutableArray*  tmp = [[NSMutableArray alloc]initWithCapacity:self.size];
        
        
        for(int i=0 ; i<self.size;i++){
            
            aszDlWebViewDelegate * delegate =[[aszDlWebViewDelegate alloc]initWtihData:@[((aszDl*)self.dls.dataArray[i]).iniData   ,  ((aszDl*)self.dls.dataArray[i]).playData  ] ];
            
            [tmp addObject:delegate];
        }
        
        self.delegates = [[NSArray alloc] initWithArray:[tmp copy]];
        
        
    }

    
    CDVViewController *ret = [[CDVViewController alloc] initWithDelegate:self.delegates[index]];
    

    ret.wwwFolderName = @"";
    ret.startPage = @"http://cto.timetoknow.com/cms/player/dl/index2.html";
    
    ret.view.frame = CGRectMake(65,55,300,300);
    
    return ret;
}


- (NSUInteger)indexOfViewController:(aszDlViewController *)viewController
{
    return viewController.pageNum-1;
}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(aszDlViewController *)viewController
{
    
        int index = viewController.pageNum-1;
    
  
        return [self viewControllerAtIndex:(index-1) storyboard:self.storyboard];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(aszDlViewController *)viewController
{
    
    int index = viewController.pageNum-1;
    
    
    return [self viewControllerAtIndex:(index+1) storyboard:self.storyboard];
}


#pragma mark - UIPageViewController delegate methods

-(UIPageViewControllerSpineLocation) pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation{
    
    
        self.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;


}


-(void) moveToPage:(NSNotification*)notification{
    

    NSNumber *indexnum = [notification.userInfo objectForKey:@"index"];
    
    UIViewController *startingViewController = [self viewControllerAtIndex:indexnum.intValue storyboard:self.storyboard];
    
    NSArray *viewControllers = @[startingViewController ];
    
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
}

@end
