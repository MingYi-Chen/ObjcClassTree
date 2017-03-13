//
//  ClassNode.m
//  ObjcClassTree
//
//  Created by Ming Yi Chen on 13/03/2017.
//  Copyright © 2017 Ming Yi Chen. All rights reserved.
//

#import "ClassNode.h"

@interface ClassNode()
@property (nonatomic,copy) NSString* name;
@property (nonatomic,strong) NSMutableArray* subClassNodes;
- (BOOL)compareAndCombineWithClass:(ClassNode*)node;
@end

@implementation ClassNode

- (instancetype)initWithClassName:(NSString*)name subclasses:(NSString*)subclase
{
    self = [super init];
    if (self) {
        self.subClassNodes = [NSMutableArray arrayWithObject:subclase];
        self.name = name;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[ClassNode class]]) {
        ClassNode * node = (ClassNode*)object;
        return [self.name isEqualToString:node.name];
    }
    else {
        return NO;
    }
}


// compare, if class is the smae insert subclasses,else return no. create class
- (BOOL)compareAndCombineWithClass:(ClassNode*)node {
    if ([self isEqual:node]) {
        [_subClassNodes addObjectsFromArray:node.subClassNodes];
        return YES;
    }
    else {
        for (NSInteger x=0; x<_subClassNodes.count; x++) {
            ClassNode* subnode = _subClassNodes[x];
            if ( [subnode compareAndCombineWithClass:node] ) {
                return YES;
            }
        }
    }
    return NO;
}


@end
