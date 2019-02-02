//
//  UserModel.h
//  photo
//
//  Created by admin on 17/3/27.
//  Copyright © 2017年 poco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject <NSCopying>

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, assign) NSInteger sex; // 0:保密 1：男  2：女
@property (nonatomic, copy) NSString *signature;
@property (nonatomic, copy) NSString *domain;
@property (nonatomic, strong) NSMutableDictionary *avatars;
@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *locationId;
@property (nonatomic, copy) NSString *locationName;

@property (nonatomic, assign) NSInteger isBestPocoer;// 是否红人(根据visited_user_identity_info.certify_list计算得到)
@property (nonatomic, assign) NSInteger user_famous_sign;//是否名人(根据visited_user_identity_info.certify_list计算得到)
@property (nonatomic, assign) NSInteger relation;

@property (nonatomic, assign) NSInteger actCnt;
@property (nonatomic, assign) NSInteger followCnt;
@property (nonatomic, assign) NSInteger fansCnt;
@property (nonatomic, assign) NSInteger medalCnt;
@property (nonatomic, assign) NSInteger collectCnt;
@property (nonatomic, assign) NSInteger collectTopicCnt;

@property (nonatomic, strong) NSMutableDictionary *coverSpaceImgUrls;
@property (nonatomic, copy) NSString *coverImg;
@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, strong) NSDictionary *user_identify_info;


- (BOOL)isNullModel;

- (BOOL)isValidUser;

@end
