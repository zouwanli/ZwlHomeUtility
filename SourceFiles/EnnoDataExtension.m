//
//  EnnoDataExtension.m
//  EnnoCRM
//
//  Created by Zouwanli on 8/15/16.
//  Copyright © 2016 Zouwanli. All rights reserved.
//

#import "EnnoDataExtension.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "NSString+EnnoHashes.h"

@implementation EnnoDataExtension

@end


@implementation NSData (ZZJSON)

// Create a Foundation object from JSON data
- (id)zz_JSONObject {
    if (!self) {
        return nil;
    }
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:self
                                                options:NSJSONReadingMutableLeaves
                                                  error:&error];
    if (error) {
        NSLog(@"Deserialized JSON string failed with error message '%@'.",
                [error localizedDescription]);
    }
    
    return object;
}

// Generate JSON data from a Foundation object
+ (NSData *)zz_dataWithJSONObject:(id)object {
    if (!object) {
        return nil;
    }
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    if (error) {
        NSLog(@"Serialized JSON string failed with error message '%@'.",
                [error localizedDescription]);
        
        
    }
    return data;
}

// Generate an JSON data from a property list
+ (NSData *)zz_dataWithPropertyList:(id)plist {
    NSError *error = nil;
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:plist
                                                              format:NSPropertyListXMLFormat_v1_0
                                                             options:0
                                                               error:&error];
    if (error) {
        NSLog(@"Serialized PropertyList string failed with error message '%@'.",
                [error localizedDescription]);
    }
    return data;
}

@end

@implementation NSData (ZZEncoding)

// Generate UTF-8 string from data
- (NSString *)zz_UTF8String {
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

// Generate ASCII string form data
- (NSString *)zz_ASCIIString {
    return [[NSString alloc] initWithData:self encoding:NSASCIIStringEncoding];
}

// Generate ISOLatin1 string form data
- (NSString *)zz_ISOLatin1String {
    return [[NSString alloc] initWithData:self encoding:NSISOLatin1StringEncoding];
}


@end

@implementation NSData (NSDataAesAddition)

- (NSData *)zz_AES256EncryptWithKey:(NSString *)key {
    //AES256加密，密钥应该是32位的
    NSData *keyData = [[[key md5] uppercaseString] dataUsingEncoding:NSUTF8StringEncoding];
    const void *keyPtr2 = [keyData bytes];
    const char (*keyPtr)[32] = keyPtr2;
    
    //对于块加密算法，输出大小总是等于或小于输入大小加上一个块的大小
    //所以在下边需要再加上一个块的大小
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding/*这里就是刚才说到的PKCS7Padding填充了*/ | kCCOptionECBMode,
                                          keyPtr,
                                          kCCKeySizeAES256,
                                          NULL,/* 初始化向量(可选) */
                                          [self bytes],
                                          dataLength,/*输入*/
                                          buffer,
                                          bufferSize,/* 输出 */
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);//释放buffer
    return nil;
}

- (NSData *)zz_AES256DecryptWithKey:(NSString *)key {
    //同理，解密中，密钥也是32位的
    NSData *keyData = [[[key md5] uppercaseString] dataUsingEncoding:NSUTF8StringEncoding];
    const void *keyPtr2 = [keyData bytes];
    const char (*keyPtr)[32] = keyPtr2;
    
    //对于块加密算法，输出大小总是等于或小于输入大小加上一个块的大小
    //所以在下边需要再加上一个块的大小
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding/*这里就是刚才说到的PKCS7Padding填充了*/ | kCCOptionECBMode,
                                          keyPtr,
                                          kCCKeySizeAES256,
                                          NULL,/* 初始化向量(可选) */
                                          [self bytes],
                                          dataLength,/* 输入 */
                                          buffer,
                                          bufferSize,/* 输出 */
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}

#pragma mark - 项目用的这种加密方式

- (NSData *)zz_AES128EncryptWithKey:(NSString *)key {
    return [NSData pr_transform:kCCEncrypt data:self cipherKey:key];
}

- (NSData *)zz_AES128DecryptWithKey:(NSString *)key {
    return [NSData pr_transform:kCCDecrypt data:self cipherKey:key];
}

+ (NSData *)pr_transform:(CCOperation)encryptOrDecrypt data:(NSData *)inputData cipherKey:(NSString *)cipherKey {
    NSData *secretKey = [NSData pr_md5:cipherKey];
    CCCryptorRef cryptor = NULL;
    CCCryptorStatus status = kCCSuccess;
    
    uint8_t iv[kCCBlockSizeAES128];
    memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    status = CCCryptorCreate(encryptOrDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                             [secretKey bytes], kCCKeySizeAES128, iv, &cryptor);
    
    if (status != kCCSuccess) {
        return nil;
    }
    
    size_t bufsize = CCCryptorGetOutputLength(cryptor, (size_t)[inputData length], true);
    
    void * buf = malloc(bufsize * sizeof(uint8_t));
    memset(buf, 0x0, bufsize);
    
    size_t bufused = 0;
    size_t bytesTotal = 0;
    
    status = CCCryptorUpdate(cryptor, [inputData bytes], (size_t)[inputData length],
                             buf, bufsize, &bufused);
    
    if (status != kCCSuccess) {
        free(buf);
        CCCryptorRelease(cryptor);
        return nil;
    }
    
    bytesTotal += bufused;
    
    status = CCCryptorFinal(cryptor, buf + bufused, bufsize - bufused, &bufused);
    
    if (status != kCCSuccess) {
        free(buf);
        CCCryptorRelease(cryptor);
        return nil;
    }
    
    bytesTotal += bufused;
    
    CCCryptorRelease(cryptor);
    
    return [NSData dataWithBytesNoCopy:buf length:bytesTotal];
}

+ (NSData *)pr_md5:(NSString *)string {
    const char *src = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(src, (unsigned int)strlen(src), result);
    
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

@end
