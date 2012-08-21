//
//  XML4C.m
//  WakeED
//
//  Created by Design Services on 13/07/10.
//  Copyright 2010 Isis Design. All rights reserved.
//

#import "XML4Route.h"
#import "AppDelegate.h"

@implementation XML4Route

//BOOL flg = NO;

-(XML4Route *)initXMLParser{
	
	//appDel = [[ESPProjectAppDelegate alloc]init];
	appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate]; 
	
	[super init];
	return self;
	
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict {

	
	//NSLog(@"Elementname   %@",elementName);
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	/* Fetching the key elements*/
	
	currentElementValue = [[NSMutableString alloc] initWithString:string];
    //NSLog(@"currentElementValue  %@",currentElementValue);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	/*Fetching the xml tokens*/	
	
	if([elementName isEqualToString:@"DirectionsResponse"]){
		
		return;
	}	
	if([elementName isEqualToString:@"points"]) {
					

		appDel.mapRouteLine = [[NSString alloc] initWithString:currentElementValue];
		[currentElementValue release];
		currentElementValue = nil;
		
	}
	
	
}


@end
