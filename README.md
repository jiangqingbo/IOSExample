# iOS开发学习笔记


### 1、学习iOS中6种传值的方法

	1.属性传值
	2.单例传值
	3.NSUserDefaults传值
	4.代理传值
	5.block传值
	6.通知传值（NSNotification）
	
### 2、学习iOS中的字符串类型

	1、NSMutableString
	2、NSRange
	3、NSArray
	4、NSString
	
### 3、学习网络请求基本方法

	1、GET方法
	2、POST方法
	3、自定义UIColorUtils工具类
	4、UIImageView加载工程本地图片显示
	
### 4、json数据解析总结

	1. 优先使用iOS自带解析器。
		1）自带解析器（类方法）	类名：NSJSONSerialization	方法：JSONObjectWithData: option:NSJSONReadingAllowFragments error:
		2）JSONKit		类名：JSONDecoder		方法：objectWithData:
		3）TouchJson		类名：CJSONDeserializer		方法：deserialize: error:
		4）SBJson		类名：SBJsonParser		方法：objectWithData:
		
	2. 第三方库使用步骤：
		1）下载并拷贝到工程路径下
		2）以create group方式导入工程
		3）如果工程使用ARC，则针对导入的源文件使用 -fno-objc-arc 命令
		
	3. json数据解析步骤：
		1）从数据源获取json数据。
		2）将json数据转换为NSDictionary或NSArray
		3）解析NSDictionary或NSArray	
		
### 5、SQLite3 学习

	1. SQLite支持的数据类型：
		INTEGER				有符号整型
		REAL				浮点型
		TEXT				字符串类型，采用UTF-8，UTF-16编码
		BLOB				大二进制对象类型，能够存放任何二进制数据
		VARCHAR CHAR CLOB		转成为TEXT类型
		FLOAT DOUBLE			转换成为REAL		
		NUMERIC				转换成为INTEGER或REAL类型
		
		注意：1、没有布尔类型数据，用整数 0 或 1 代替
		     2、没有日期、时间类型数据，储存在TEXT 或 REAL类型中，一般用NSNumber或NSString处理。
		     
### 6、Swift语言学习开发iOS项目

	git: https://github.com/liuyubobobo/Play-with-Swift-2
	     https://github.com/JakeLin/LoveFinder		     