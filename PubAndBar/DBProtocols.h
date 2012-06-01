//
//  DBProtocols.h
//  DBUtility
//
//  Created by Tamal on 24/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBHandeler.h"

@interface DBHandeler (AditionalProtocol)
- (int)intForQuery:(NSString*)objs, ...;
- (long)longForQuery:(NSString*)objs, ...; 
- (BOOL)boolForQuery:(NSString*)objs, ...;
- (double)doubleForQuery:(NSString*)objs, ...;
- (NSString*)stringForQuery:(NSString*)objs, ...; 
- (NSData*)dataForQuery:(NSString*)objs, ...;
- (NSDate*)dateForQuery:(NSString*)objs, ...;

// Notice that there's no dataNoCopyForQuery:.
// That would be a bad idea, because we close out the result set, and then what
// happens to the data that we just didn't copy?  Who knows, not I.


- (BOOL)tableExists:(NSString*)tableName;
- (ResultSet*)getSchema;
- (ResultSet*)getTableSchema:(NSString*)tableName;
- (BOOL)columnExists:(NSString*)tableName columnName:(NSString*)columnName;
@end
