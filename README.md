##问题描述
问题来自于[iOS UIButton 的 touchDown 事件][1]这篇帖子。简单地说，在设置
```objc
detailVC.hidesBottomBarWhenPushed = YES;
```
之后，放一个view在tabbar原来的位置上，再在view上添加一个button，像这样
![图片描述][2]
为button添加touchDown action，当按住button的左下角区域时，action没有被触发。

##触发环境
iOS 7或以上，真机调试。
##分析过程
先查看HitTest的结果，button实例被正确地返回了。这说明button并没有被透明的view所遮盖。
接着，override button的touchesXXX方法。当按下button的左下角时，touchesBegan等4个方法完全没有被调用到。参考下图
![图片描述][3]
应该存在一个gesture recognizer，并且[delaysTouchesBegan][4]设置为YES。
>delaysTouchesBegan (default of NO)—Normally, the window sends touch objects in the Began and Moved phases to the view and the gesture recognizer. Setting delaysTouchesBegan to YES prevents the window from delivering touch objects in the Began phase to the view. This ensures that when a gesture recognizer recognizes its gesture, no part of the touch event was delivered to the attached view. Be cautious when setting this property because it can make your interface feel unresponsive.

考虑当前场景，应该是滑动返回手势捣的鬼。稍微验证一下
```objc
- (void)viewDidLoad
{
    //Other codes here
    NSLog(@"%d", self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan);
}
```
得到结果
![图片描述][5]
那么答案就很明显了。
##解决方案
```objc
self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
```
##参考资料
[Placing a UIButton in the same space as UITabBar (When hidden)][6]


  [1]: http://segmentfault.com/q/1010000002490506
  [2]: http://cl.ly/image/0F2L3L0R232c/Button_touch_down_1.png
  [3]: http://cl.ly/image/3f0Q2A1v2j0b/2170531068-54e338287de1f_articlex.png
  [4]: http://stackoverflow.com/questions/24990362/placing-a-uibutton-in-the-same-space-as-uitabbar-when-hidden
  [5]: http://cl.ly/image/3l1f2F1K0X0x/2020910826-54e343814c310_articlex.png
  [6]: http://stackoverflow.com/questions/24990362/placing-a-uibutton-in-the-same-space-as-uitabbar-when-hidden
