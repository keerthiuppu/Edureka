//
//  UIThumbView.m
//  Flipkart
//
//  Created by Shruti Singhal on 08/04/13.
//  Copyright (c) 2013 Kellton Tech. All rights reserved.
//

#import "UIThumbView.h"
#import "Constants.h"
#define ServerImageUrl  @"ServerUrl"
#define LocalImageUrl   @"LocalUrl"
#define ImageUrlMap     @"Local-Server image map"


#define Grop_List   @"Group_Listing"
#define Category_List  @"Category_Listing"
#define Deal_List  @"Deal_Listing"
#define banner_List   @"banner_Listing"
#define SIZE_Limit 2
#define DOC_DIR [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


@interface UIThumbView()
- (void)didTap:(UIButton*)sender;
@end

@implementation UIThumbView
@synthesize uniqueIdentifire;
@synthesize tapDelegate;
@synthesize imageType;
@synthesize imageUrlString;
@synthesize defaultImage;
@synthesize activity;
@synthesize indexPath;
@synthesize loadingImage;
static NSMutableSet* allActiveRequsetUrl;
static NSMutableDictionary *allActiveRequestURLAndObjects;

+ (void)clearBuffer {
    //NSString* docDirectory = DOC_DIR;
	NSString* docDirectory = [DOC_DIR stringByAppendingPathComponent:BaseBufferFolder];
	NSFileManager* fm = [NSFileManager defaultManager];
	if ([fm fileExistsAtPath:docDirectory])
	{
		[fm removeItemAtPath:docDirectory error:nil];
	}
    
    docDirectory = [DOC_DIR stringByAppendingPathComponent:BaseBufferFolder_grop];
	if ([fm fileExistsAtPath:docDirectory])
	{
		[fm removeItemAtPath:docDirectory error:nil];
	}
    docDirectory = [DOC_DIR stringByAppendingPathComponent:BaseBufferFolder_category];
	if ([fm fileExistsAtPath:docDirectory])
	{
		[fm removeItemAtPath:docDirectory error:nil];
	}
    docDirectory = [DOC_DIR stringByAppendingPathComponent:NoTypeFolder];
	if ([fm fileExistsAtPath:docDirectory])
	{
		[fm removeItemAtPath:docDirectory error:nil];
	}
    
    docDirectory = [DOC_DIR stringByAppendingPathComponent:BaseBufferFolder_Deal];
	if ([fm fileExistsAtPath:docDirectory])
	{
		[fm removeItemAtPath:docDirectory error:nil];
	}
    
    docDirectory = [DOC_DIR stringByAppendingPathComponent:BaseBufferFolder_Banner];
	if ([fm fileExistsAtPath:docDirectory])
	{
		[fm removeItemAtPath:docDirectory error:nil];
	}
}

-(void)clearBufferWithSize
{
    if([self documentDirectorySize]>=SIZE_Limit)
    {
        [UIThumbView clearBuffer];
    }
}
-(NSInteger)documentDirectorySize
{
    NSString* docDirectory = DOC_DIR;//[DOC_DIR stringByAppendingPathComponent:BaseBufferFolder];
//	NSFileManager* fm = [NSFileManager defaultManager];
//    
//   unsigned long long fileSize = [[[fm enumeratorAtPath:docDirectory] directoryAttributes] fileSize];
   //NSLog(@"file size = %lld",[self folderSize:docDirectory]/(1000*1000));
	
    return [self folderSize:docDirectory]/(1000*1000);
}

- (unsigned long long int)folderSize:(NSString *)folderPath {
    NSArray *filesArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *filesEnumerator = [filesArray objectEnumerator];
    NSString *fileName;
    unsigned long long int fileSize = 0;
    
    while (fileName = [filesEnumerator nextObject]) {
        NSDictionary *fileDictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:fileName] error:nil];
        fileSize += [fileDictionary fileSize];
    }
    
    return fileSize;
}

//+ (void)clearBufferOfImageType:(NSString*)type {
//	NSString* docDirectory = [DOC_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"tempImages/%@",type]];
//	NSFileManager* fm = [NSFileManager defaultManager];
//	if ([fm fileExistsAtPath:docDirectory])
//	{
//		[fm removeItemAtPath:docDirectory error:nil];
//	}
//}
- (void)dealloc {
    //SAFE_RELEASE(activity);
    //    CheckAndRelease(allActiveRequestURLAndObjects);
    //    CheckAndRelease(allActiveRequsetUrl);
   // [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (!allActiveRequsetUrl) {
                allActiveRequsetUrl = [[NSMutableSet alloc] init];
            }
            if(!allActiveRequestURLAndObjects)
            {
                allActiveRequestURLAndObjects =[[NSMutableDictionary alloc] init];
            }
        });
        [self setContentMode:UIViewContentModeScaleAspectFit];
        
//        activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [activity setCenter:CGPointMake(frame.size.width/2, frame.size.height/2)];
//        [activity setHidesWhenStopped:YES];
//        [self addSubview:activity];
        
        NSFileManager* fm = [NSFileManager defaultManager];
        NSString* thumbDocPath;
        if([uniqueIdentifire isEqualToString:Grop_List])
        {
            thumbDocPath = [DOC_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",BaseBufferFolder_grop,NoTypeFolder]];
        }
        else if([uniqueIdentifire isEqualToString:Category_List])
        {
            thumbDocPath = [DOC_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",BaseBufferFolder_category,NoTypeFolder]];
        }
        else if([uniqueIdentifire isEqualToString:Deal_List])
        {
            thumbDocPath = [DOC_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",BaseBufferFolder_Deal,Deal_List]];
        }
        else if([uniqueIdentifire isEqualToString:banner_List])
        {
            thumbDocPath = [DOC_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",BaseBufferFolder_Banner,banner_List]];
        }
        
        else
        {
            thumbDocPath = [DOC_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",BaseBufferFolder,NoTypeFolder]];
        }
        if (![[NSFileManager defaultManager] fileExistsAtPath:thumbDocPath])
        {
            NSError* err = nil;
            [fm createDirectoryAtPath:thumbDocPath withIntermediateDirectories:YES attributes:nil error:&err];
            //if (err)
                //NSLog(@"%s:%@",__FUNCTION__,err);
        }
    }
    return self;
}
- (void)didTap:(UIButton*)sender {
    if (self.tapDelegate && [self.tapDelegate respondsToSelector:@selector(didTapOnImageView:)]) {
        [self.tapDelegate didTapOnImageView:self];
    }
}
- (void)addTapReceiver {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
    [button setAutoresizingMask:63];
    [self addSubview:button];
    [button addTarget:self action:@selector(didTap:) forControlEvents:UIControlEventTouchUpInside];
    [button setExclusiveTouch:YES];
}
- (void)setImageType:(NSString *)imageTyp {
    if (imageType != imageTyp) {
//        SAFE_RELEASE(imageType);
        imageType = nil;
        imageType = imageTyp ;
    }
    NSFileManager* fm = [NSFileManager defaultManager];
	NSString* thumbDocPath;
    if([uniqueIdentifire isEqualToString:Grop_List])
    {
        thumbDocPath = [DOC_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",BaseBufferFolder_grop,imageTyp]];
    }
    else if([uniqueIdentifire isEqualToString:Category_List])
    {
        thumbDocPath = [DOC_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",BaseBufferFolder_category,imageTyp]];
    }
    else if([uniqueIdentifire isEqualToString:Deal_List])
    {
        thumbDocPath = [DOC_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",BaseBufferFolder_Deal,imageTyp]];
    }
    else if([uniqueIdentifire isEqualToString:banner_List])
    {
         thumbDocPath = [DOC_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",BaseBufferFolder_Banner,imageTyp]];
    }
    else
    {
        thumbDocPath = [DOC_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",BaseBufferFolder,imageTyp]];
    }
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:thumbDocPath]) 
	{
		NSError* err = nil;
		[fm createDirectoryAtPath:thumbDocPath withIntermediateDirectories:YES attributes:nil error:&err];
//		if (err)
//			NSLog(@"%s:%@",__FUNCTION__,err);
	}
}
- (void)imageDownloadedFromUrl:(NSString*)urlStr {
    if ([self.imageUrlString isEqualToString:urlStr]) {
        [allActiveRequsetUrl removeObject:urlStr];
        NSFileManager* fm = [NSFileManager defaultManager];
        NSString* localPath;
        if([uniqueIdentifire isEqualToString:Grop_List])
        {
            localPath = [NSString stringWithFormat:@"%@/%@/%@/%@",DOC_DIR,BaseBufferFolder_grop,
                         (([self.imageType length])?self.imageType:NoTypeFolder),
                         [urlStr lastPathComponent]];
        }
        else if([uniqueIdentifire isEqualToString:Category_List])
        {
            localPath = [NSString stringWithFormat:@"%@/%@/%@/%@",DOC_DIR,BaseBufferFolder_category,
                         (([self.imageType length])?self.imageType:NoTypeFolder),
                         [urlStr lastPathComponent]];
        }
        else if([uniqueIdentifire isEqualToString:Deal_List])
        {
            localPath = [NSString stringWithFormat:@"%@/%@/%@/%@",DOC_DIR,BaseBufferFolder_Deal,
                         (([self.imageType length])?self.imageType:NoTypeFolder),
                         [urlStr lastPathComponent]];
        }
        else if([uniqueIdentifire isEqualToString:banner_List])
        {
            localPath = [NSString stringWithFormat:@"%@/%@/%@/%@",DOC_DIR,BaseBufferFolder_Banner,
                         (([self.imageType length])?self.imageType:NoTypeFolder),
                         [urlStr lastPathComponent]];
        }
        else
        {
            localPath = [NSString stringWithFormat:@"%@/%@/%@/%@",DOC_DIR,BaseBufferFolder,
                                   (([self.imageType length])?self.imageType:NoTypeFolder),
                                   [urlStr lastPathComponent]];
        }
        
        if ([fm fileExistsAtPath:localPath]) {
            NSData* data = [NSData dataWithContentsOfFile:localPath];
            UIImage* image = nil;
            if ([data length] > 100)
            {
                image = [UIImage imageWithContentsOfFile:localPath];
                if(!image)
                {
                    image = self.defaultImage;
                }
            }
            else
            {
                image = self.defaultImage;
                NSError* err = nil;
                [fm removeItemAtPath:localPath error:&err];
//                if (err)
//                    NSLog(@"%s:%@",__FUNCTION__,err);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                for(UIThumbView *view in [allActiveRequestURLAndObjects objectForKey:urlStr])
                {
                    [view setImage:image];
//                    [view.activity performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
                }
                [allActiveRequestURLAndObjects removeObjectForKey:urlStr];
                
            });
//            [activity performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
            self.imageUrlString = @"";
        }
    }
}
- (void)setImageFromUrl:(NSURL*)imageUrl {
    [self setImage:nil];
    NSString* imageUrlStr = [imageUrl absoluteString];
    if (!imageUrlStr || [imageUrlStr length] < 5) {
        [self setImage:self.defaultImage];
        self.imageUrlString = @"";
        return;
    }
    NSFileManager* fm = [NSFileManager defaultManager];
    NSString* localPath;
    if([uniqueIdentifire isEqualToString:Grop_List])
    {
        localPath = [NSString stringWithFormat:@"%@/%@/%@/%@",DOC_DIR,BaseBufferFolder_grop,
                     (([self.imageType length])?self.imageType:NoTypeFolder),
                     [imageUrlStr lastPathComponent]];
    }
    else if([uniqueIdentifire isEqualToString:Category_List])
    {
        localPath = [NSString stringWithFormat:@"%@/%@/%@/%@",DOC_DIR,BaseBufferFolder_category,
                     (([self.imageType length])?self.imageType:NoTypeFolder),
                     [imageUrlStr lastPathComponent]];
    }
    else if([uniqueIdentifire isEqualToString:Deal_List])
    {
        localPath = [NSString stringWithFormat:@"%@/%@/%@/%@",DOC_DIR,BaseBufferFolder_Deal,
                     (([self.imageType length])?self.imageType:NoTypeFolder),
                     [imageUrlStr lastPathComponent]];
    }
    else if([uniqueIdentifire isEqualToString:banner_List])
    {
        localPath = [NSString stringWithFormat:@"%@/%@/%@/%@",DOC_DIR,BaseBufferFolder_Banner,
                     (([self.imageType length])?self.imageType:NoTypeFolder),
                     [imageUrlStr lastPathComponent]];
    }
    else
    {
        localPath = [NSString stringWithFormat:@"%@/%@/%@/%@",DOC_DIR,BaseBufferFolder,
                     (([self.imageType length])?self.imageType:NoTypeFolder),
                     [imageUrlStr lastPathComponent]];
    }
    self.imageUrlString = imageUrlStr;
    if ([fm fileExistsAtPath:localPath]) {
      UIImage *img  = [UIImage imageWithContentsOfFile:localPath];
        if(!img)
        {
            img = self.defaultImage;
        }
        [self setImage:img];
//        [activity performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
        self.imageUrlString = @"";
    }
    else {
//        UIImage *img  = [UIImage imageNamed:@"comp_list_loading.png"];
//        [self setImage:img];
//        [activity performSelectorOnMainThread:@selector(startAnimating) withObject:nil waitUntilDone:NO];
        [self setImage:loadingImage];
        if (![allActiveRequsetUrl containsObject:imageUrlStr]) {
            [allActiveRequsetUrl addObject:imageUrlStr];
            [allActiveRequestURLAndObjects setObject:[NSMutableArray arrayWithObject:self] forKey:imageUrlStr];
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                NSData* data = [NSData dataWithContentsOfURL:imageUrl];

                    NSFileManager* fm = [NSFileManager defaultManager];
                    if ([[NSFileManager defaultManager] fileExistsAtPath:localPath]) 
                    {
                        NSError* err = nil;
                        [fm removeItemAtPath:localPath error:&err];
//                        if (err)
//                            NSLog(@"%s:%@",__FUNCTION__,err);
                    }
                    [fm createFileAtPath:localPath contents:data attributes:nil];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self imageDownloadedFromUrl:imageUrlStr];
                    });
            });
        }
        else {
//            NSLog(@"Image Is in Queue");
            NSMutableArray *arr =   [allActiveRequestURLAndObjects objectForKey:imageUrlStr];
            if(![arr containsObject:self])
                [arr addObject:self];
            [allActiveRequestURLAndObjects setObject:arr forKey:imageUrlStr];
        }
    }
}

- (void)setImageFromUrlString:(NSString*)urlString
{
//    if([self documentDirectorySize]>=SIZE_Limit)
//    {
//        [UIThumbView clearBuffer];
//    }
    if (!urlString || [urlString length] < 5) {
        [self setImage:self.defaultImage];
        self.imageUrlString = @"";
        return;
    }
    NSURL* url = [NSURL URLWithString:[urlString
                                       stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self setImageFromUrl:url];
}
@end
