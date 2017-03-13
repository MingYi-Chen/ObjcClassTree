//
//  ClassManager.h
//  ObjcClassTree
//
//  Created by Ming Yi Chen on 13/03/2017.
//  Copyright © 2017 Ming Yi Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassManager : NSObject
- (instancetype)initWithString:(NSString*)rawDataString;
- (NSString*)classDescription;
@end
