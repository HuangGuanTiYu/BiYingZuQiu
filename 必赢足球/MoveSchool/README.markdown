### 项目结构
#### 1. MoveSchool
1. MoveSchool.entitlements(推送相关，系统自动生成)
2. Class（应用主要代码文件）
3. Login（登录使用文件）
4. AppDelegate（APP的入口）
5. Info（APP的相关设置文件，体统文件）
6. Supporting Files（APP资源文件，包含iconfont，APP中所有使用的宏文件，登录密码加密文件等）
7. Assets.xcassets（APP中所有图片资源）

#### 2.Products
系统自动编译的APP文件

#### 3.Frameworks
APP中使用到的第三方依赖


#### 下面重点说一下Class文件中的内容（所有模块均使用了MVC整理）
1. Find（发现模块）
2. Home（首页模块）
3. Interaction（课程发布模块）
4. Course（课程模块）
5. Upload（发布流程）
6. Live（直播模块，CCLive）
7. Framework（第三方依赖库）
8. ThirdParty（使用到的第三方代码块）
9. Main（程序中所有通用的控制器或者控件放在这里）
10. Mine（我的模块）


### 项目的启动流程

AppDelegate->MianTabBarController(四大模块控制器)->MainNavigationController(每个大模块的栈控制器)->栈顶控制器HomePageController（首页），FindController（发现），StudyCircleController（互动），MineController（我的）。

#### MianTabBarController
主要决定了APP的几大模块（咱们项目中是4大模块，首页，发现等。）下方菜单点击切换模块就是由MianTabBarController它来实现的。同时由于整个项目中只会有一个MianTabBarController，并且它只会被初始化一次，所以我在它的初始化方法中设置了全局APP的颜色，比如导航条的颜色，字体大小，字体颜色，下面模块菜单的图标，字体大小，字体颜色等。

#### MainNavigationController（栈控制器）
作为栈控制器，用于控制栈内所有控制器的push和pop。同时还在push操作时坐了拦截，设置了新控制器的返回按钮，以及返回的按钮的操作，新控制的背景色等，达到了全APP所有控制器统一的效果。


