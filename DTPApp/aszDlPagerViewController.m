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
    
    [aszDTPApi getLessonContent:self.courseId forLesson: self.lessonId Call:^(NSString *msg) {
        
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
    
    aszDlViewController *ret = nil;
    
   
    if(!self.dls){
        self.dls = [[aszDls alloc]initWithHrefs:self.seqList  forCourseId:self.courseId];
    }
    
        if(!self.delegates){
        self.delegates = [[NSMutableArray alloc]initWithCapacity:[self.dls.dataArray count]];
        
        for(int i=0 ; i<[self.dls.dataArray count];i++){
            
            aszDlWebViewDelegate * delegate =[[aszDlWebViewDelegate alloc]initWtihData:@[((aszDl*)self.dls.dataArray[i]).iniData   ,  ((aszDl*)self.dls.dataArray[i]).playData  ] ];
            
            [self.delegates addObject:delegate];
        }
        
        
        
    }
    
    
    if(index>=0 && index<[self.dls.dataArray count]){
    
    ret= [storyboard instantiateViewControllerWithIdentifier:@"aszDlViewController"];
        
    ret.dlWebView = [self dlWebViewForIndex:index];
     
    //det page numbers
    ret.pageCount = [self.dls.dataArray count];
    ret.pageNum = index+1;
    
        
        
    }
    return ret;
    
}

-(UIWebView*)dlWebViewForIndex:(int)index{
    
    static NSString *urlAddress = @"http://cto.timetoknow.com/cms/player/dl/index2.html";
    static NSURLRequest *request2;
    
    if(!request2)
        request2 = [aszUtils requestWithUrl:urlAddress usingMethod:@"GET" withUrlParams:nil andBodyData:nil];
    

    
    if(!self.dlWebviews){//first run
        
        self.dlWebviews=[[NSMutableArray alloc]initWithCapacity:[self.dls.dataArray count]];
        
        for(int i=0 ; i<[self.dls.dataArray count] ;i++){
            [self.dlWebviews addObject:[NSNull null]];
        }
        
        for(int i=index ; i<3+index ;i++){
            self.dlWebviews[i] = [[UIWebView alloc]init];
            
            ((UIWebView*)self.dlWebviews[i]).delegate = self.delegates[i];
            
            [((UIWebView*)self.dlWebviews[i]) loadRequest:request2];
        }

    }
    
    //any way do:
    UIWebView *ret = ((UIWebView*)self.dlWebviews[index]);
    
    if(ret == [NSNull null]){
        
        ret = [[UIWebView alloc]init];
        
        ret.delegate = self.delegates[index];
        
        [ret loadRequest:request2];

        self.dlWebviews[index] = ret;
    }
    
    if( index+1>=0 && index+1<[self.dlWebviews count]   &&   self.dlWebviews[index+1] == [NSNull null]){
    
        UIWebView *tmp = [[UIWebView alloc]init];
        
        tmp.delegate = self.delegates[index+1];
        
        [tmp loadRequest:request2];
        
        self.dlWebviews[index+1] = tmp;
    }
    if( index+2>=0 && index+2<[self.dlWebviews count]   &&   self.dlWebviews[index+2] == [NSNull null]){
        
        UIWebView *tmp = [[UIWebView alloc]init];
        
        tmp.delegate = self.delegates[index+2];
        
        [tmp loadRequest:request2];
        
        self.dlWebviews[index+2] = tmp;
    }
    if( index-1>=0 && index-1<[self.dlWebviews count]   &&   self.dlWebviews[index-1] == [NSNull null]){
        
        UIWebView *tmp = [[UIWebView alloc]init];
        
        tmp.delegate = self.delegates[index-1];
        
        [tmp loadRequest:request2];
        
        self.dlWebviews[index-1] = tmp;
    }
    if( index-2>=0 && index-2<[self.dlWebviews count]   &&   self.dlWebviews[index-2] == [NSNull null]){
        
        UIWebView *tmp = [[UIWebView alloc]init];
        
        tmp.delegate = self.delegates[index-2];
        
        [tmp loadRequest:request2];
        
        self.dlWebviews[index-2] = tmp;
    }
    
    for(int i = index+3 ; i<[self.dlWebviews count] ;i++){
        self.dlWebviews[i]=[NSNull null];
    }
    for(int i = index-3 ; i>=0 ;i--){
        self.dlWebviews[i]=[NSNull null];
    }
    
    return ret;
}


- (NSUInteger)indexOfViewController:(aszDlViewController *)viewController
{
    return viewController.pageNum;
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
    
    //    UIViewController *currentViewController = self.viewControllers[0];
    //    NSArray *viewControllers = @[currentViewController];
    //    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    self.doubleSided = NO;
    
    return UIPageViewControllerSpineLocationMin;
    
}


-(void) moveToPage:(NSNotification*)notification{
    
    
    NSNumber *indexnum = [notification.userInfo objectForKey:@"index"];
    
    UIViewController *startingViewController = [self viewControllerAtIndex:indexnum.intValue storyboard:self.storyboard];
    
    NSArray *viewControllers = @[startingViewController];
    
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];

}

@end
