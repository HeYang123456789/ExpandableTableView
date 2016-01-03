![](http://img.hoop8.com/attachments/1512/0342032228343.png)


ExpandableTableView
===
![](http://img.hoop8.com/attachments/1601/8641903678187.gif)

GitHub：[HeYang](https://github.com/HeYang123456789) ｜ Blog：[HeYang(Chinese)](http://www.cnblogs.com/goodboy-heyang/)

## Contents
* [Getting Started 【开始使用】](#Getting_Started)
* [Extendible Examples 【示例】](#Extendible_Examples)

# <a id="Getting_Started"></a> Getting Started 【开始使用】


### Manually【手动导入】
- Drag all source files under floder `ExpandableTableView` to your project.【将`ExpandableTableView`文件夹中的所有源代码拽入项目中】
- Import the main header file：`#import "ExpandableTableView.h"`【导入主头文件：`#import "ExpandableTableView.h"`】



* How to use?

####Use Simple Example: In file 'ViewController.m'

```
#import "ViewController.h"

#import "ExpandableTableView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1、创建ExpandableTableView
    ExpandableTableView* extb = [[ExpandableTableView alloc] initWithFrame:self.view.frame];
    //2、设置origin，主要是考虑在有状态栏的情况，就让他下移20
    extb.origin = CGPointMake(0, 20);
    //3、添加到父控件
    [self.view addSubview:extb];
    
}

@end
```



# <a id="Extendible_Examples"></a> Examples【示例】



![](http://img.hoop8.com/attachments/1601/7563073401123.gif)
