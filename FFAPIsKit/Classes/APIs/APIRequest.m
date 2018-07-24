//
//  BaseAPIRequest.m
//  FlowerField
//
//  Created by kepuna on 2017/9/5.
//  Copyright © 2017年 Triangle. All rights reserved.
//

#import "APIRequest.h"
#import "DBManager.h"
#import "FFHelper.h"

@implementation APIRequest

- (instancetype)init {
    self = [super init];
    if ([self conformsToProtocol:@protocol(APIRequestProtocol)]) {
        
        self.request = (id<APIRequestProtocol>)self;
        self.method = POST;
        [self apiRuquest];
    } else {
        // 不遵守这个protocol的就让他crash，防止派生类乱来。
        NSAssert(NO, @"子类必须要实现APIManager这个protocol");
    }
    return self;
}

- (void)apiRuquest {
    
    NSString *url = [self.request apiRequestURL];
    NSDictionary *params = [self.request apiRequestParams];
    NSString *cacheKey = [FFHelper connectBaseUrl:url params:params.mutableCopy];
    
    [[NetworkHelper sharedInstance] requestMethod:self.method url:url parameters:params finishBlock:^(id data, NSError *error) {
        if (error) {
            NSDictionary *cacheData = nil;
            if (params
                && params[@"action"]
                && [params[@"action"] isEqualToString:@"topArticleAuthor"]) {
                cacheData = [self testAuthorData];
            }
            else{
             cacheData = [self testSpecialData];// [[DBManager sharedManager] itemWithCacheKey:cacheKey];
            }
            
            if (!cacheData) {
                self.responseError = error;
                return;
            }
            [self successCallBack:cacheData];
            return;
        }
        [self successCallBack:data];
        if (self.isCache) {
             [[DBManager sharedManager] insertItem:data cacheKey:cacheKey];
        }
    }];
}

- (void)successCallBack:(NSDictionary *)data {
    self.responseData  = data;
    if ([self.delegate respondsToSelector:@selector(apiResponseSuccess:)]) {
        [self.delegate apiResponseSuccess:self.request];
    }
}

- (NSDictionary *)testSpecialData
{
    NSString *data = @"{  \
    \"result\": [{ \
    \"desc\": \"哈哈哈，，就差个猴了，配音无敌了\",\
    \"fnCommentNum\": 500, \
    \"favo\": 20,  \
    \"id\": \"653214\",\
    \"read\": 1000,  \
    \"share\": 50,  \
    \"smallIcon\": \"http://t11.baidu.com/it/u=1998236083,4012277056&fm=76\",\
    \"title\": \"哈哈哈，，就差个猴了，配音无敌了\",\
    \"kSpecialPropertyListKeyAuthorIdentity\": \"大V\",\
    \"category\":{ \
    \"name\": \"网友爆料\"  \
} ,\
    \"author\" : {  \
    \"headImg\":\"http://img.pccoo.cn/my/img/secai/01.jpg\", \
    \"userName\":\"猪小乐\", \
    \"newAuth\":1 \
    }\
    },\
    { \
    \"desc\": \"哈哈哈，，就差个猴了，配音无敌了\",\
    \"fnCommentNum\": 500, \
    \"favo\": 20,  \
    \"id\": \"653214\",\
    \"read\": 1000,  \
    \"share\": 50,  \
    \"smallIcon\": \"http://t11.baidu.com/it/u=1998236083,4012277056&fm=76\",\
    \"title\": \"哈哈哈，，就差个猴了，配音无敌了\",\
    \"kSpecialPropertyListKeyAuthorIdentity\": \"大V\",\
    \"category\":{ \
    \"name\": \"网友爆料\"  \
} ,\
    \"author\" : {  \
    \"headImg\":\"http://img.pccoo.cn/my/img/secai/01.jpg\", \
    \"userName\":\"猪小乐\", \
    \"newAuth\":1 \
    }\
    },\
    { \
    \"desc\": \"哈哈哈，，就差个猴了，配音无敌了\",\
    \"fnCommentNum\": 500, \
    \"favo\": 20,  \
    \"id\": \"653214\",\
    \"read\": 1000,  \
    \"share\": 50,  \
    \"smallIcon\": \"http://t11.baidu.com/it/u=1998236083,4012277056&fm=76\",\
    \"title\": \"哈哈哈，，就差个猴了，配音无敌了\",\
    \"kSpecialPropertyListKeyAuthorIdentity\": \"大V\",\
    \"category\":{ \
    \"name\": \"网友爆料\"  \
} ,\
    \"author\" : {  \
    \"headImg\":\"http://img.pccoo.cn/my/img/secai/01.jpg\", \
    \"userName\":\"猪小乐\", \
    \"newAuth\":1 \
    }\
    },\
    { \
    \"desc\": \"哈哈哈，，就差个猴了，配音无敌了\",\
    \"fnCommentNum\": 500, \
    \"favo\": 20,  \
    \"id\": \"653214\",\
    \"read\": 1000,  \
    \"share\": 50,  \
    \"smallIcon\": \"http://t11.baidu.com/it/u=1998236083,4012277056&fm=76\",\
    \"title\": \"哈哈哈，，就差个猴了，配音无敌了\",\
    \"kSpecialPropertyListKeyAuthorIdentity\": \"大V\",\
    \"category\":{ \
    \"name\": \"网友爆料\"  \
} ,\
    \"author\" : {  \
    \"headImg\":\"http://img.pccoo.cn/my/img/secai/01.jpg\", \
    \"userName\":\"猪小乐\", \
    \"newAuth\":1 \
    }\
    },\
    { \
    \"desc\": \"哈哈哈，，就差个猴了，配音无敌了\",\
    \"fnCommentNum\": 500, \
    \"favo\": 20,  \
    \"id\": \"653214\",\
    \"read\": 1000,  \
    \"share\": 50,  \
    \"smallIcon\": \"http://t11.baidu.com/it/u=1998236083,4012277056&fm=76\",\
    \"title\": \"哈哈哈，，就差个猴了，配音无敌了\",\
    \"kSpecialPropertyListKeyAuthorIdentity\": \"大V\",\
    \"category\":{ \
    \"name\": \"网友爆料\"  \
    } ,\
    \"author\" : {  \
    \"headImg\":\"http://img.pccoo.cn/my/img/secai/01.jpg\", \
    \"userName\":\"猪小乐\", \
    \"newAuth\":1 \
    }\
    },\
    { \
    \"desc\": \"哈哈哈，，就差个猴了，配音无敌了\",\
    \"fnCommentNum\": 500, \
    \"favo\": 20,  \
    \"id\": \"653214\",\
    \"read\": 1000,  \
    \"share\": 50,  \
    \"smallIcon\": \"http://t11.baidu.com/it/u=1998236083,4012277056&fm=76\",\
    \"title\": \"哈哈哈，，就差个猴了，配音无敌了\",\
    \"kSpecialPropertyListKeyAuthorIdentity\": \"大V\",\
    \"category\":{ \
    \"name\": \"网友爆料\"  \
    } ,\
    \"author\" : {  \
    \"headImg\":\"http://img.pccoo.cn/my/img/secai/01.jpg\", \
    \"userName\":\"猪小乐\", \
    \"newAuth\":1 \
}\
    }\
    ]\
    }";
    
    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}

- (NSDictionary *)testAuthorData
{
    NSString *data = @"{  \
    \"result\": [{  \
    \"headImg\":\"http://img.pccoo.cn/my/img/secai/01.jpg\", \
    \"userName\":\"猪小乐\", \
    \"newAuth\":1 \
    },\
    {  \
    \"headImg\":\"http://img.pccoo.cn/my/img/secai/01.jpg\", \
    \"userName\":\"猪小乐\", \
    \"newAuth\":1 \
    },\
    {  \
    \"headImg\":\"http://img.pccoo.cn/my/img/secai/01.jpg\", \
    \"userName\":\"猪小乐\", \
    \"newAuth\":1 \
    } ,\
    {  \
    \"headImg\":\"http://img.pccoo.cn/my/img/secai/01.jpg\", \
    \"userName\":\"猪小乐\", \
    \"newAuth\":1 \
    },\
    {  \
    \"headImg\":\"http://img.pccoo.cn/my/img/secai/01.jpg\", \
    \"userName\":\"猪小乐\", \
    \"newAuth\":1 \
    },\
    {  \
    \"headImg\":\"http://img.pccoo.cn/my/img/secai/01.jpg\", \
    \"userName\":\"猪小乐\", \
    \"newAuth\":1 \
    },\
    {  \
    \"headImg\":\"http://img.pccoo.cn/my/img/secai/01.jpg\", \
    \"userName\":\"猪小乐\", \
    \"newAuth\":1 \
    }\
    ]\
    }";
    
    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}

@end
