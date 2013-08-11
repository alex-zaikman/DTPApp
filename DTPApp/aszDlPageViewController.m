//
//  aszDlPageViewController.m
//  DTPApp
//
//  Created by alex zaikman on 8/7/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszDlPageViewController.h"
#import "aszT2KApi.h"
#import "aszNewDlViewController.h"
#import "aszUtils.h"
//#import "aszDlPool.h"
#import "aszDlBridge.h"

#define POOL_SIZE 3

@implementation naszSeq

@end


@implementation naszLo

@end


@interface aszDlPageViewController ()

@property (nonatomic,strong) NSDictionary *rawData;
@property (nonatomic,strong) NSMutableArray *los;
@property (nonatomic,strong) NSMutableArray *seqList;
//@property (nonatomic,strong) aszDlPool *pool;
@property (nonatomic,strong) NSString *seqInitData;
@property (nonatomic,assign) int currentViewIndex;
@property (nonatomic,strong) aszDlBridge *tmpptr;

-(void)prepLos:(NSArray *)learningObjects;

- (aszNewDlViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;

@end

@implementation aszDlPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)prepLos:(NSArray *)learningObjects
{
    if(!self.seqList)
        self.seqList = [[NSMutableArray alloc]init];
        
        
    [self.seqList removeAllObjects];
    
    for(int i=0 ; i<[learningObjects count] ;i++){
        
        naszLo *lo = [[naszLo alloc]init];
        
        lo.pedagogicalLoType = [(NSDictionary*)learningObjects[i] valueForKey:@"pedagogicalLoType"];
        
        lo.seqs = [[NSMutableArray alloc]init];
        
        NSArray *rawSeqs = [(NSDictionary*)learningObjects[i] valueForKey:@"sequences"];
        
        for(NSDictionary *rawSeq in rawSeqs){
            
            naszSeq *seq = [[naszSeq alloc]init];
            
            seq.stitle= [rawSeq valueForKey:@"title"] ;
            seq.thumbnailHref= [rawSeq valueForKey:@"thumbnailHref"];
            seq.contentHref= [rawSeq valueForKey:@"contentHref"];
            
            [lo.seqs addObject:seq];
            
            [self.seqList addObject:seq.contentHref];
        }
        
        
        [self.los addObject:lo];
    }
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    //===========prep init data must be done properly in the final svertion=================================================
    
    //media url
    NSMutableString *mediaUrl=[[NSMutableString alloc]init];
    
    [mediaUrl appendString: @"\"/cms/courses/"];
    
    [mediaUrl appendString: self.courseId];
    
    [mediaUrl appendString: @"\""];
    
    //init data
    NSMutableString *initData=[[NSMutableString alloc]init];
    
    [initData appendString:@"{ width: 1024, height: 600, scale: 1, basePaths: { player:"];
    
    //this.playerPath
    [initData appendString: @"\"http://cto.timetoknow.com/cms/player/dl\""];
    
    
    [initData appendString: @", media:"];
    
    [initData appendString: mediaUrl];
    
    [initData appendString: @"}, complay:true, localeName:\"en_US\",   apiVersion: '1.0',  loId: 'inst_s', isLoggingEnabled: true, userInfo : { role: '"];
    
    [initData appendString:@"student"];//[initData appendString:role];
    
    [initData appendString:  @"' }   }"];
 
    self.seqInitData = initData ;
    
    
    //=============================================================================================================================
    
    __block aszDlPageViewController *this=self;
    [aszT2KApi getLessonContent:self.courseId forLesson:self.lessonId OnSuccess:^(NSString *msg) {
        
        if(msg){
            this.rawData = [aszUtils jsonToDictionarry: msg];
        }
        
        if(!this.los)
            this.los = [[NSMutableArray alloc]init];
        
        [this prepLos:[[this.rawData objectForKey:@"data"] objectForKey:@"learningObjects" ]];
        
        
        this.delegate=this;
        this.dataSource=this;
        
        //==============prep the pool ===============================================================================================
        
     //   this.pool = [[aszDlPool alloc]initWithPoolSize:POOL_SIZE useInitData:this.seqInitData onLoad:^{
            
            
            //==================get the first page=======================================================================================
            
            aszNewDlViewController *startingViewController = [this viewControllerAtIndex:0 storyboard:this.storyboard];
            
            NSArray *viewControllers;
            
            viewControllers = @[startingViewController];
            
            
            [this setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
            
            [this.parentViewController reloadInputViews];
            
            
     //   }];
        
        

        
    } OnFaliure:^(NSString *err) {
        
    }];
    

}



- (aszNewDlViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    
    
    int inds = index;
    if(inds<0 || index>= [self.seqList count]){
        return nil;
    }
    
//    NSArray *indexs;
//    if(index == 0 ){
//        
//        indexs = @[@0,@1,@2];
//        
//    }else if (index == [self.seqList count]-1){
//        
//        indexs = @[@([self.seqList count]-3),@([self.seqList count]-2),@([self.seqList count]-1)];
//    }
//    else{
//        indexs = @[@(index-1),@(index),@(index+1)];
//    }
//
//    
//    NSMutableArray *sindexs = [[NSMutableArray alloc]init];
//    for(NSNumber *ind in indexs){
//        [sindexs addObject:[aszUtils intToString:ind.intValue]];
//    }
//    
//    NSMutableArray *playdata = [[NSMutableArray alloc]init];
//     for(NSString *ref in self.seqList){
//         
//         NSString  *jsonUrl = [@"http://cto.timetoknow.com"  stringByAppendingString:ref ];
//         
//         NSURLRequest *reqPlayData = [aszUtils requestWithUrl:jsonUrl usingMethod:@"GET" withUrlParams:nil andBodyData:nil];
//         
//         NSURLResponse *response = nil;
//         NSError *error = nil;
//         
//         NSData *responseData = [NSURLConnection sendSynchronousRequest:reqPlayData returningResponse:&response error:&error];
//         
//         [playdata addObject: [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]];
//         
//     }
//    
//    
//    [self.pool playWithDataArray:playdata forKeyArray:sindexs];
//    
    
    //get the right view
    
    NSString  *jsonUrl = [@"http://cto.timetoknow.com"  stringByAppendingString:self.seqList[index] ];
    
             NSURLRequest *reqPlayData = [aszUtils requestWithUrl:jsonUrl usingMethod:@"GET" withUrlParams:nil andBodyData:nil];
    
             NSURLResponse *response = nil;
             NSError *error = nil;
    
            NSData *responseData = [NSURLConnection sendSynchronousRequest:reqPlayData returningResponse:&response error:&error];
    
           NSString *playdata = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];


    
    
  //  self.tmpptr =  [[aszDlBridge alloc]initInit:self.seqInitData andPlay:playdata  ];// [self.pool getDlForKey:[aszUtils intToString:index]];];
    
//[self.tmpptr releaseLock];
//    self.tmpptr =nil;
    
    aszNewDlViewController *ret = [storyboard instantiateViewControllerWithIdentifier:@"aszNewDlViewController"];

    ret.indexCid = index;
    self.currentViewIndex=index;
    
    
    self.tmpptr = [[aszDlBridge alloc]initInit:self.seqInitData andPlay:playdata  ];
    
    CGRect supRec = ret.view.frame;
    
    static const int margin =55;

    [self.tmpptr setFrame:CGRectMake(supRec.origin.x+margin ,supRec.origin.y+margin ,supRec.size.width-(2*margin) ,supRec.size.height-(2*margin))];
    
    [ret.view addSubview:[self.tmpptr getCDVView]];
    
    return ret;
    
}

#pragma mark UIPageViewControllerDataSource
    
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(aszNewDlViewController *)viewController
    {
        int index = viewController.indexCid+1;

        return [self viewControllerAtIndex:(index) storyboard:self.storyboard];
    }

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(aszNewDlViewController *)viewController
    {
        int index = viewController.indexCid-1;

        return [self viewControllerAtIndex:(index) storyboard:self.storyboard];
    }


//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(6_0){
//    return [self.seqList count];
//}// The number of items reflected in the page indicator.
//
//
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(6_0){
//    return self.currentViewIndex+1;
//}// The selected item reflected in the page indicator.


#pragma mark UIPageViewControllerDelegate

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation{
    
    UIViewController *currentViewController = pageViewController.viewControllers[0];
    NSArray *viewControllers = @[currentViewController];
    [pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
    
}

- (NSUInteger)indexOfViewController:(aszNewDlViewController *)viewController
{
    return self.currentViewIndex;
}



@end
    
