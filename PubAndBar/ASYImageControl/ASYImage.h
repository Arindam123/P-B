

#import <Foundation/Foundation.h>

@interface ASYImage : UIView 
{
	NSURLConnection* connection;
    NSMutableData* data;
	int rowIndex;
	int imageType;
	UIButton *thumbnail;
	UIImage* myImageLoaded;
	UIImageView *detailsImage;
	UIActivityIndicatorView *networkIndicator;
    NSString *urlString;
	
}
@property (nonatomic,retain) UIImageView *detailsImage;
@property (nonatomic,retain) NSMutableData* data;
@property (nonatomic,retain) UIButton *thumbnail;
@property (nonatomic) int rowIndex;
@property (nonatomic) int imageType;

@property (nonatomic, retain) NSURLConnection* connection;
@property (nonatomic, retain) UIImage* myImageLoaded;
- (void)loadImageFromURL:(NSURL*)url indicator:(UIActivityIndicatorView *)activeIndicator;
//- (void)loadImageFromVedio:(MDMoviePlayerController*)mdm indicator:(UIActivityIndicatorView *)activeIndicator;
- (UIImage*) image;
//-(void)unLoadConn;
- (UIImage*) imageScaledToSize: (CGSize) newSize  oldImage:(UIImage*)oldImage;
-(void) loadImageWhenNil;
@end
