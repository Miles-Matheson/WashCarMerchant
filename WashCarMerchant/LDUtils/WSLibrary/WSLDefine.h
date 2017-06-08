//
//  WSLDefine.h
//  WiseSeller
//
//  Created by steven on 14-4-28.
//  Copyright (c) 2014年 steven. All rights reserved.
//

#ifndef WiseSeller_WSLDefine_h
#define WiseSeller_WSLDefine_h

//  Device 类型
//////////////////////////////////////////////////

/**
 *	@brief	当前设备是否为iPhone.
 */
#define WSLDeviceIsPhone [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

/**
 *	@brief	当前设备是否为iPad.
 */
#define WSLDeviceIsPad [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad

//  Frame
//////////////////////////////////////////////////

/**
 *	@brief	矩形框.
 */
#define WSLFrameAll(x,y,w,h) CGRectMake(x, y, w, h)

/**
 *	@brief	坐标为(0, 0)的矩形框.
 */
#define WSLFrame(w,h) WSLFrameAll(0,0,w,h)

/**
 *	@brief	完整填充frame的矩形框.
 */
#define WSLFrameAllInset(frame) WSLFrame(frame.size.width,frame.size.height)

/**
 *	@brief	以inset填充矩形框.
 */
#define WSLFrameInset(frame,inset) CGRectMake(inset.left, inset.top, frame.size.width - inset.left - inset.right, frame.size.height - inset.top - inset.bottom)

//  Font
//////////////////////////////////////////////////

/**
 *	@brief	系统字体.
 */
#define WSLFontSys(_size) [UIFont systemFontOfSize:_size]

/**
 *  @brief  加粗系统字体.
 */
#define WSLFontBoldSys(_size) [UIFont boldSystemFontOfSize:_size]

// Color
//////////////////////////////////////////////////

// RGB颜色.
#define WSLColor(r,g,b) WSLColorRGBA(r,g,b,1.0)
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define ws(weakSelf)  WS(weakSelf);
// RGBA颜色.
#define WSLColorRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// 十六进制颜色.
#define WSLColorHex(hex) [WSLColor colorWithHex:hex]

#define WS_Height_TabSection 29

#define WS_Color_Line WSLColorHex(@"e4e4e4")

#define HeiTiSize(_size) WSLFontSys(_size/2)//[UIFont fontWithName:@"STHeitiTC-Medium" size:(sz)/2]

// Height
//////////////////////////////////////////////////
/**
 *	@brief	状态栏高度.
 */
#define WS_Height_StatusBar 20.f

/**
 *	@brief	键盘高度.
 */
#define WS_Height_KeyBoard 316.f

/**
 *	@brief	页面背景颜色.
 */
#define WS_Color_Bg WSLColorHex(@"#F0F0F0")
#define WS_Height_Line 0.5
#define WS_Height_CellHidden 0.1

#define WS_Color_333333 WSLColorHex(@"#333333")
#define WS_Color_666666 WSLColorHex(@"#666666")

#define RandomColor [WSUtils randomColor]
#endif
