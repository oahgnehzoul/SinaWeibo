//
//  DataService.m
//  Weibo
//
//  Created by oahgnehzoul on 15/8/30.
//  Copyright (c) 2015年 oahgnehzoul. All rights reserved.
//

#import "DataService.h"
#import "AFNetworking.h"
#import "JSONKit.h"
@implementation DataService


+ (void)requestUrl:(NSString *)urlString httpMethod:(NSString *)method params:(NSMutableDictionary *)params block:(BlockType)block{
    //0.取得本地保存的token
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    NSString *accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
    
    //将token添加到请求参数中
    [params setObject:accessToken forKey:@"access_token"];
    
    //01 构建url
    
    NSString *fullString = [BaseUrl stringByAppendingString:urlString];
    NSURL *url = [NSURL URLWithString:fullString];
    
    
    //02 构造request
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:method];
    
    
    //03 拼接参数
    //>>01  name=郭杰&age=9
    
    NSArray *allKeys = [params allKeys];
    NSMutableString   *paramString = [[NSMutableString alloc] init];
    for (int i = 0; i<allKeys.count; i++) {
        
        NSString *key = allKeys[i];
        NSString *value = [params objectForKey:key];
        
        [paramString  appendFormat:@"%@=%@",key,value];
        
        if (i < allKeys.count-1) {
            [paramString appendString:@"&"];
        }
    }
    //>>02 JSON字符串
    //{name:guojie,age:9}
    //JSONKit 转换，目前 jsonkit 已经不更新，丢弃
//    NSString *jsonString = [params JSONString];
//    NSLog(@"%@",jsonString);
    
    //如果是 GET请求 ，则把参数拼接到url里面
    if ([method isEqualToString:@"GET"]) {
        //query url里面的参数
        NSString *seperation = url.query?@"&":@"?";
        NSString *paraUrlString = [NSString stringWithFormat:@"%@%@%@",fullString,seperation,paramString];
        
        request.URL = [NSURL URLWithString:paraUrlString];
        
    }else if([method isEqualToString:@"POST"]){
        //则把参数放到 body里
        
        NSData *data = [paramString dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        
    }
    
    //04 connection请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //数据接收完毕 处理数据
        if (connectionError != nil) {
            NSLog(@"网络请求失败 ");
        }
        
        //原生
        //  id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //jsonkit 解析
        id result = [data objectFromJSONData];
        
        
        //把数据传递给界面
        if (block) {
            block(result);
        }
        
        
    }];
    
}

+ (AFHTTPRequestOperation *)requestAFUrl:(NSString *)urlString httpMethod:(NSString *)method params:(NSMutableDictionary *)params data:(NSMutableDictionary *)datas block:(BlockType)block {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    NSString *accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
    
    [params setValue:accessToken forKey:@"access_token"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    if ([method isEqualToString:@"GET"]) {
        AFHTTPRequestOperation *operation =  [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            block(responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"传输失败 ");
            NSLog(@"%@",error);
        }];
        return  operation;
        
    }else if ([method isEqualToString:@"POST"]) {
        if (datas != nil) {
            AFHTTPRequestOperation *operation = [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                for (NSString *name in datas) {
                    NSData *data = [datas objectForKey:name];
                    [formData appendPartWithFileData:data name:name fileName:@"1.png" mimeType:@"image/jpeg"];
                }
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"图片上传成功");
                block(responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"图片上传失败");
            }];
            [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                NSLog(@"上传进度,已经上传 %lld",totalBytesWritten);
            }];
            return operation;
        }else { //不带图片
            AFHTTPRequestOperation *operation = [manager POST:urlString parameters:params success:^void(AFHTTPRequestOperation *operation , id responseObject ) {
                NSLog(@"POST成功");
                
                block(responseObject);
            } failure:^void(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
            return operation;
            
        }
       
    
    }
    return nil;

   
}
+ (AFHTTPRequestOperation *)sendWeibo:(NSString *)text image:(UIImage *)image block:(BlockType)block {
    if (!text ) {
        return  nil;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:text forKey:@"status"];
    if (image == nil) {
        return [DataService requestAFUrl:SendWeibo httpMethod:@"POST" params:params data:nil block:block];
    }
    NSData *data = UIImageJPEGRepresentation(image, 1);
    if (data.length > 1024*1024*2) {
        data = UIImageJPEGRepresentation(image, 0.5);
    }
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:data forKey:@"pic"];
    return [DataService requestAFUrl:SendWeiboWithImage httpMethod:@"POST" params:params data:dataDic block:block];
}
@end
