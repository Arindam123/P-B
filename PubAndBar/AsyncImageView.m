#import "AsyncImageView.h"
#import "AppDelegate.h"
@implementation AsyncImageView

@synthesize imageSetSize;
//@synthesize asyncImgObj;

- (void)dealloc
{
	[spinner release];
	[connection cancel]; 
	[connection release];
	[data release]; 
    [super dealloc];
}

- (void)loadImageFromURL:(NSURL*)url
{
	strURL = [url absoluteString];
	[strURL retain];
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	UIImage *img = [app.allImageDist objectForKey:strURL];
	if(img)
	{
		imageView = [[[UIImageView alloc] initWithImage:img] autorelease];
		//imageView.image = img;
		[self addSubview:imageView];
		imageView.frame = self.bounds;
        [imageView setContentMode:[self setImageContentMode:imageSetSize]];

		[self setNeedsLayout];	
		//[self bringSubviewToFront:imageView];
		[imageView setNeedsLayout];
	}
	else 
	{
		spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.frame.size.width-20)/2,(self.frame.size.height-20)/2,20,20)];
		spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
		[self addSubview:spinner];
		[spinner startAnimating];
		if (connection!=nil) 
		{ 
			[connection release]; 
		} 
		if (data!=nil)
		{ 
			[data release];
		}
		NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
		connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; 
	}
}


- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData
{
	if (data==nil)
	{
		data = [[NSMutableData alloc] initWithCapacity:2048];
	} 
    
	[data appendData:incrementalData];
}

//- (BOOL)isJPEGValid:(NSData *)jpeg {
//    if ([jpeg length] < 8) return NO;
//    const char * bytes = (const char *)[jpeg bytes];
//    if (bytes[0] != 0xFF || bytes[1] != 0xD8) return NO;
//    if (bytes[[jpeg length] - 2] != 0xFF || 
//        bytes[[jpeg length] - 1] != 0xD9) return NO;
//    return YES;
//}
- (BOOL)isJPEGValid:(NSData *)jpeg {
    if ([jpeg length] < 8) return NO;
    const char * bytes = (const char *)[jpeg bytes];
    if (bytes[0] != 0xFF || bytes[1] != 0xD8) return NO;
    if (bytes[[jpeg length] - 2] != 0xFF || bytes[[jpeg length] - 1] != 0xD9) return NO;
    return YES;
}


- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection 
{
    
    @try{
	[spinner stopAnimating];
	[connection release];
	connection=nil;
	if ([[self subviews] count]>0)
	{
		[[[self subviews] objectAtIndex:0] removeFromSuperview];
	}
//        if([self isJPEGValid:data])
//        {
        UIImage *img = [UIImage imageWithData:data];
        
        NSData *imgData = UIImageJPEGRepresentation(img, 0.01);

        img=[UIImage imageWithData:imgData];
   // Async_Image  *objAsynImg =[[Async_Image  alloc] init];
   // [objAsynImg  LoadImageInDirectory:data asyncObject:self.asyncImgObj];
  //  [objAsynImg  release];
    
	if(img)
	{
		imageView = [[[UIImageView alloc] initWithImage:img] autorelease];
		myImageLoaded=img;
	}
	
	[self addSubview:imageView];
	imageView.frame = self.bounds;
	[self setNeedsLayout];	
	[imageView setNeedsLayout];
	
	[imageView setContentMode:[self setImageContentMode:imageSetSize]];  //UIViewContentModeScaleToFill
	[self bringSubviewToFront:imageView];
	
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	if(img)
	{
		[appDelegate.allImageDist setObject:img forKey:strURL];		
	}
	else 
		[appDelegate.allImageDist setObject:[UIImage imageNamed:@"bg-1.png"] forKey:strURL];
	[data release];
	data=nil;
            
        
        
    }@catch (NSException *e) {
        NSLog(@"%@",e);
    }
    
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
	[strURL release];
	if (connection) 
	{ 
		[connection cancel]; 
		[connection release];
		connection = nil;
	}
	[spinner stopAnimating];
}

- (void)setImage:(UIImage*)img
{
	imageView = [[[UIImageView alloc] initWithImage:img] autorelease];
	[self addSubview:imageView];
    [imageView setContentMode:[self setImageContentMode:imageSetSize]]; //UIViewContentModeScaleToFill

	imageView.frame = self.bounds;
	[self setNeedsLayout];	
	[imageView setNeedsLayout];
}

- (UIImage*) image 
{
	UIImageView* iv = [[self subviews] objectAtIndex:0];
	myImageLoaded=[iv image];
	return myImageLoaded;
}


-(UIViewContentMode)setImageContentMode:(ImageFitSize)value
{
    UIViewContentMode   type;
    switch (value) {
        case 0:
            return type = UIViewContentModeScaleToFill;
            break;
        case 1:
            return  type = UIViewContentModeScaleAspectFit;            break;
        case 2:
            return  type = UIViewContentModeScaleAspectFill;
        default:
            break;
    }
    
    return type;
}


@end