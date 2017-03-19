//
//  main.m
//  ObjcClassTree
//
//  Created by Ming Yi Chen on 13/03/2017.
//  Copyright © 2017 Ming Yi Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClassManager.h"

//#define  debug

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...        
        
#ifdef debug
        NSString* filePath = @"input";
        NSString* fileContent = [[NSBundle mainBundle] pathForResource:filePath ofType:@"txt"];
        NSString* outfilePath = @"desc.txt";
        fileContent = [NSString stringWithContentsOfFile:fileContent encoding:NSUTF8StringEncoding error:nil];
#else
        
        NSArray* arguments = [[NSProcessInfo processInfo] arguments];
        
//        [arguments enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSObject* obj1 = (NSObject*)obj;
//            NSLog(@"%@ \n", obj1.description);
//        }];
        
        NSString* filePath = arguments[1];
        NSString* outfilePath = arguments[2];
        NSString* fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];;
        
#endif
        
        // read everything from text
        ClassManager *manager = [[ClassManager alloc] initWithString:fileContent];
        NSString* desc = [manager classDescription];
//        NSLog(@"%@",desc);
        
        [desc writeToFile:outfilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    return 0;
}
