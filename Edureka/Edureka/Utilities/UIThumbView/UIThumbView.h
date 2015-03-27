//
//  UIThumbView.h
//  Flipkart
//
//  Created by Shruti Singhal on 08/04/13.
//  Copyright (c) 2013 Kellton Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BaseBufferFolder @"tempImages"
#define BaseBufferFolder_grop @"tempGropImages"
#define BaseBufferFolder_category @"tempCategoryImages"
#define BaseBufferFolder_Deal @"tempDealImages"
#define BaseBufferFolder_Banner @"tempBannerImages"
#define NoTypeFolder @"no_type"

@class UIThumbView;
@protocol UIThumbViewDelegate <NSObject>
@optional
- (void)didTapOnImageView:(UIThumbView*)clikableImage;
@end

@interface UIThumbView : UIImageView {
    UIActivityIndicatorView* activity;
}
@property(nonatomic, retain) id uniqueIdentifire;
@property(nonatomic, assign) id <UIThumbViewDelegate> tapDelegate;
@property(nonatomic, retain) NSString* imageType;
@property(nonatomic, retain) NSString* imageUrlString;
@property(nonatomic, retain) UIImage* defaultImage;
@property(nonatomic,retain)UIActivityIndicatorView* activity;
@property(nonatomic) NSUInteger indexPath;
@property(nonatomic, retain) UIImage* loadingImage;
/*!
 @method clearBuffer
 @abstract use when you want to clear all data downloaded from this class
 @discussion This method is used to delete the base folder i.e buffer folder and its content
 */
//+ (void)clearBuffer;

/*!
 @method clearBufferOfImageType:
 @abstract use when you want to clear all data downloaded from this class of a particular type
 @param type: type of image or more specifically folder in which you want to store this image
 @discussion This method is used to delete perticular folder and content inside it.
 */
//+ (void)clearBufferOfImageType:(NSString*)type;

/*!
 @method addTapReceiver
 @abstract used when you want to get an event when user taps on image.
 @discussion This method is used to create a event receiver transparent UI above ImageView that will call its delegate and preform a selector.
 */
- (void)addTapReceiver;

/*!
 @method setImageFromUrl:
 @abstract use when you want set image which has a URL and that is stored on remote server
 @param imageUrl: URL of image 
 @discussion This method is used to download image from remote server and save in local HD, in folder specified by ~/buffer/imageType with name equels to last path component of URL
 */
- (void)setImageFromUrl:(NSURL*)imageUrl;

/*!
 @method setImageFromUrlString:
 @abstract use when you want set image which has a URL(in string format) and that is stored on remote server
 @param urlString: string URL of image 
 @discussion This method is used to download image from remote server and save in local HD, in folder specified by ~/buffer/imageType with name equels to last path component of URL
 */
- (void)setImageFromUrlString:(NSString*)urlString;

-(void)clearBufferWithSize;
@end
