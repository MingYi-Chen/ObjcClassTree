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
        self.subClassNodes = [NSMutableArray array];
        if (subclase) {
            ClassNode *subnode = [[ClassNode alloc] initWithClassName:subclase subclasses:nil];
            [_subClassNodes addObject:subnode];
        }
        self.name = name;
    }
    return self;
}

- (BOOL)isEqual:(id)object {

    __block BOOL isequal = NO;
    if ([object isKindOfClass:[ClassNode class]]) {
        ClassNode * node = (ClassNode*)object;
        if ([self.name isEqualToString:node.name]) {
            if ([self.subClassNodes count] == [node.subClassNodes count]) {
                isequal = YES;
                [self.subClassNodes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    ClassNode* selfNode = (ClassNode*)obj;
                    ClassNode* otherNode = node.subClassNodes[idx];
                    if (![selfNode isEqual:otherNode]) {
                        isequal = NO;
                        *stop = YES;
                    }
                }];
            }
        }
        return  isequal;
    }
    return isequal;
}


// compare, if class is the smae insert subclasses,else return no. create class
- (BOOL)compareAndCombineWithClass:(ClassNode*)node {
    if ([self.name isEqualToString:node.name]) {
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

- (NSString*) descriptionWithLvl:(NSInteger)level ends:(NSArray*)ends {
    __block NSMutableString * desc = [NSMutableString string];

    if (level==0) {
        [desc appendString:@"\n"];
        [desc appendString:@"\n"];
    }

    for (NSInteger i=0; i<level; i++) {
        NSNumber* isEnd = (NSNumber*)ends[i];
        if (![isEnd boolValue]) {
            [desc appendString:@"|"];
        }
        [desc appendString:@"\t"];            
    }
    NSNumber *laseEnd = [ends lastObject];
    
    if (level!=0) {
        [desc appendString: ([laseEnd boolValue])?@"└──": @"├──"];
    }
    [desc appendString:self.name];
    
    level+=1;
    id lastEl = [_subClassNodes lastObject];
    [self.subClassNodes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ClassNode* node = (ClassNode*)obj;
        [desc appendString:@"\n"];
        NSMutableArray * newEnds = [NSMutableArray arrayWithArray:ends];
        [newEnds addObject:[NSNumber numberWithBool:(obj==lastEl)]];
        [desc appendString:[node descriptionWithLvl:level ends:newEnds]];
    }];
    return desc;
}

- (NSString*)description {
    NSMutableString* desc = [NSMutableString string];
    for (NSInteger i=0; i<_subClassNodes.count; i++) {
        ClassNode* node = (ClassNode*)_subClassNodes[i];
        [desc appendFormat:@"%@", node.description];
        [desc appendFormat:@";"];
    }
    return [NSString stringWithFormat:@" %@ \n  %@",_name,desc];
}

@end
