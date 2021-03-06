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
@property (nonatomic,retain) NSMutableArray *classNodes;
@property (nonatomic,assign) NSInteger classNum;
@end


@implementation ClassManager

- (ClassNode*)createNodeWithString:(NSString*)line {
    line = [line stringByReplacingOccurrencesOfString:@"@interface " withString:@""];
    line = [line componentsSeparatedByString:@"<"][0];
    line = [line componentsSeparatedByString:@"{"][0];
    line = [line componentsSeparatedByString:@"//"][0];
    line = [line componentsSeparatedByString:@"/*"][0];
    NSArray* components = [line componentsSeparatedByString:@":"];
    NSString* subclass = components[0];
    subclass = [subclass stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* parentClass = components[1];
    parentClass = [parentClass stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    ClassNode* newNode = [[ClassNode alloc] initWithClassName:parentClass subclasses:subclass];
    return newNode;
}

- (instancetype)initWithString:(NSString*)rawDataString
{
    self = [super init];
    if (self) {
        self.classNodes = [NSMutableArray array];
        
        // first, separate by new line
        NSArray* lines = [rawDataString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        for (NSInteger x = 0  ; x < lines.count ; x++) {
            NSString *rawLine = lines[x];
            if (![rawLine hasPrefix:@"//"] && ![rawLine isEqualToString:@""] ) {
                id node = [self createNodeWithString:lines[x]];
                [_classNodes addObject:node];
            }
        }
    }
    [self classPair];
    return self;
}


- (void)classPair {
    NSInteger classNum = _classNodes.count;
    for (NSInteger i = 0 ; i < _classNodes.count; i++) {
        for (NSInteger j = 0 ; j < _classNodes.count; j++) {
            if (i!=j) {
                ClassNode* node = _classNodes[i];
                ClassNode* otherNode = _classNodes[j];
                if ([node compareAndCombineWithClass:otherNode]) {
                    [_classNodes removeObject:otherNode];
                    if (j<i) {
                        i--;
                    }
                    j--;
                }
            }
        }
    }
    //if count is modified then do next time
    if (classNum != _classNodes.count) {
        [self classPair];
    }
    else {
        return;
    }
    
}

- (NSString*)classDescription {
    NSMutableString * desc = [NSMutableString string];
    for (NSInteger i=0; i<_classNodes.count; i++) {
        ClassNode* node = (ClassNode*)_classNodes[i];
        NSNumber *end = [NSNumber numberWithBool:YES];
        NSArray *ends = [NSArray arrayWithObject:end];
        [desc appendString:[node descriptionWithLvl:0 ends:ends]];
    }
    return desc;
}
@end
