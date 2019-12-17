//
//  NSString+EnnoHashes.h
//  EnnoCRM
//
//  Created by Zouwanli on 8/15/16.
//  Copyright © 2016 Zouwanli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EnnoHashes)

/**
 * 返回md5字符串
 */
- (NSString *)md5;

/**
 * 返回share1字符串
 */
- (NSString *)share1;

/**
 * 返回share256字符串
 */

- (NSString *)share256;

/**
 * 返回share512字符串
 */

- (NSString *)share512;

@end
