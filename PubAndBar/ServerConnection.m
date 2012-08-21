//
//  ServerConnection.m
//  FinancialDashboard
//
//

#import "ServerConnection.h"
#import "URLRequestString.h"
#import "Home.h"

@implementation ServerConnection

@synthesize serverDelegate;

-(void)passInformationFromTheClass:(id)fromClass_
		 afterSuccessfulConnection:(SEL)afterSuccessfulConnectionMethod_
			afterFailourConnection:(SEL)afterFailourConnectionMethod_
{
	fromClass=fromClass_;
	afterSuccessfulConnectionMethod=afterSuccessfulConnectionMethod_;
	afterFailourConnectionMethod=afterFailourConnectionMethod_;
}



-(void)getFoodandOffersData:(NSString *) withReference
{
    //location=22.5776840,88.4183484  // Salt Lake
    //47.606400     -122.330800  //US
    //22.5457918,88.347944  //Park Street
    
    //appDelegate = (RestaurantFinderAppDelegate *)[[UIApplication sharedApplication] delegate];
     
    NSString *strUrl;
    if (withReference == nil || [withReference isEqualToString:@"(null)"]) 
        strUrl = [NSString stringWithFormat:FoodandOffersURL];
    else{
        
        strUrl = [NSString stringWithFormat:@"%@?date=%@",FoodandOffersURL,withReference];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    }
        
	NSLog(@"URL %@",strUrl); 
	NSURL *url = [NSURL URLWithString:strUrl];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request performThrottling];
    [request setTimeOutSeconds:60.0];
    [request setCachePolicy:ASIUseDefaultCachePolicy];
    [request setDelegate:self];
    [request startSynchronous];
    /*NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];*/
    
}


-(void)getSportsData:(NSString *) withReference
{
    NSString *strUrl;
    if (withReference == nil || [withReference isEqualToString:@"(null)"]) 
        strUrl = [NSString stringWithFormat:SportsURL];
    else{
        strUrl = [NSString stringWithFormat:@"%@?date=%@",SportsURL,withReference];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    }
    
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request performThrottling];
    [request setTimeOutSeconds:60.0];
    [request setCachePolicy:ASIUseDefaultCachePolicy];
    [request setDelegate:self];
    [request startSynchronous];
	
    /*NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];*/
}

-(void)getRealAleData:(NSString *) withReference
{
    NSString *strUrl;
    if (withReference == nil || [withReference isEqualToString:@"(null)"])
        strUrl = [NSString stringWithFormat:RealAleURL];
    else{
        strUrl = [NSString stringWithFormat:@"%@?date=%@",RealAleURL,withReference];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
    }

    
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request performThrottling];
    [request setTimeOutSeconds:60.0];
    [request setCachePolicy:ASIUseDefaultCachePolicy];
    [request setDelegate:self];
    [request startSynchronous];
    
	/*NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];*/
}



//-----------------------------------mb-25/05/12/5-45 ---------------------//
-(void)getEventsData:(NSString *) withReference
{
    NSString *strUrl;
    if (withReference == nil || [withReference isEqualToString:@"(null)"]) 
        strUrl = [NSString stringWithFormat:FacilitiesURL];
    else{
        strUrl = [NSString stringWithFormat:@"%@?date=%@",FacilitiesURL,withReference];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
    }
    

	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request performThrottling];
    [request setTimeOutSeconds:60.0];
    [request setCachePolicy:ASIUseDefaultCachePolicy];
    [request setDelegate:self];
    [request startSynchronous];
    
	/*NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];*/
    
}


-(void)geteventsData:(NSString*) withreference{
    NSString *strUrl;
    if (withreference == nil || [withreference isEqualToString:@"(null)"]) 
        strUrl = [NSString stringWithFormat:EventsURL];
    else{
        strUrl = [NSString stringWithFormat:@"%@?date=%@",EventsURL,withreference];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
    }
    
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request performThrottling];
    [request setTimeOutSeconds:60.0];
    [request setCachePolicy:ASIUseDefaultCachePolicy];
    [request setDelegate:self];
    [request startSynchronous];
    
	/*NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];*/
}

-(void)getThmeNightData:(NSString*) withreference{
    NSString *strUrl;
    if (withreference == nil || [withreference isEqualToString:@"(null)"]) 
        strUrl = [NSString stringWithFormat:ThemeNightURL];
    else{
        strUrl = [NSString stringWithFormat:@"%@?date=%@",ThemeNightURL,withreference];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
    }
    
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request performThrottling];
    [request setTimeOutSeconds:60.0];
    [request setCachePolicy:ASIUseDefaultCachePolicy];
    [request setDelegate:self];
    [request startSynchronous];
    
	/*NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];*/
}

-(void) getPubDetails:(NSString *) pubID
{
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",PubDetails,pubID];
    
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request performThrottling];
    [request setTimeOutSeconds:60.0];
    [request setCachePolicy:ASIUseDefaultCachePolicy];
    [request setDelegate:self];
    [request startSynchronous];
}



#pragma mark Delete Data Functions

-(void) deleteEventsData:(NSString*) withreference
{
    NSString *strUrl;
    strUrl = [NSString stringWithFormat:@"%@?date=%@",EventDeleteURL,withreference];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];


	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request performThrottling];
    [request setTimeOutSeconds:60.0];
    [request setCachePolicy:ASIUseDefaultCachePolicy];
    [request setDelegate:self];
    [request startSynchronous];
    /*
	NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];*/
}

-(void) deleteThemeNightData:(NSString*) withreference
{
    NSString *strUrl;
    //strUrl = [NSString stringWithFormat:@"%@?date=%@",ThemeNightDeleteURL,withreference];
    strUrl = [NSString stringWithFormat:@"%@?date=%@",ThemeNightDeleteURL,withreference];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request performThrottling];
    [request setTimeOutSeconds:60.0];
    [request setCachePolicy:ASIUseDefaultCachePolicy];
    [request setDelegate:self];
    [request startSynchronous];
    
	/*NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];*/
}


-(void) deleteOneOffData:(NSString*) withreference
{
    NSString *strUrl;
    strUrl = [NSString stringWithFormat:@"%@?date=%@",OneOffDeleteURL,withreference];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request performThrottling];
    [request setTimeOutSeconds:60.0];
    [request setCachePolicy:ASIUseDefaultCachePolicy];
    [request setDelegate:self];
    [request startSynchronous];
    
	/*NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];*/
}


-(void) deleteSportsData:(NSString*) withreference
{
    NSString *strUrl;
    strUrl = [NSString stringWithFormat:@"%@?date=%@",SportsDeleteURL,withreference];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request performThrottling];
    [request setTimeOutSeconds:60.0];
    [request setCachePolicy:ASIUseDefaultCachePolicy];
    [request setDelegate:self];
    [request startSynchronous];
    
	/*NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];*/
}

-(void) deleteFacilityData:(NSString*) withreference
{
    NSString *strUrl;
    strUrl = [NSString stringWithFormat:@"%@?date=%@",FacilityDeleteURL,withreference];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request performThrottling];
    [request setTimeOutSeconds:60.0];
    [request setCachePolicy:ASIUseDefaultCachePolicy];
    [request setDelegate:self];
    [request startSynchronous];
    
	/*NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];*/
}

-(void) deleteRealAleData:(NSString*) withreference
{
    NSString *strUrl;
    strUrl = [NSString stringWithFormat:@"%@?date=%@",RealAleDeleteURL,withreference];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request performThrottling];
    [request setTimeOutSeconds:60.0];
    [request setCachePolicy:ASIUseDefaultCachePolicy];
    [request setDelegate:self];
    [request startSynchronous];
    
	/*NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];*/
}


-(void) deleteFoodData:(NSString*) withreference
{
    NSString *strUrl;
    strUrl = [NSString stringWithFormat:@"%@?date=%@",FoodDeleteURL,withreference];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request performThrottling];
    [request setTimeOutSeconds:60.0];
    [request setCachePolicy:ASIUseDefaultCachePolicy];
    [request setDelegate:self];
    [request startSynchronous];
    
	/*NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];*/
}


#pragma mark
#pragma Non-SubPubs

-(void) getNonSubPubs:(int) _value withDate:(NSString *) _date
{
    NSString *strUrl;
    
    if (_date == nil) {
        
        strUrl = [NSString stringWithFormat:@"%@?range=%d",NonSubscribing_Pub,_value];

    }
    else{
        strUrl = [NSString stringWithFormat:@"%@?range=%d&date=%@",NonSubscribing_Pub,_value,_date];
    }
    
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request performThrottling];
    [request setTimeOutSeconds:240.0];
    [request setCachePolicy:ASIUseDefaultCachePolicy];
    [request setDelegate:self];
    [request startSynchronous];
}

#pragma New Added-SubPubs
-(void) getNewAddedSubPubs:(NSString*) withreference
{
    NSString *strUrl;
    strUrl = [NSString stringWithFormat:@"%@?dateon=%@",NewAddedSubPubsURL,withreference];
    NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
    
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request performThrottling];
    [request setTimeOutSeconds:240.0];
    [request setCachePolicy:ASIUseDefaultCachePolicy];
    [request setDelegate:self];
    [request startSynchronous];
}


#pragma mark
#pragma ASIHTTP Delegates

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    //NSLog(@"responseString   %@   %@    %@",responseString,fromClass,afterSuccessfulConnectionMethod);
    //[fromClass performSelector:afterSuccessfulConnectionMethod withObject:responseString];
    if ([serverDelegate respondsToSelector:@selector(afterSuccessfulConnection:)]) {
        
        [serverDelegate afterSuccessfulConnection:responseString];
    }

    
    // Use when fetching binary data
    //NSData *responseData = [request responseData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    
    if ([serverDelegate respondsToSelector:@selector(afterFailourConnection:)]) {
        
        [serverDelegate afterFailourConnection:[error localizedDescription]];
    }
    
    //[fromClass performSelector:afterFailourConnectionMethod withObject:[NSString stringWithFormat:@"HERE RESPONSE: %d",[(NSHTTPURLResponse*) request statusCode]]];
}

#pragma mark
#pragma URLConnection delegates

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	if(allServerconn)
		[allServerconn release];
//	if(conn)
//		[conn release];
	/*UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Error Message" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert1 show];    
	[alert1 release];*/
	[fromClass performSelector:afterFailourConnectionMethod withObject:[error localizedDescription]];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	//NSLog(@"HERE RESPONSE: %d",[(NSHTTPURLResponse*) response statusCode]);
	if([(NSHTTPURLResponse*) response statusCode]!=200)
		[fromClass performSelector:afterFailourConnectionMethod withObject:[NSString stringWithFormat:@"HERE RESPONSE: %d",[(NSHTTPURLResponse*) response statusCode]]];
	else 
	{
		d2=[[NSMutableData alloc]init];
	}
    
    NSLog(@"CODE   %d",[(NSHTTPURLResponse*) response statusCode]);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1
{
	[d2 appendData:data1];        
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if(allServerconn)
		[allServerconn release];
//	if(conn)
//		[conn release];
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    //NSString *resStr= [[[NSString alloc] initWithBytes:[responseData mutableBytes] length:[responseData length] encoding:NSUTF8StringEncoding] autorelease];
	NSString *data_Response = [[NSString alloc] initWithBytes:[d2 mutableBytes] length:[d2 length] encoding:NSUTF8StringEncoding];
	//NSString *data_Response = [[[NSString alloc] initWithData:d2 encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    //data_Response = [data_Response stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
        //NSLog(@"DATA %@",data_Response);
    
    [fromClass performSelector:afterSuccessfulConnectionMethod withObject:data_Response];
    //NSLog(@"COUNT   %d",[fromClass retainCount]);
    [pool drain];
	
	/*NSArray *arr = [data_Response componentsSeparatedByString:@"Success"];
    if([arr count]>=2)
        [fromClass performSelector:afterSuccessfulConnectionMethod withObject:@"Success"];
    else 
        [fromClass performSelector:afterFailourConnectionMethod withObject:@"Please valid value enter"];*/
	
	if(d2)
		[d2 release];
}

-(void)afterSuccessfulConnection:(id)msg
{
	NSString *strMsg = (NSString*)msg;
	//if(forConnectionType == XML_PERSER_TYPE_DEAL || XML_PERSER_TYPE_REPORT_LIST)
		[fromClass performSelector:afterSuccessfulConnectionMethod withObject:strMsg];
}

-(void)afterFailourConnection:(id)msg
{
	NSLog(@"FAILERRORRRRRRRRRR  %@",msg);
	NSString *strMsg = (NSString*)msg;
	[fromClass performSelector:afterFailourConnectionMethod withObject:strMsg];
}

@end
