//
//  RequestUrlDefs.h
//  LookFor
//
//  Created by chenlei on 15/1/7.
//  Copyright (c) 2015年 chenmingguo. All rights reserved.
//

#ifndef LookFor_RequestUrlDefs_h
#define LookFor_RequestUrlDefs_h

//服务器WEB地址
#define API_HOST                @"http://182.92.241.249"

//拼接字符串
#define MAKE_URL_STRING(inf)    [NSString stringWithFormat:@"%@%@",API_HOST,inf]

//登录服务器
#define LOGIN_SYSTEM_URL        MAKE_URL_STRING(@"/lookfor/rest/user/systemLogin")

//注册
#define REGISTER_URL            MAKE_URL_STRING(@"/lookfor/inter/user/regist")

//登录接口地址
#define LOGIN_URL               MAKE_URL_STRING(@"login.do")

//http://182.92.241.249/lookfor/inter/user/regist?mobile=15820790320&password=123456&token=46D1BE39C7B14DA6997AE3DBBE61DE94

//修改昵称
#define SET_NICKNAME_URL        MAKE_URL_STRING(@"/lookfor/inter/user/modifyNickName")


//获取好友列表
#define FRIEND_LIST_URL         @"http://www.xshcar.com/chen/friendList.html"
//@"http://192.168.2.160/wonhot/chenl/spi/4.0/friendList.xml"
//@"http://www.xshcar.com/chen/friendList.html"
//@"http://192.168.2.160/wonhot/chenl/spi/4.0/friendList.html"
//MAKE_URL_STRING(@"")

//获取好友详情
#define FRIEND_DETAIL_URL       @"http://www.xshcar.com/chen/friendDetail.html"
//@"http://192.168.2.160/wonhot/chenl/spi/4.0/friendDetail.xml"
////@"http://192.168.2.160/wonhot/chenl/spi/4.0/friendList.html"

#endif
