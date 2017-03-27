# 简述

SKChoosePopView是一个HUD风格的可定制化选项弹窗的快速解决方案，集成了上、下、左、右、中5个进场方向的6种动画效果，如果不能满足你对酷炫效果的需要，SKChoosePopView同样支持自定义动画，以及选择记录、动画的开闭、点击特效、行列数量控制等。如果你觉得还不错，star支持一下吧！

![Language](https://img.shields.io/badge/Language-%20Objective%20C%20-blue.svg) 


### 效果图 
<img src="http://ofg0p74ar.bkt.clouddn.com/SKPopViewExample.gif" width="370" height ="665" />


# 如何开始 

1.从GitHub上Clone-->SKChoosePopView, 然后查看Demo (由于使用cocoaPods管理，请打开xcworkspace工程进行查看)


2.请仔细阅读下方特别指出的部分和需要注意问题


3.在项目中使用SKChoosePopView，直接将目录下的SKChoosePopView文件夹拷贝到工程中，或在podfile文件中添加```pod 'SKChoosePopView'```


4.SKChoosePopView基于Masonry布局，请确保你的工程里已存在Masonry，[下载地址](https://github.com/SnapKit/Masonry)


# 使用方法

#### 头文件导入
<pre><code>#import "SKPopView.h"</code></pre>



#### 初始化
<pre><code>SKPopView * popView = [[SKPopView alloc] initWithOptionsTitle:kDate.title OptionsIconNormal:kDate.normalIcons  OptionsIconSelected:kDate.selectedIcons selectedTitleColor:[UIColor orangeColor] delegate:self completion:^{
// TODO: 如果这里不需要就nil
}];</code></pre>



### 显示
<pre><code>[popView show];</code></pre>



### 消失
<pre><code>[popView dismiss];</code></pre>



### 设置动画类型
<pre><code>popView.animationType = SK_TYPE_SPRING;</code></pre>



### 设置动画方向
<pre><code>popView.animationDirection = SK_SUBTYPE_FROMBOTTOM;</code></pre>



### 动画时间
<pre><code>popView.animationDuration = 0.5;</code></pre>



### 开启/关闭选择记录
<pre><code>popView.enableRecord = YES;</code></pre>



### 开启/关闭动画效果
<pre><code>popView.enableAnimation = YES;</code></pre>



### 行数设置
<pre><code>popView.optionsLine = 2;</code></pre>



### 列数设置
<pre><code>popView.optionsRow = 3;</code></pre>



### 最小行间距
<pre><code>popView.minLineSpacing = 10;</code></pre>



### 最小列间距
<pre><code>popView.minRowSpacing = 10;</code></pre>


# 注意事项

1.optionsLine和optionsRow属性是必须设置的, 且遵循垂直布局原则，请确保optionsLine * optionsRow于选项数量相等


2.最小行、列间距如不需要可以不设置，默认为0


3.如果开启动画，请确保animationType、animationDirection和animationDuration属性已经设置


4.如果遇到其它问题，欢迎提交issues，我会及时回复




## 感谢你花时间阅读以上内容, 如果这个项目能够帮助到你，记得告诉我
Email: shevakuilin@gmail.com
