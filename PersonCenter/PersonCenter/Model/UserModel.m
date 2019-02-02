//
//  UserModel.m
//  photo
//
//  Created by zhuoyu on 17/3/27.
//  Copyright © 2019年 ColorFish All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (BOOL)isNullModel {
    return self.userId >0 ? NO : YES;
}

- (BOOL)isValidUser {
    return self.userId > 0 ? YES : NO;
}


#pragma mark- NSCopying
- (instancetype)copyWithZone:(NSZone *)zone {
    UserModel *user = [[[self class] allocWithZone:zone] init];
    user.userId = self.userId;
    user.nickname = self.nickname;
    user.gender = self.gender;
    user.avatars = self.avatars;
    user.locationName = self.locationName;
    user.locationId = self.locationId;
    user.relation = self.relation;
    user.actCnt = self.actCnt;
    user.followCnt = self.followCnt;
    user.fansCnt = self.fansCnt;
    user.medalCnt = self.medalCnt;
    user.collectCnt = self.collectCnt;
    user.collectTopicCnt = self.collectTopicCnt;
    
    user.signature = self.signature;
    user.coverSpaceImgUrls = self.coverSpaceImgUrls;
    
    return user;
}
- (void)dealloc{
    
}
@end
