//
//  EnnoDataExtension.h
//  EnnoCRM
//
//  Created by Zouwanli on 8/15/16.
//  Copyright © 2016 Zouwanli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnnoDataExtension : NSObject

@end


@interface NSData (ZZJSON)

/**
 *  Create a Foundation object from JSON data
 *
 *  @return Foundation object
 */
- (id)zz_JSONObject;

/**
 *  Generate JSON data from a Foundation object
 *
 *  @param object Foundation object
 *
 *  @return JSON data
 */
+ (NSData *)zz_dataWithJSONObject:(id)object;

/**
 *  Generate an JSON data from a property list
 *
 *  @param plist property list
 *
 *  @return JSON data
 */
+ (NSData *)zz_dataWithPropertyList:(id)plist;



@end

@interface NSData (ZZEncoding)

/**
 *  Generate UTF-8 string from data
 *
 *  @return UTF-8 string
 */
- (NSString *)zz_UTF8String;

/**
 *  Generate ASCII string form data
 *
 *  @return ASCII string
 */
- (NSString *)zz_ASCIIString;

/**
 *  Generate ISOLatin1 string form data
 *
 *  @return ISOLatin1 string
 */
- (NSString *)zz_ISOLatin1String;

@end

@interface NSData (NSDataAesAddition)


/**
 * 加密接口
 * @param key 加密key
 * return 返回加密之后的数据
 */

- (NSData *)zz_AES256EncryptWithKey:(NSString *)key;

/**
 * 解密接口
 * @param key 解密key
 * return 返回解密之后的数据
 */
- (NSData *)zz_AES256DecryptWithKey:(NSString *)key;

/**
 * 加密接口
 * @param key 加密key
 * return 返回加密之后的数据
 */
- (NSData *)zz_AES128EncryptWithKey:(NSString *)key;

/**
 * 解密接口
 * @param key 解密key
 * return 返回解密之后的数据
 */
- (NSData *)zz_AES128DecryptWithKey:(NSString *)key;
@end
