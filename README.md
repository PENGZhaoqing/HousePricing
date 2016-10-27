# HousePricing

HousePricing旨在提供房价的可视化预测，帮助人们更好的评估房产和预测未来的价格

目前应用已上线，请点击[这里](http://house-pricing.herokuapp.com/)访问，因为挂在免费的Heroku服务器中，第一次加载可能会很慢，请耐心等待

如果觉得好，请给项目点颗星来支持

有什么好的建议，请在issue中提出，欢迎contributors！

## How?

### 1. 数据挖掘 (Almost Done)

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

## 说明

1. HousePricing由Rails web框架开发（Ruby），能实现数据挖掘中的1.2和1.3，以及数据可视化部分

2. 数据挖掘中的1.1部分由[scrapy-hoursepricing](https://github.com/PENGZhaoqing/scrapy-hoursepricing)实现，这个应用是由Scrapy爬虫框架开发（Python），能够轻松实现对房价网站中的信息进行抓取，抓取后的数据将存为json格式，然后由HousePricing进行解析并储存在数据库中。

## 目前进展(更新)

1. 数据提取完成，现在的HousePricing能够对需要的数据进行提取，需要管理员权限（如果是自己想跑源码的，可以自行提取）
2. 下一步考虑加上相似房屋推荐功能和价格预测功能，然后数据可视化需要更多的表示方法

## 截图

<img src="/lib/screen1.png" width="900">

<img src="/lib/screen2.png" width="900">

<img src="/lib/screen3.png" width="900">

<img src="/lib/screen4.png" width="900">

<img src="/lib/screen5.png" width="900">

## 数据说明

现有的一些字段以及字段之间的关联如下：

<img src="/lib/data_type.png" width="700">

## 面向开发者（数据挖掘工程师，数据可视化分析师等）

如果你是开发者，你完全可以自己导入自己的房屋数据，然后通过百度API爬取周围的基础设施，获得的数据可用来作为学术研究和分析等

本项目由rails框架开发，请自行安装相关环境，请先fork此项目，然后运行下面：

```
git clone your_forked_project
cd project_path
bundle install
rake db:migrate
rake db:seed
```

在浏览器中输入`localhost:3000`，即可访问主页

**若需要原数据（我目前用的数据），请导入根目录下的`mydb.dump`到postgresql数据库


