# HousePricing

HousePricing旨在提供房价的可视化预测，帮助人们更好的评估房产和预测未来的价格

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
    
<img src="/lib/framework_instruction.png" width="700">
  
## 说明

1. HousePricing由Rails web框架开发（Ruby），能实现数据挖掘中的1.2和1.3，以及数据可视化部分

2. 数据挖掘中的1.1部分由[scrapy-hoursepricing](https://github.com/PENGZhaoqing/scrapy-hoursepricing)实现，这个应用是由Scrapy爬虫框架开发（Python），能够轻松实现对房价网站中的信息进行抓取，抓取后的数据将存为json格式，然后由HousePricing进行解析并储存在数据库中。

## 目前进展

1. 数据挖掘部分几乎完成，现在的HousePricing能够对需要的数据进行提取，只是提取数据需要花一些时间（in doing）
2. 考虑下一步使用的模型和算法
3. 能够对现有的数据进行部分可视化，例如所有房价信息的散点图

## 截图

<img src="/lib/screenshoot1.png" width="700">
<img src="/lib/screenshoot2.png" width="700">
<img src="/lib/screenshoot3.png" width="700">

## 数据说明

<img src="/lib/data_type.png" width="700">


