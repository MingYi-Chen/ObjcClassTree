//
//  ClassManager.m
//  ObjcClassTree
//
//  Created by Ming Yi Chen on 13/03/2017.
//  Copyright © 2017 Ming Yi Chen. All rights reserved.
//

#import "ClassManager.h"
#import "ClassNode.h"

@interface ClassManager()
@property (nonatomic,copy) NSMutableArray *classNodes;
@property (nonatomic,assign,getter=isDone) BOOL Done;
@end


@implementation ClassManager

- (ClassNode*)createNodeWithString:(NSString*)line {
    NSArray* components = [line componentsSeparatedByString:@":"];
    NSString* subclass = components[0];
    subclass = [subclass stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString* parentClass = components[1];
    parentClass = [parentClass stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    ClassNode* newNode = [[ClassNode init] initWithClassName:parentClass subclasses:subclass];
    return newNode;
}

- (instancetype)initWithString:(NSString*)rawDataString
{
    self = [super init];
    if (self) {
        self.classNodes = [NSMutableArray array];
        NSArray *lines = [rawDataString componentsSeparatedByString:@"\n"];
        for (NSInteger x = 0  ; x < lines.count ; x++) {
            [_classNodes addObject:[self createNodeWithString:lines[x]]];
        }
        
    }
    return self;
}

- (BOOL)isDone {
    return YES;
}

- (void)classPair {
    if (self.isDone) {
        return;
    }
    else {
        [self classPair];
    }
}

- (NSString*)classDescription {
    NSMutableString * desc = [NSMutableString string];
    
//    - UITestReport20170310
//    ├── log.txt
//    └──images

    
    return desc;
}
@end
