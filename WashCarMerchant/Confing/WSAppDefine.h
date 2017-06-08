//
//  WSAppDefine.h
//  WiseSeller
//
//  Created by steven on 14-4-28.
//  Copyright (c) 2014年 steven. All rights reserved.
//

#ifndef WiseSeller_WSAppDefine_h
#define WiseSeller_WSAppDefine_h

//#define MemberId    [LLUtils strRelay:[YKManager sharedManager].memberId]//读取用户id
#define MemberId    [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]? [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]:@""
// Count 常用计数
//////////////////////////////////////////////////
/**
 *	@brief	欢迎界面图片个数
 */
#define WS_Help_PicCount 4
/**
 *	@brief	分页大小.
 */
#define WS_List_PageSize 10
/**
 *	@brief	默认第一页页码.
 */
#define WS_List_DefaultPage_First 0

// 警告窗标题.
#define WSAlertView_Title @"提示"
// 返回成功标志
#define WSSuccess_Key @"resultCode"

// Height
//////////////////////////////////////////////////
/**
 *	@brief	状态栏高度.
 */
#define WS_Height_StatusBar                 20.f
/**
 *	@brief	Tab切换按钮高度.
 */
#define WS_Height_TabAct                    45.f
#define WS_Height_BottomAct                 50.f
/**
 *	@brief	Tab切换按钮宽度.
 */
#define WS_Width_TabAct                     84.f
#define WS_Height_DingDanBottomView         60.f


#define WS_Height_FormBottom                66.f
/**
 *	@brief	Cell距左右边距离.
 */
#define WS_CellPad_Value                    10.f

#define Icon_Height                         APP_CONTENT_HEIGHT_PRAM(50)
// Cell及Form颜色
//////////////////////////////////////////////////
/**
 *	@brief	WSFormIconCell的灰色
 */
#define WS_Color_Cell_Huise                 WSLColor(153, 153, 153)
/**
 *	@brief	黑色颜色.
 */
#define WS_Color_Cell_RadioBlack            WSLColor(51, 51, 51)
/**
 *	@brief	橙色颜色.
 */
#define WS_Color_Cell_BrownColor            WSLColor(255, 100, 15)

#define WS_Color_Btn_Huise                  WSLColor(203, 203, 203)
#define WS_Color_Bg_Red                     WSLColor(228, 68, 9)
#define WS_Color_Bg_Black                   WSLColor(21, 24, 26)
#define WS_Color_Huise_100ForTitleText      WSLColor(100, 100,100)
#define PlaceholderImage [UIImage imageNamed:@"placeholderImage"]

// select blue  Color
#define WS_Color_SelectBlue                 WSLColor(32, 188, 242)
/**
 *	@brief	默认显示图片.
 */
#define WS_Pic_PlaceHolder                  @""
#define WS_Pic_FilePath                     @"filePath"
#define WS_Pic_BtnType                      @"btnType"

#define PlaceHolderImageName                @"loadwaiting"
#define NoNetTips                           @"无法连接网络\n轻触屏幕重新加载"
#define NoNetImage                          @"nonet"
#define searchCellHeight                    35

#define RC0001 if ([json[@"code"] isEqualToString:@"10000"]) {}else{[[UIApplication sharedApplication].keyWindow showCenterToast:json[@"msg"]];return;}

#define Success if ([json[@"code"] isEqualToString:@"10000"]) {}else{[[UIApplication sharedApplication].keyWindow showCenterToast:json[@"msg"]];}

#endif
