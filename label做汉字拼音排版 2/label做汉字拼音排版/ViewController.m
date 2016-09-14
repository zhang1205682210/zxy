//
//  ViewController.m
//  label做汉字拼音排版
//
//  Created by  张晓宇 on 16/8/15.
//  Copyright © 2016年 SH. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
   // label.backgroundColor = [UIColor redColor];
    
    //label的 行高
    int hh = 45;
    //默认label的宽度
    int ww = 42;
    //不同字体大小下的没一行显示的文字数目（label数）
    int pp = 38;
    NSString * string = @"《 无 wú   量 liàng   清 qīng   净 jìng   平 píng   等 děng   觉 jué   经 jīng   》   后 hòu   汉 hàn   支 zhī   娄 lóu   迦 jiā   识 shí   译 yì    《 佛 fó   说 shuō   诸 zhū   佛 fó   阿 ē   弥 mí   陀 tuó   三 sān   耶 yē   三 sān   佛 fó   萨 sà   楼 lóu   佛 fó   檀 tán   过 guò   度 dù   人 rén   道 dào   经 jīng   》  一 yī   名 míng   《 无 wú   量 liàng   寿 shòu   经 jīng   》 一 yī   名 míng   《 阿 ē   弥 mí   陀 tuó   经 jīng   》 吴 wú   支 zhī   谦 qiān   译 yì    《 无 wú   量 liàng   寿 shòu   经 jīng   》 曹 cáo   魏 wèi   康 kāng   僧 sēng   铠 kǎi   译 yì    《 无 wú   量 liàng   寿 shòu   如 rú   来 lái   会 huì   》 唐 táng   菩 pú   提 tí   流 liú   志 zhì   译 yì    《 佛 fó   说 shuō   大 dà   乘 chéng   无 wú   量 liàng   寿 shòu   庄 zhuāng   严 yán   经 jīng   》 赵 zhào   宋 sòng   法 fǎ   贤 xián   译 yì    自 zì   汉 hàn   迄 qì   宋 sòng   ， 同 tóng   经 jīng   异 yì   译 yì   可 kě   考 kǎo";
   
    NSArray * str = [string componentsSeparatedByString:@" "];
    //NSLog(@"%@",str);
    NSString * strqq = @"《";
//    if ([strqq isEqualToString:@"《"]) {
//        NSLog(@"yiyang");
//    }
    //设置每页开始加载的数组中的第几个元素
    int h = -1;
    int g = 0;
    NSMutableArray * mutableArr = [[NSMutableArray alloc]init];

    for (int i = 0; i < str.count; i++)
    {
        BOOL isF = [self isZhongWenFirst:str[i]];
        BOOL isB = [self isBiaoDianFuHao:str[i]];
        if (isB) {
            NSLog(@"ok");
        }
        else{
            NSLog(@"no");
        }
        
        if (isF !=0 && isB==0 )
        {

        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setValue:str[i] forKey:str[i+1]];
            g = g + 1;
        [mutableArr addObject:dic];
        }
        else if (isB != 0)
        {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
            [dic setValue:str[i] forKey:@" "];
            g = g+1;
            
            [mutableArr addObject:dic];
        }
            
        
       
     
    }
  
    //NSLog(@"%@",mutableArr);
        
    
   
        for (int q = 1; q < 13; q++)
        {
           
            for (int j = 1; j <= (self.view.frame.size.width - 20) / pp  ; j ++)
            {
                
             
                 h ++;
               
                if (h<mutableArr.count) {
                    
                
                for (NSString * key in mutableArr[h])
                {
                    
                                    NSLog(@"%d",h);
            
                NSString * string =[mutableArr[h] objectForKey:key] ;
                    //判断是否是标点符号   不能判断是否是回车 换行符等
                    BOOL isbiaodian = [self isBiaoDianFuHao:string];
                  
                    if (isbiaodian ==0)
                    {
                        ww = 42;
                    }
                    else
                    {
                        ww = 15;
                    }
                    int f ;
                    if (j == 1)
                    {
                        f = 0;
                    }
                   
                    
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(f + 8  , 20 + 45 * (q - 1) , ww, hh)];
                label.text = [NSString stringWithFormat:@"%@\n%@",key,[mutableArr[h] objectForKey:key]];
                
                label.textAlignment = UITextAlignmentCenter;
                label.lineBreakMode =UILineBreakModeWordWrap;
              //label.backgroundColor = [UIColor redColor];
                label.numberOfLines = 0;
                [self.view addSubview:label];
                    
                 f = f + ww;
                    NSLog(@"fffffff%d",f);
                        
                }
              
                }
                
            }
          
        }

   // label.textAlignment = UITextAlignmentCenter;
   
}
#pragma mark 正则表达式／判断第一个是否以中文开头的方法
-(BOOL)pipeizimu:(NSString *)str
{
    //判断是否以字母开头
    NSString *ZIMU = @"/^[a-zA-z]/";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
    
    if ([regextestA evaluateWithObject:str] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//判断字符创是否是中文开头的
-(BOOL)isZhongWenFirst:(NSString *)firstStr
{
    //是否以中文开头(unicode中文编码范围是0x4e00~0x9fa5)
    int utfCode = 0;
    void *buffer = &utfCode;
    NSRange range = NSMakeRange(0, 1);
    //判断是不是中文开头的,buffer->获取字符的字节数据 maxLength->buffer的最大长度 usedLength->实际写入的长度，不需要的话可以传递NULL encoding->字符编码常数，不同编码方式转换后的字节长是不一样的，这里我用了UTF16 Little-Endian，maxLength为2字节，如果使用Unicode，则需要4字节 options->编码转换的选项，有两个值，分别是NSStringEncodingConversionAllowLossy和NSStringEncodingConversionExternalRepresentation range->获取的字符串中的字符范围,这里设置的第一个字符 remainingRange->建议获取的范围，可以传递NULL
    BOOL b = [firstStr getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
    if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5))
        return YES;
    else
        return NO;
}
//判断字符串是否是标点符号
-(BOOL)isBiaoDianFuHao:(NSString *)biaodian
{
    NSString * string = @"》《 ？“：{}+——）（*—……%￥#·！，。/；‘[]|、=-";
   // NSArray  * arr= [string componentsSeparatedByString:@" "];
    
   
    
 
        if ([string rangeOfString:biaodian].location != NSNotFound)
        {

            return YES;
           
        }
        else
        {
           
            return NO;
        }
 
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
