//
//  Connector.h
//  cineshow
//
//  Created by Fernando Duarte on 27/01/20.
//  Copyright © 2020 Fernando Duarte. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CallbackResponse <NSObject>

- (void) responseFromConnector:(NSData *)response;

@end

@interface Connector : NSObject

- (void) getDataFrom:(NSString *)url;
@property (nonatomic, weak) id <CallbackResponse> delegate;

@end
