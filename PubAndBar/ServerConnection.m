//
//  ServerConnection.m
//  FinancialDashboard
//
//  Created by Ria Chandra on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ServerConnection.h"
#import "URLRequestString.h"


@implementation ServerConnection

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
     
    
    NSString *strUrl = [NSString stringWithFormat:@"%@",@"http://www.pubandbar-network.co.uk/iphone/test/iphoneFoodVenues.php?date=2012-02-02"];//FoodandOffersURL,withReference];
        
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
	NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}


-(void)getSportsData:(NSString *) withReference
{
    NSString *strUrl = [NSString stringWithFormat:SportsURL];
    
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
	NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)getRealAleData:(NSString *) withReference
{
    NSString *strUrl = [NSString stringWithFormat:RealAleURL];
    
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
	NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}



//-----------------------------------mb-25/05/12/5-45 ---------------------//
-(void)getEventsData:(NSString *) withReference
{
    NSString *strUrl = [NSString stringWithFormat:FacilitiesURL];

	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
	NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}
//--------------------------------------------------//

-(void)geteventsData:(NSString*) withreference{
    NSString *strUrl = [NSString stringWithFormat:EventsURL];
    
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
	NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void) getPubDetails:(NSString *) pubID
{
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",PubDetails,pubID];
    
	NSLog(@"URL %@",strUrl);
	NSURL *url = [NSURL URLWithString:strUrl];
	NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
	allServerconn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	if(allServerconn)
		[allServerconn release];
	if(conn)
		[conn release];
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
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1
{
	[d2 appendData:data1];        
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if(allServerconn)
		[allServerconn release];
	if(conn)
		[conn release];
    
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    
	//NSString *data_Response2 = [[NSString alloc] initWithData:d2 encoding:NSUTF8StringEncoding];
	NSString *data_Response = [[[NSString alloc] initWithData:d2 encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    //data_Response = [data_Response stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
        //NSLog(@"DATA %@",data_Response);
    
    [fromClass performSelector:afterSuccessfulConnectionMethod withObject:data_Response];
    [pool release];
	
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
