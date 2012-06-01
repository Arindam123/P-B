//
//  OAMutableURLRequest.h
//  OAuthConsumer
//
//  Created by Jon Crosby on 10/19/07.
//  Copyright 2007 Kaboomerang LLC. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import <Foundation/Foundation.h>
#import "OAConsumer_LinkedIn.h"
#import "OAToken_LinkedIn.h"
#import "OAHMAC_SHA1SignatureProvider_LinkedIn.h"
#import "OASignatureProviding_LinkedIn.h"
#import "NSMutableURLRequest+Parameters.h"
#import "NSURL+Base.h"


@interface OAMutableURLRequest_LinkedIn : NSMutableURLRequest {
@protected
    OAConsumer_LinkedIn *consumer;
    OAToken_LinkedIn *token;
    NSString *signature;
    NSString *callback;
    id<OASignatureProviding_LinkedIn> signatureProvider;
    NSString *nonce;
    NSString *timestamp;
}
@property(readonly) NSString *signature;
@property(readonly) NSString *nonce;


- (id)initWithURL:(NSURL *)aUrl
		 consumer:(OAConsumer_LinkedIn *)aConsumer
			token:(OAToken_LinkedIn *)aToken
         callback:(NSString *)aCallback
signatureProvider:(id<OASignatureProviding_LinkedIn, NSObject>)aProvider;

 
- (id)initWithURL:(NSURL *)aUrl
		 consumer:(OAConsumer_LinkedIn *)aConsumer
			token:(OAToken_LinkedIn *)aToken
signatureProvider:(id<OASignatureProviding_LinkedIn, NSObject>)aProvider
            nonce:(NSString *)aNonce
        timestamp:(NSString *)aTimestamp;

- (void)prepare;

@end
