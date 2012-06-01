#import <UIKit/UIKit.h>
//#import "Async_Image.h"

typedef enum {
    
    SetImageToFill =0,
    SetImageAspectFit,
    SetImageAspectFill
    
} ImageFitSize;


@interface AsyncImageView : UIView 
{
	NSURLConnection* connection;
	NSMutableData* data;
	
	UIActivityIndicatorView *spinner;
	UIImageView* imageView;
	NSString *strURL;
	UIImage *myImageLoaded;
    
    ImageFitSize   imageSetSize;
    
   // Async_Image    *asyncImgObj;
}

@property(nonatomic, readwrite)ImageFitSize   imageSetSize;
//@property(nonatomic,retain) Async_Image    *asyncImgObj;

- (void)loadImageFromURL:(NSURL*)url;
- (void)setImage:(UIImage*)img;
- (UIImage*) image;

-(UIViewContentMode)setImageContentMode:(ImageFitSize)value;

@end