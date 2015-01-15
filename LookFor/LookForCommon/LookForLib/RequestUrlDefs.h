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
#define API_HOST                @"http://118.26.72.210:8481/"

//拼接字符串
#define MAKE_URL_STRING(inf)    [NSString stringWithFormat:@"%@%@",API_HOST,inf]

//登录接口地址
#define LOGIN_URL               MAKE_URL_STRING(@"login.do")

//获取好友列表
#define FRIEND_LIST_URL         @"http://www.xshcar.com/chen/friendList.html"
//@"http://192.168.2.160/wonhot/chenl/spi/4.0/friendList.html"
//MAKE_URL_STRING(@"")

//获取好友详情
#define FRIEND_DETAIL_URL       @"http://www.xshcar.com/chen/friendDetail.html"

#endif
