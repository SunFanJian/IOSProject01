//
//  LoginController.m
//  HK_Sensor
//
//  Created by Experimental Computer on 2018/4/3.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "LoginController.h"
//#import "LXDTabBarController.h"
//#import "SwitchLanguage.h"

@interface LoginController ()

//输入控件
@property(nonatomic,weak)UITextField *userTxt;
@property(nonatomic,weak)UITextField *pwdTxt;
@property(nonatomic,weak)UIButton *loginBtn;
//存放用户名密码
@property(nonatomic , copy)NSString *name;
@property(nonatomic , copy)NSString *password;

//标记当前标签，以索引找到XML文件内容
@property (nonatomic, copy) NSString *currentElement;

//HUD控件
@property(nonatomic , weak)MBProgressHUD *mbHUD;

@end

@implementation LoginController

@synthesize loginNet;
@synthesize sfjParser;

- (void)viewDidLoad {
    [super viewDidLoad];
   
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView) name:@"changeLanguage" object:nil];
    
    [self createLoginView]; //初始化界面
    
    //接口类
    loginNet = [LXDNet getInstance];
    loginNet.Netdelegate = self;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"登录";
    hud.hidden = YES;
    self.mbHUD = hud;
    
    sfjParser = [SFJXMLParser getInstance];
    sfjParser.SFJXMLdelegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshView
{
    NSLog(@"切换语言刷新界面");
    
//    self.userTxt.placeholder = [NSString changeLanguage:@"AccountTxt"];
//    self.pwdTxt.placeholder = [NSString changeLanguage:@"PwdTxt"];
//    [self.loginBtn setTitle:[NSString changeLanguage:@"Login"] forState:UIControlStateNormal];
//    self.mbHUD.label.text = [NSString changeLanguage:@"Loging"];
    
}
//切换语言
-(void)changeLanguage:(UIButton *)change
{
//    NSString *language = [SwitchLanguage userLanguage];
//    NSLog(@"%@",language);
//    if([language isEqualToString:@"en"])
//    {
//        [SwitchLanguage setUserLanguage:@"zh-Hans"];    //切换语言
//        [change setBackgroundImage:[UIImage imageNamed:@"ce"] forState:UIControlStateNormal];
//        [change setBackgroundImage:[UIImage imageNamed:@"toggle.9"] forState:UIControlStateSelected];
//    }
//    else
//    {
//        [SwitchLanguage setUserLanguage:@"en"];
//        [change setBackgroundImage:[UIImage imageNamed:@"ec"] forState:UIControlStateNormal];
//        [change setBackgroundImage:[UIImage imageNamed:@"engchi"] forState:UIControlStateSelected];
//    }
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLanguage"object:self];
}
-(void)createLoginView
{
    UIImageView *backView = [[UIImageView alloc]initWithFrame:self.view.frame];
    backView.image = [UIImage imageNamed:@"LoginBack"];
    [self.view addSubview:backView];
    
    //创建纯色背景
//    UIView *bgView = [[UIView alloc]initWithFrame:self.view.frame];
//    bgView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.2];
//    [self.view addSubview:bgView];
    
  /*  UIButton *lBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 50, 30)];
    NSString *language = [SwitchLanguage userLanguage];
    
    if([language isEqualToString:@"en"])
    {
        [lBtn setBackgroundImage:[UIImage imageNamed:@"ec"] forState:UIControlStateNormal];
        [lBtn setBackgroundImage:[UIImage imageNamed:@"engchi"] forState:UIControlStateSelected];
    }
    else
    {
        [lBtn setBackgroundImage:[UIImage imageNamed:@"ce"] forState:UIControlStateNormal];
        [lBtn setBackgroundImage:[UIImage imageNamed:@"toggle.9"] forState:UIControlStateSelected];
    }
    [lBtn addTarget:self action:@selector(changeLanguage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lBtn];*/
    
    UIImageView *userImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, kScreenHeight/3-10, 25, 25)];
    userImage.image = [UIImage imageNamed:@"用户名"];
    [self.view addSubview:userImage];
    
    UITextField *userTxt = [[UITextField alloc]initWithFrame:CGRectMake(75, kScreenHeight/3 - 10, kScreenWidth - 95, 30)];
    userTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    userTxt.placeholder = @"用户名";
    userTxt.keyboardType = UIKeyboardTypeEmailAddress;
    [self.view addSubview:userTxt];
    self.userTxt = userTxt;
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(30, kScreenHeight/3 + 30, kScreenWidth - 60, 1)];
    line1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line1];
    
    UIImageView *pwdImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, kScreenHeight/3 + 50, 25, 25)];
    pwdImage.image = [UIImage imageNamed:@"密码"];
    [self.view addSubview:pwdImage];
    
    UITextField *pwdTxt = [[UITextField alloc]initWithFrame:CGRectMake(75, kScreenHeight/3 + 50, kScreenWidth - 95, 30)];
    pwdTxt.clearButtonMode =UITextFieldViewModeWhileEditing;
    pwdTxt.secureTextEntry = YES;
    pwdTxt.placeholder = @"密码";
    pwdTxt.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:pwdTxt];
    self.pwdTxt = pwdTxt;
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(30, kScreenHeight/3 + 90, kScreenWidth - 60, 1)];
    line2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line2];
    
    UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake(30, kScreenHeight/3 + 150, kScreenWidth - 60, 50)];
    [loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    
    loginButton.backgroundColor = [UIColor orangeColor];
    loginButton.layer.masksToBounds = YES;
     [loginButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#9F0000"]] forState:UIControlStateHighlighted];
    loginButton.titleLabel.textAlignment = 1;
    loginButton.layer.cornerRadius = 20;
    loginButton.titleLabel.font = [UIFont systemFontOfSize:23];
    [loginButton addTarget:self action:@selector(userLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    self.loginBtn = loginButton;
    
    UILabel *copyrightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight - HOME_INDICATOR_HEIGHT - 30, kScreenWidth, 30)];
    copyrightLabel.textAlignment = 1;
    copyrightLabel.font = [UIFont systemFontOfSize:10];
    copyrightLabel.numberOfLines = 0;
    copyrightLabel.lineBreakMode = NSLineBreakByWordWrapping;
    copyrightLabel.text = @"Copyright © 2017 Luxon Data\n Information Technologies (Suzhou) Ltd.";
    [self.view addSubview:copyrightLabel];
}

//点击屏幕 隐藏键盘
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//}

//点击登录
-(void)userLogin:(UIButton *)loginBtn
{
    
//    _name = self.userTxt.text;
//    _password = self.pwdTxt.text;
//    self.mbHUD.hidden = NO;
//
//    [loginNet loadbyAccount:_name andPassword:_password];  //登录
}

-(void)createRootVC
{
//    LXDTabBarController *tab = [[LXDTabBarController alloc]init];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    window.rootViewController = tab;
}

#pragma LXDDelegate
//请求成功
-(void)getSuccessInfo:(id)loginBackInfo
{
    self.mbHUD.hidden = YES;
    
    [sfjParser startParser:loginBackInfo withElement:@"VerifyAccountResult"];  //准备解析数据
}

-(void)getFailInfo:(id)loginBackInfo
{
    self.mbHUD.hidden = YES;
    NSLog(@"2.登陆失败");
    UIAlertController *failAlert = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"请检查网络" preferredStyle:1];
    [failAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        //
    }]];
    [self presentViewController:failAlert animated:YES completion:nil];
}

#pragma 解析登录请求结果
-(void)returnBackResult:(NSString *)resultStr
{
    //验证通过
    if([resultStr intValue] == 1)
    {
        //1、登陆跳转
        [self createRootVC];
        
        //2、保存账号密码
        LXDAccount *account=[[LXDAccount alloc]init];
        account.accountName=_name;
        account.password=_password;
        // NSLog(@"保存成功%@----%@",account.accountName,account.password);
        [LXDAccountTool saveAccount:account];   //保存
    }
    else        //验证失败
    {
        NSLog(@"1.登陆失败");

    }
}

@end
