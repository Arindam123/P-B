

#import "ASYImage.h"
#import "ImageCacheObject.h"
#import "ImageCache.h"

static ImageCache *imageCache = nil;

@implementation ASYImage
@synthesize  myImageLoaded;
@synthesize connection;
@synthesize rowIndex,imageType;
@synthesize thumbnail;
@synthesize detailsImage;
@synthesize data;


- (void)dealloc {
	[connection cancel]; //in case the URL is still downloading
	[connection release];
	[data release]; 
    [super dealloc];
}

/*
 -(id)initWithFrame:(CGRect)frame
 {
 if ((self = [super initWithFrame:frame])) 
 {
 appDelegate = (AKAiPhoneAppDelegate *)[[UIApplication sharedApplication] delegate];
 }
 return self;
 }
 */
- (void)loadImageFromURL:(NSURL*)url indicator:(UIActivityIndicatorView *)activeIndicator 
{
	networkIndicator=activeIndicator;
    [networkIndicator startAnimating];
	 //in case we are downloading a 2nd image
	if (data!=nil){ 
        [data release]; 
    }
        //NSLog(@"URL  %@",url);
    
    if (imageCache == nil) // lazily create image cache
        imageCache = [[ImageCache alloc] initWithMaxSize:4*1024*1024];  // 2 MB Image cache
    
    [urlString release];
    urlString = [[url absoluteString] copy];
    
    UIImage *cachedImage = [imageCache imageForKey:urlString];
    if (cachedImage != nil){
        if ([[self subviews] count] > 0) {
            [[[self subviews] objectAtIndex:0] removeFromSuperview];
        }
        
        if(networkIndicator){
            [networkIndicator stopAnimating];
            [networkIndicator removeFromSuperview];
            [networkIndicator release];
            networkIndicator = nil;
        }
        
        UIImageView *imageView = [[[UIImageView alloc] initWithImage:cachedImage] autorelease];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.autoresizingMask = 
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:imageView];
        imageView.frame = self.bounds;
        [imageView setNeedsLayout]; // is this necessary if superview gets setNeedsLayout?
        [self setNeedsLayout];
        return;
    }
    
    
    
	NSURLRequest* request = [NSURLRequest requestWithURL:[url absoluteURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    if (connection){
		[connection release];
        connection=nil ;
    }
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; //notice how delegate set to self object
        //TODO error handling, what if connection is nil?
    
	
	/*
     //app=(ATVESCAPE2AppDelegate *)[[UIApplication sharedApplication]delegate];
     if (connection!=nil)
     { 
     [connection cancel];
     [connection release];
     } 
     if (data!=nil) 
     { 
     [data release];
     data = nil;
     }
     networkIndicator=activeIndicator;
     NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
     connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
     */
}

    //the URL connection calls this repeatedly as data arrives
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData
{
	if (data==nil) { data = [[NSMutableData alloc] initWithCapacity:4096]; } 
	[data appendData:incrementalData];
}


- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection 
{
	//NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	if(networkIndicator){
		[networkIndicator stopAnimating];
		[networkIndicator removeFromSuperview];
		[networkIndicator release];
		networkIndicator = nil;
    }
//	if(connection){
//		[connection release];
//		connection=nil;
//    }
	if ([[self subviews] count]>0){
            //then this must be another image, the old one is still in subviews
		[[[self subviews] objectAtIndex:0] removeFromSuperview]; //so remove it (releases it also)
	}
	UIImage *tempImage = [[UIImage alloc] initWithData:data];
    [imageCache insertImage:tempImage withSize:[data length] forKey:urlString];
        //make an image view for the image
	UIImageView* imageView = [[UIImageView alloc] initWithImage:tempImage];
        //make sizing choices based on your needs, experiment with these. maybe not all the calls below are needed.
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight );
	[self addSubview:imageView];
	imageView.frame = self.bounds;
	[imageView setNeedsLayout];
        //[imageView setContentMode:UIViewContentModeScaleAspectFit];
	[self setNeedsLayout];
	float wt = tempImage.size.width;
	float ht = tempImage.size.height;
	/*if(wt>120)
     wt = 120;
     if(ht>100)
     ht = 100;*/
	CGSize newS = CGSizeMake(wt, ht);
	UIImage *image = [self imageScaledToSize:newS oldImage:tempImage];
	
	detailsImage.image = image;
    
	[data release]; //don't need this any more, its in the UIImageView now
	data=nil;
	[tempImage release];
	[imageView release];
	//[pool drain];
}
- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
	
	[connection release];
	connection=nil;
	if ([[self subviews] count]>0){
		[[[self subviews] objectAtIndex:0] removeFromSuperview];
    }
	if(networkIndicator){
		[networkIndicator stopAnimating];
		[networkIndicator release];
		networkIndicator = nil;
    }
	UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noWifi.png"]];
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight );
	[self addSubview:imageView];
	imageView.frame = self.bounds;
	[imageView setNeedsLayout];
	[self setNeedsLayout];
	[imageView release];
        //myImageLoaded = [UIImage imageNamed:@"noWifi.png"];
	
	
}
- (UIImage*) imageScaledToSize: (CGSize) newSize  oldImage:(UIImage*)oldImage
{
	UIGraphicsBeginImageContext(newSize);
	[oldImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}

- (UIImage*) image 
{
	UIImageView* iv = [[self subviews] objectAtIndex:0];
	myImageLoaded=[iv image];
	return myImageLoaded;
}


-(void) loadImageWhenNil
{
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon.png"]];
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight );
	[self addSubview:imageView];
	imageView.frame = self.bounds;
	[imageView setNeedsLayout];
	[self setNeedsLayout];
	[imageView release];
}



@end
