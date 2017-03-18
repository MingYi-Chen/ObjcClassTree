//
//  main.m
//  ObjcClassTree
//
//  Created by Ming Yi Chen on 13/03/2017.
//  Copyright © 2017 Ming Yi Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClassManager.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...        
        
        NSString* filePath = @"log3";
        NSString* fileRoot = [[NSBundle mainBundle] pathForResource:filePath ofType:@"txt"];
        NSString* outfilePath = @"desc.txt";
        
        // read everything from text
        NSString* fileContents =
        [NSString stringWithContentsOfFile:fileRoot
                                  encoding:NSUTF8StringEncoding error:nil];
        ClassManager *manager = [[ClassManager alloc] initWithString:fileContents];
        NSString* desc = [manager classDescription];
        
        [desc writeToFile:outfilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    return 0;
}
