//
//  AFNetWW.h
//  zhitongti
//
//  Created by yuhongtao on 16/7/27.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^success)(id);
typedef void(^fail)(id);

@interface AFNetWW : NSObject

+ (AFNetWW *)sharedAFNetWorking;

-(void)AFWithPostORGet:(NSString *)post withURLStr:(NSString *)url WithParameters:(NSDictionary *)parameters success:(void (^)(id responseDic))success fail:(void (^)(NSError *error))fail;

- (AFHTTPRequestOperationManager *) getAFNManager;

@property(nonatomic,assign)success success;

@end
