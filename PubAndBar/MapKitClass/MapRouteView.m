//
//  MapRouteView.m
//  HotelSearch
//
//  Created by Design Services on 16/08/10.
//  Copyright 2010 Isis Design. All rights reserved.
//

#import "MapRouteView.h"

#import <CoreLocation/CoreLocation.h>
#import "CSMapAnnotation.h"
#import "CSRouteAnnotation.h"
#import "CSRouteView.h"
#import "Reachability.h"
#import "AppDelegate.h"


@implementation MapRouteView
@synthesize mapView   = _mapView;

@synthesize type;
@synthesize _storeName;
@synthesize _storeLat;
@synthesize _storeLong;
@synthesize _storeImg;


@synthesize flg;

@synthesize callingFrom;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	spinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    [spinner setCenter:CGPointMake(160, 210)]; 
    [self.view addSubview:spinner];
    
	appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate]; 
	[[self navigationController] setNavigationBarHidden:NO animated:YES];
	
	self.navigationItem.hidesBackButton = NO;
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:16.0];
	label.textAlignment = UITextAlignmentCenter;
	label.textColor = [UIColor whiteColor];
	self.navigationItem.titleView = label;
	label.text = NSLocalizedString(_storeName, @"");
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonpressed:)];
    barBtn.style = UIBarButtonItemStyleBordered;
    self.navigationItem.leftBarButtonItem = barBtn;
    [barBtn release];
    
    /*UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
	self.navigationItem.leftBarButtonItem = add;
	self.navigationItem.leftBarButtonItem.enabled = YES;*/
	
	// dictionary to keep track of route views that get generated. 
	_routeViews = [[NSMutableDictionary alloc] init];
    
    [spinner startAnimating]; 
	loaderTimer = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(threadAction) userInfo:nil  repeats:NO];

	
    
	/*http://maps.google.com/maps/api/directions/xml?origin=22.5253288,88.3460723&destination=22.4840689,88.3526519&mode=driving&sensor=false*/
	
	
	
	
	
}


-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];

}


-(void) cancelButtonpressed:(id) sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void) threadAction
{
    //float statLat = 47.606716;
    //float statLong = -122.335092;   
	//_storeLat = @"-36.8484597";
	//_storeLong = @"174.7633315";
   /* float a = 22.53272;
    float b =  88.363616;*/
    //NSLog(@"appDel.currentPoint %@  _storeLat %@    _storeLong %@",appDel.currentPoint,_storeLat,_storeLong);
    
    //NSString *latitude = @"51.5001524";
    //NSString *longitude = @"-0.1262362";
    
	NSString *orgStr = [NSString stringWithFormat:@"%f,%f",appDel.currentPoint.coordinate.latitude,appDel.currentPoint.coordinate.longitude];
	NSString *desStr = [NSString stringWithFormat:@"%@,%@",_storeLat,_storeLong];
        //NSLog(@"orgStr=%@ desStr=%@",orgStr,desStr);
    
	
	Reachability *curReach = [[Reachability reachabilityForInternetConnection] retain];
	NetworkStatus netStatus = [curReach currentReachabilityStatus];
	BOOL isSuccess = YES;
	switch (netStatus)
	{
		case NotReachable:
		{
			UIAlertView *connectionAlert = [[UIAlertView alloc] init]; 
			[connectionAlert setTitle:@"Internet Connection Error"];
			[connectionAlert setMessage:@"Internet connection not available. Please check network conenction."];    
			[connectionAlert setDelegate:self];
			[connectionAlert setTag:1];
			[connectionAlert addButtonWithTitle:@"Cancel"];
			[connectionAlert show];
			[connectionAlert release];
			//NSLog(@"NETWORKCHECK: Not Connected");
			break;
		}
		case ReachableViaWWAN:
		{
			isSuccess = (int)[appDel callingXML4Route:[NSString stringWithFormat:@"http://maps.google.com/maps/api/directions/xml?origin=%@&destination=%@&mode=driving&sensor=false",orgStr,desStr]];				
			
			
			if((isSuccess)&&(appDel.mapRouteLine != nil))
			{
				NSMutableArray *pointArr = [self decodePolyline:appDel.mapRouteLine];
				NSMutableArray *points = [[NSMutableArray alloc] init];
				
				for(int i=0 ;i<[pointArr count] ;i+=2)
				{
					CLLocation *loc = [[[CLLocation alloc] initWithLatitude:[[pointArr objectAtIndex:i] floatValue] longitude:[[pointArr objectAtIndex:i+1] floatValue]] autorelease];	
					[points addObject:loc];
				}
				
				
				
				//
				// Create our map view and add it as as subview. 
				//
				_mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
				[self.view addSubview:_mapView];
				[_mapView setDelegate:self];
				
				
				// CREATE THE ANNOTATIONS AND ADD THEM TO THE MAP
				
				// first create the route annotation, so it does not draw on top of the other annotations. 
				CSRouteAnnotation* routeAnnotation = [[[CSRouteAnnotation alloc] initWithPoints:points] autorelease];
				[_mapView addAnnotation:routeAnnotation];
				
				
				// create the rest of the annotations
				CSMapAnnotation* annotation = nil;
				
				// create the start annotation and add it to the array
				annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:0] coordinate]
								annotationType:CSMapAnnotationTypeStart	title:@"My Location"] autorelease];
				[_mapView addAnnotation:annotation];
				
				
				// create the end annotation and add it to the array
				annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:points.count - 1] coordinate]
                            annotationType:CSMapAnnotationTypeEnd title:_storeName] autorelease];
				[_mapView addAnnotation:annotation];
            //NSLog(@"NAME  %@",_storeName);
				
				
				[points release];
				
				// center and size the map view on the region computed by our route annotation. 
				[_mapView setRegion:routeAnnotation.region];	
                
			}
			else 
			{
				UIAlertView *alV = [[UIAlertView alloc] initWithTitle:@"Can not find the driving direction." message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];	
				[alV show];
				[alV release];
				//NSLog(@"ERROR");
			}
            
			
			break;
		}
		case ReachableViaWiFi:
		{
            NSLog(@"%@",[NSString stringWithFormat:@"http://maps.google.com/maps/api/directions/xml?origin=%@&destination=%@&mode=driving&sensor=false",orgStr,desStr]);
			isSuccess = [appDel callingXML4Route:[NSString stringWithFormat:@"http://maps.google.com/maps/api/directions/xml?origin=%@&destination=%@&mode=driving&sensor=false",orgStr,desStr]];	
			
			//NSLog(@"is success %d",isSuccess);			
			//NSLog(@"maproutline %@",appDel.mapRouteLine);
			if((isSuccess)&&(appDel.mapRouteLine != nil))
			{
                //NSLog(@"invalidate");
                [loaderTimer invalidate];
				loaderTimer = nil;
                [spinner stopAnimating];
                
				NSMutableArray *pointArr = [self decodePolyline:appDel.mapRouteLine];
				NSMutableArray *points = [[NSMutableArray alloc] init];
				
				for(int i=0 ;i<[pointArr count] ;i+=2)
				{
					CLLocation *loc = [[[CLLocation alloc] initWithLatitude:[[pointArr objectAtIndex:i] floatValue] longitude:[[pointArr objectAtIndex:i+1] floatValue]] autorelease];	
					[points addObject:loc];
				}
				
                
				_mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
				[self.view addSubview:_mapView];
				[_mapView setDelegate:self];
                
				
				CSRouteAnnotation* routeAnnotation = [[[CSRouteAnnotation alloc] initWithPoints:points] autorelease];
				[_mapView addAnnotation:routeAnnotation];
				
				
				
				CSMapAnnotation* annotation = nil;
				
				
				annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:0] coordinate]
                                annotationType:CSMapAnnotationTypeStart	title:@"My Location"] autorelease];
				[_mapView addAnnotation:annotation];
				
				
				
				annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:points.count - 1] coordinate]
                            annotationType:CSMapAnnotationTypeEnd title:_storeName] autorelease];
                
				[_mapView addAnnotation:annotation];
            //NSLog(@"NAME  %@",_storeName);

				
				
				[points release];
                
				[_mapView setRegion:routeAnnotation.region];	
				
			}
			else 
			{
                
                
				[loaderTimer invalidate];
				loaderTimer = nil;
                [spinner stopAnimating];
                
				UIAlertView *alV = [[UIAlertView alloc] initWithTitle:@"Can not find the driving direction." message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];	
				[alV show];
				[alV release];
				//NSLog(@"ERROR");
			}
            
			break;
		}
			
	}
}



- (NSMutableArray *) decodePolyline:(NSString *)encodedPoints {
	
	NSString *escapedEncodedPoints = [encodedPoints stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];
	int len = [escapedEncodedPoints length];
	NSMutableArray *waypoints = [[NSMutableArray alloc] init];
	int index = 0;
	float lat = 0;
	float lng = 0;
	
	while (index < len) {
		char b;
		int shift = 0;
		int result = 0;
		
		do {
			b = [escapedEncodedPoints characterAtIndex:index++] - 63;
			
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		
		float dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lat += dlat;
		
		shift = 0;
		result = 0;
		do {
			b = [escapedEncodedPoints characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		
		float dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lng += dlng;
		
		float finalLat = lat * 1e-5;
		float finalLong = lng * 1e-5;
		
		
		NSString *lat = [[NSString alloc] initWithFormat:@"%f", finalLat];
		NSString *lng = [[NSString alloc] initWithFormat:@"%f", finalLong];
		[waypoints addObject:lat];
		[waypoints addObject:lng];		
		//[newPoint release];
	}
	return waypoints;
}


- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
	// turn off the view of the route as the map is chaning regions. This prevents
	// the line from being displayed at an incorrect positoin on the map during the
	// transition. 
	for(NSObject* key in [_routeViews allKeys])
	{
		CSRouteView* routeView = [_routeViews objectForKey:key];
		routeView.hidden = YES;
	}
	
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
	// re-enable and re-poosition the route display. 
	for(NSObject* key in [_routeViews allKeys])
	{
		CSRouteView* routeView = [_routeViews objectForKey:key];
		routeView.hidden = NO;
		[routeView regionChanged];
	}
	
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	MKAnnotationView* annotationView = nil;
	
	
	if([annotation isKindOfClass:[CSMapAnnotation class]])
	{
		// determine the type of annotation, and produce the correct type of annotation view for it.
		CSMapAnnotation* csAnnotation = (CSMapAnnotation*)annotation;
		if(csAnnotation.annotationType == CSMapAnnotationTypeStart || 
		   csAnnotation.annotationType == CSMapAnnotationTypeEnd)
		{
			NSString* identifier = @"Pin";
			MKPinAnnotationView* pin = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
			
			if(nil == pin)
			{
				pin = [[[MKPinAnnotationView alloc] initWithAnnotation:csAnnotation reuseIdentifier:identifier] autorelease];
			}
			
			[pin setPinColor:(csAnnotation.annotationType == CSMapAnnotationTypeStart) ? MKPinAnnotationColorGreen : MKPinAnnotationColorRed];
			pin.animatesDrop = YES;
				
			//pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			//pin.canShowCallout = YES;
			//pin.enabled = YES;
			
			annotationView = pin;
		}
		
		
		[annotationView setEnabled:YES];
		[annotationView setCanShowCallout:YES];
	}
	
	else if([annotation isKindOfClass:[CSRouteAnnotation class]])
	{
		CSRouteAnnotation* routeAnnotation = (CSRouteAnnotation*) annotation;
		
		annotationView = [_routeViews objectForKey:routeAnnotation.routeID];
		
		if(nil == annotationView)
		{
			CSRouteView* routeView = [[[CSRouteView alloc] initWithFrame:CGRectMake(0, 0, _mapView.frame.size.width, _mapView.frame.size.height)] autorelease];
			
			routeView.annotation = routeAnnotation;
			routeView.mapView = _mapView;
			
			[_routeViews setObject:routeView forKey:routeAnnotation.routeID];
			
			annotationView = routeView;
		}
	}
	
	return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	//NSLog(@"calloutAccessoryControlTapped");
	/*
	AboutVenue *ptr = [[AboutVenue alloc] initWithNibName:@"AboutVenue" bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:ptr animated:YES];
	[ptr release];
	*/
	
}

/*-(void) back:(id)sender
{
	
	[self dismissModalViewControllerAnimated:YES];
	
}*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [_mapView release];
	_mapView = nil;
    [_routeViews release];
	_routeViews = nil;
}


- (void)dealloc {
	
	[_mapView release];
	
	[_routeViews release];
	
    [super dealloc];
}


@end
