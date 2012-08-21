//
//  XML4C.h
//  WakeED
//
//  Created by Design Services on 13/07/10.
//  Copyright 2010 Isis Design. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AppDelegate;

@interface XML4Route : NSObject <NSXMLParserDelegate>{
	
	NSMutableString *currentElementValue;
	
	NSMutableString *currentElementValueLat;
	NSMutableString *currentElementValueLong;
	
	NSMutableString *attributeStrId;
	NSMutableString *attributeStrNm;	
	AppDelegate *appDel;
	
		
}

-(XML4Route *)initXMLParser;


@end
