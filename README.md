# HousePricing

HousePricing旨在提供房价的可视化预测，帮助用户更好的评估房产和预测未来的价格

- 第一版已上线，请点击[这里](https://house-pricing.herokuapp.com/)访问，因为挂在免费的Heroku服务器中，第一次加载可能会很慢，请耐心等待

**如果觉得好，请给项目点颗星来支持吧～～** 

有什么好的建议，请在issue中提出，欢迎contributors！

### 1. 面向用户(买房者、卖房者)

对于买家，在主页面通过各种筛选选出符合条件的房屋，进入各个房屋的详细页面，应用通过各种可视化手段让用户从交通、教育、工作、交通、生活等方面对这套房子进行评估。

未来工作：

1. 加入房屋预测功能
2. 加入相似房屋推荐功能

### 2. 面向开发者（数据挖掘工程师，数据可视化分析师等）

如果你是面向地理位置的数据挖掘工程师，你可以不用编写与百度API交互的代码，直接运行这个应用后导入自己的房屋数据，应用会自动与百度API爬取周围的基础设施，获得的数据可用来作为学术研究和分析等

请点击这里查看详细信息:http://blog.csdn.net/ppp8300885/article/details/77806852

## How?

### 1. 数据挖掘 (Done)

    1.1 在房价网站上利用爬虫爬下当前所有房子的价格和基本信息（房型、面积、楼层、建造时间等）
  
    1.2 利用百度API对每套房产的周边信息进行挖掘（公交车站、地铁、写字楼、医院、学校、商场等）
  
    1.3 将所有信息储存在关系型数据里，构建数据仓库（Data Warehouse）

### 2. 建立模型对数据进行分析（Under Construction）

    2.1 选择模型

    2.2 训练

### 3. 数据可视化（Partial done）

    3.1 导入百度的可视化工具库（Echarts）

    3.2 利用训练的模型对指定房屋价格进行评估和预测，并以科学地方法将结果进行可视化展示
    
<p align="center">
   <img src="/lib/framework_instruction.png" width="700">
</p>

## 目前进展(更新)

1. 数据提取完成，现在的HousePricing能够对需要的数据进行提取，需要管理员权限（如果是自己想跑源码的，可以自行提取）
2. 下一步考虑加上相似房屋推荐功能和价格预测功能，然后数据可视化需要更多的表示方法

### 房屋预测功能具体应用场景：

1. 对于买家，输入那个房子的坐标，我们通过这个数据集对这个房子的价钱进行预测，以帮助买家合理判断值不值买这个房子（开发中）

2. 对于卖家，输入他自己的房子坐标，我们可以对这个房子价钱进行评估，让卖家对自己的卖价有个大致的定位，更好的选择自己的出手价格（开发中）


## 截图

<img src="/lib/screen1.png">

<img src="/lib/screen2.png">

<img src="/lib/screen3.png">

<img src="/lib/screen4.png">

<img src="/lib/screen5.png">

## 数据说明

现有的一些字段以及字段之间的关联如下：

<img src="/lib/data_type.png" width="700">

## 开发

原始数据由[scrapy-hoursepricing](https://github.com/PENGZhaoqing/scrapy-hoursepricing)爬取，抓取后的数据将存为json格式，然后由HousePricing进行解析并储存在数据库中

本项目由rails框架开发，请自行安装相关环境，请先fork此项目，然后运行下面：

```
git clone your_forked_project
cd project_path
bundle install
rake db:migrate
rake db:seed
```

在浏览器中输入`localhost:3000`，即可访问主页

**若需要原数据（我目前用的数据），请导入根目录下的`mydb.dump`到postgresql数据库**

