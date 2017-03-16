//
//  ClassNode.h
//  ObjcClassTree
//
//  Created by Ming Yi Chen on 13/03/2017.
//  Copyright © 2017 Ming Yi Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassNode : NSObject
- (instancetype)initWithClassName:(NSString*)name subclasses:(NSString*)subclase;
- (BOOL)compareAndCombineWithClass:(ClassNode*)node;
- (NSString*) descriptionWithLvl:(NSInteger)level;
@end
