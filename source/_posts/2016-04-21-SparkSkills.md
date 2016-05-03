---
title: Spark常用技巧总结
date: 2016-04-21 12:38:28
categories: CCTV10-科教
tags:
    - Python
    - Spark
    - Summary
    - Data mining
---

[传送门](http://spark.apache.org/docs/latest/api/python/index.html)是Pyspark的API网站。具体的信息这里都可以找到。

总结一些Spark的实用技巧：

<!--more-->

# 提高代码运行效率 #

## `cache()` vs. `repartition()` ##

把`cache()`放在`repartition()`前面会比放在后面高效很多倍，具体原因是因为`repartition()`操作无法继续lazy execution所以需要调用memory，这样的话提早把RDD存入cache就会节省一次时间。

举例，下面两份代码第一份优于第二份：

```python
sRDD_text.map(someFunc)\
.cache()
.repartition()
```

```python
sRDD_text.map(someFunc)\
.repartition()
.cache()
```

## 尽量不要Move Data ##

Spark有一个很重要的原则就是能不对Data做Manupulation就不要做，有些事情比如Regression, K-means就利用了这一点在每个partition分别运算，然后通过`broadcast`命令实现partition之前的同步。

# Key-Value pair操作 #

## `combineByKey()` ##

Spark对于Key-Value的设计提供了很多巧妙的操作，其中最巧妙的当属`combineByKey()`，这个方法我在我的spark repo里面有例子，这里不多说了，只要记住里面的三个function分别对应：第一次遇到某Value的操作，不是第一次遇到某Value的操作，以及将不同partition的结果合并的操作就可以，放一个例子在这里：

```python
rdd = sc.parallelize([("Sleep", 7), ("Work",5), ("Play", 3), 
                      ("Sleep", 6), ("Work",4), ("Play", 4),
                      ("Sleep", 8), ("Work",5), ("Play", 5)])

sum_counts = rdd.combineByKey(
    (lambda x: (x, 1)), # createCombiner maps each value into a  combiner (or accumulator)
    (lambda acc, value: (acc[0]+value, acc[1]+1)),
#mergeValue defines how to merge a accumulator with a value (saves on mapping each value to an accumulator first)
    (lambda acc1, acc2: (acc1[0]+acc2[0], acc1[1]+acc2[1])) # combine accumulators
)
print sum_counts.collect()
duration_means_by_activity = sum_counts.mapValues(lambda value:
                                                  value[0]*1.0/value[1]) \
                                                  .collect()
print duration_means_by_activity
```
## `flatMapValues()` ##

这个function的牛逼之处就在于可以把一个Key-Value的pair拆成很多个，举个例子比如一个`(int, list)`的pair，可以拆成很多个，每个的Key保持不变而Value就是list中的每一个。比如：

```python
l_group_TokenK = tRDD_user_token.flatMapValues(lambda x: x)
```
