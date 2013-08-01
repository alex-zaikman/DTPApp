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
        
        
        
        
        
        aszDlViewController *startingViewController = [self viewControllerAtIndex:0 storyboard:self.storyboard];
        
     //   aszDlViewController *next = [self viewControllerAtIndex:1 storyboard:self.storyboard];
       
     //   UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        
        NSArray *viewControllers;
        
       
     //   if (UIInterfaceOrientationIsPortrait(orientation)) {
           
            viewControllers = @[startingViewController];
        
     //   }else{
            
    //        viewControllers = @[startingViewController,next];
///
     //   }
     
        
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
        
        for(int i = 0 ; i<MIN(6 , self.size ); i++){
            
            self.cashe[i] = [self vcForindex:i Storyboard:storyboard];
            
        }
        
    }

    //bounds check
    int inds = index;
    if(inds<0 || index>= self.size){
    
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        
        if (UIInterfaceOrientationIsLandscape(orientation) &&   index == self.size) {
        
            aszDlViewController *ret= [storyboard instantiateViewControllerWithIdentifier:@"aszDlViewController"];
            

            //det page numbers
            ret.pageCount = self.size;
            ret.pageNum = index+2;
            
            return ret;
            
        }
        else return nil;
    
    
    }
    
    
    
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
    if( index+2<self.size && [self.cashe[index+2] isEqual: mark]){
        self.cashe[index+2] = [self vcForindex:index+2 Storyboard:storyboard];
    }
    
    if( index>1 && [self.cashe[inds-2] isEqual:mark]){
        self.cashe[index-2] = [self vcForindex:index-2 Storyboard:storyboard];
    }

    
    //clear around

        for(int i = 0 ; i<inds-3 && index!=0 ; i++){
            
            self.cashe[i]=mark;
            
        }
        for(int i = index+4 ; i<self.size ; i++){
            
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
    
    
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        // In portrait orientation: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
        UIViewController *currentViewController = pageViewController.viewControllers[0];
        NSArray *viewControllers = @[currentViewController];
        [pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        pageViewController.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;
    }
    
    // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
    aszDlViewController *currentViewController = pageViewController.viewControllers[0];
    NSArray *viewControllers = nil;
    
    NSUInteger indexOfCurrentViewController = [self indexOfViewController:currentViewController];
    if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
        
        if(indexOfCurrentViewController == (self.size - 1)){
        
            aszDlViewController *ret= [self.storyboard instantiateViewControllerWithIdentifier:@"aszDlViewController"];
            
            
            //det page numbers
            ret.pageCount = self.size;
            ret.pageNum = indexOfCurrentViewController+2;
            
            viewControllers = @[currentViewController, ret];
            
        
        }else{
        UIViewController *nextViewController = [self pageViewController:pageViewController viewControllerAfterViewController:currentViewController];
        viewControllers = @[currentViewController, nextViewController];
        }
        
        
    } else {
        UIViewController *previousViewController = [self pageViewController:pageViewController viewControllerBeforeViewController:currentViewController];
        viewControllers = @[previousViewController, currentViewController];
    }
    [pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    
    return UIPageViewControllerSpineLocationMid;


}


-(void) moveToPage:(NSNotification*)notification{
    

    NSNumber *indexnum = [notification.userInfo objectForKey:@"index"];
    
       
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;

    
    
    
    
    if (UIInterfaceOrientationIsPortrait(orientation)) {

        UIViewController *startingViewController = [self viewControllerAtIndex:indexnum.intValue storyboard:self.storyboard];
        
        NSArray *viewControllers = @[startingViewController ];
        
        [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];

        
    } else if (indexnum == 0 || indexnum.intValue % 2 == 0) {
        
        
        if(indexnum.intValue == (self.size - 1)){

            UIViewController *startingViewController = [self viewControllerAtIndex:indexnum.intValue storyboard:self.storyboard];
            
            
            aszDlViewController *ret= [self.storyboard instantiateViewControllerWithIdentifier:@"aszDlViewController"];
            
            
            //det page numbers
            ret.pageCount = self.size;
            ret.pageNum = indexnum.intValue+2;
            
            NSArray *viewControllers = @[startingViewController ,ret];
            
            
            
            [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
            
        }else{
            
            

            UIViewController *startingViewController = [self viewControllerAtIndex:indexnum.intValue storyboard:self.storyboard];
            
            
            NSArray *viewControllers = @[startingViewController ,[self viewControllerAtIndex:indexnum.intValue+1 storyboard:self.storyboard]];
            
            
            [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
            
        }
    
    } else {
        
        UIViewController *startingViewController = [self viewControllerAtIndex:indexnum.intValue storyboard:self.storyboard];
        
        NSArray *viewControllers = @[[self viewControllerAtIndex:indexnum.intValue-1 storyboard:self.storyboard] ,startingViewController ];
        
        [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
        
    }
    
    
}

@end
