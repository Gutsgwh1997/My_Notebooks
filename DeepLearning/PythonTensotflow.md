#　<center>python3 And TensorFlow</center>  

## 1. Python3基础
1. **from __future_\_ import *:** 其作用是将新版本的特性引进当前的版本中。

2. if \_\_name\_\_ =\= \'\_\_main\_\_\'的意思是：当.py文件被直接运行时，if \_\_name__ =\= \'\_\_main\_\_\'之下的代码块将被运行；当.py文件以模块形式被导入时，if \_\_name__ == '\_\_main__'之下的代码块不被运行。[参照](https://blog.csdn.net/anshuai_aw1/article/details/82344884)   

3. isinstance()函数用来判断一个对象是否是一个已知的类型.[isinstance与type()的区别](https://www.runoob.com/python/python-func-isinstance.html)

   ```python
   >>>a = 2
   >>> isinstance (a,int)
   True
   >>> isinstance (a,str)
   False
   >>> isinstance (a,(str,int,list))    # 是元组中的一个返回 True
   True
   ```
   
4. assert()断言，用来检测错误条件，当不满足断言条件时，返回错误

   ```python
   assert expression
   if not expression:
       raise AssertionError
   ```
   
5. Python中的lambda语法是唯一的，形式为：

   ```python
   lambda argument_list:expression   #(expression是一个关于参数的表达式)
   #例子,lambda是一个匿名函数
   f = lambda x,y,z:x + y + z 
   print f(1,2,3)
   print f(4,5,6)
   输出：
   6
   15
   ```
   
   
   
   

## 2. TensorFlow
 1. **tf.name_scope()**主要结合**tf.Variable()**来使用：
```python
Signature: tf.name_scope(*args, **kwds)
Docstring:
Returns a context manager for use when defining a Python op.
# 也就是说，它的主要目的是为了更加方便地管理参数命名。
# 与 tf.Variable() 结合使用。简化了命名
with tf.name_scope('conv1') as scope:
    weights1 = tf.Variable([1.0, 2.0], name='weights')
    bias1 = tf.Variable([0.3], name='bias')

# 下面是在另外一个命名空间来定义变量的
with tf.name_scope('conv2') as scope:
    weights2 = tf.Variable([4.0, 2.0], name='weights')
    bias2 = tf.Variable([0.33], name='bias')

# 所以，实际上weights1 和 weights2 这两个引用名指向了不同的空间，不会冲突
print weights1.name
print weights2.name
```
2. **tf.truncated_normal(shape, mean=0.0, stddev=1.0, dtype=tf.float32, seed=None, name=None):**  
    从截断的正态分布中输出随机值，如果x的取值在区间**（μ-2σ，μ+2σ）**之外则重新进行选择。这样保证了生成的值都在均值附近。　　
    shape: 一维的张量，也是输出的张量  
    mean: 正态分布的均值  
    stddev: 正态分布的标准差  
    dtype: 输出的类型  
    seed: 一个整数，当设置之后，每次生成的随机数都一样  
    name: 操作的名字  
3. **tf.nn**提供神经网络相关操作的支持，包括卷积、池化、归一化、RNN等  
**tf.nn.relu()**神经元激活函数，斜坡函数，即为max(0,features)。
<center> <img src="/home/gwh/Pictures/tf.nn.relu.png" width="50%" height="50%" /></center>
4. **tf.losses.sparse_softmax_cross_entropy(labels,logits)**tf中交叉熵的计算  
    [信息熵、交叉熵的理解](https://blog.csdn.net/tsyccnh/article/details/79163834 "CSDN博客")
    [tf中交叉熵的计算](https://www.jianshu.com/p/95d0dd92a88a "简书中手动和调用API计算熵")
    [测试代码](/home/gwh/Desktop/tensorflow/test code/交叉熵的计算.py) 
5. **tf.nn.in_top_k(predictions,targets,K)**检测每个样本前K个最大数对应的标签是否包含在targets里边
```python
import tensorflow as tf;
 
A = [[0.8,0.6,0.3], [0.1,0.6,0.4]]
B = [1, 1]
out = tf.nn.in_top_k(A, B, 1)
with tf.Session() as sess:
	sess.run(tf.initialize_all_variables())
	print sess.run(out)
#A张量里第一个元素的最大值的标签为０，第二个元素最大值的标签为１
#所以输出[False True]
```
6. **tf.cast(x,dtype,name=None)**将原来的的数据格式转化为dtype
7. [tf.app.flags](https://blog.csdn.net/tefuirnever/article/details/90746524)用于读取命令行的参数:
```python
python 111.py --learning_rate 0.01 --max_steps 100
```

8. tensorflow中的**循环神经网络（RNN）**。tensorflow中实现RNN的基本单元是"RNNCell"，例如tf.contrib.rnn.BasicLSTMCell(num_units)是一个LSTM网络单元，每个RNNCell都有一个call方法。[可以根据单元的输入以及上一时刻的状态得到当前的输出和状态。](https://www.leiphone.com/news/201709/QJAIUzp0LAgkF45J.html)如下图：

![](/home/gwh/Documents/笔记/说明图片/8c9740c22176ac4b77f940a25ddecaa5.jpg)

   假设有一个初始状态$h_0$和输入$x_1$，调用call($h_0,x_1$)之后就可以得到$(output_1,h_1)$ ，在调用一次$(h_1,x_2)$ 就可以得到$(output_2,h_2)$。

   ![](/home/gwh/Documents/笔记/说明图片/59a9264ecd98b.jpg)

   **每调用一次RNNCell的call方法，就相当于在时间上推进了一步**，tensorflow提供了**tf.nn.dynamic_rnn()**函数，使用此函数相当于调用了n次call函数。

   ```python
   cell = tf.contrib.rnn.BasicLSTMCell(lstm_size)   #lstm_size隐藏层的数量
   outputs,final_state = tf.nn.dynamic_rnn(cell,inputs,initial_state=initial_satate)
   #inputs的形状为[batch_size,多少个推移，一次推移输入的数据量]
   #例如batch_size为50的MNIST数据集，[50,图片行数，图片一行的列数量]
   #其中的outputs是所有时间时刻的输出（等于隐层的），当参数time_major = True时，outputs的维度是[多少个推移,batch_size,lstm_size];否则输出的shape为[batch_size,多少个推移,lstm_size]
   #final_state是最后一个推移的输出，若是RNN网络，则为[batch_size,lstm_size]
   #当输入的cell是LSTM时,final_state的shape为[2,batch_size,lstm_size]
   #final_state[0]对应的是下图中c(t)的状态(代表那些信息被记住，那些信息被遗忘)
   #final_state[1]则代表输出h(t)-------------------------------------------
   ##output中[最后一个推移，batch_size,lstm_size]与final_state[1]相同啊！！
　　#?当多个Lstm链接在一块时候，output是最后一个Lstm单元的一些列的推移的输出，final_state是每个Lstm单元的
   ```

   <center> <img src=/home/gwh/Documents/笔记/说明图片/20180801171636213.png width="50%" height="50%" /></center>
9. [TFRecord文件格式](https://blog.csdn.net/briblue/article/details/80789608)，可以统一训练时数据的文件格式，降低学习成本（没感觉到）。

10. tensorflow有两种方式padding:

    padding = "SAME"输入和输出大小关系为:$$n_{output} = [\frac{n_{input}}{S}]$$，$S$是步长。[ ]向上取整。

    padding = "VALID"输入和输出大小关系为：$n_{output}=[\frac{n_{input}-f+1}{s}]$，$f$是滤波器的大小。

## 3. Numpy

1. **np.flatnonzero()**输入一个矩阵，返回其中非零元素的位置：
```python
>>> x = np.arange(-2, 3)
>>> x
array([-2, -1,  0,  1,  2])
>>> np.flatnonzero(x)
array([0, 1, 3, 4])
import numpy as np
d = np.array([1,2,3,4,4,3,5,3,6])
haa = np.flatnonzero(d == 3)
print (haa)

[2 5 7]
```
2. **[np.random.choice()](https://blog.csdn.net/weixin_42338058/article/details/84023785) **

3. **np.bincount(x)**可以累计x中元素出现的次数**.argmax()**方法可以返回出现次数最多的元素。

4. b = np.random.randn(m,n)，np的ravel()方法可以返回b的展开形式。b.ravel()将b的shape从(m,n)变为(mn,)。

5. numpy.squeeze(a,axis = None)，从数组中删除单维度条目。在深度学习中，通常算法的结果可以表示向量的数组，如果利用这个数组进行画图可能显示界面为空。可以利用squeeze()函数，将表示向量的数组转换为秩为1的数组，这样利用matplotlib库画图时，可以正常显示结果了。

   ```python
   import numpy as np
   a = np.arange(10).reshape(1,10)
   #a = array([[0,1,2,3,4,5,6,7,8,9]])  a.shape = (1,10)
   b = np.squeeze(a)
   #b = array([0,1,2,3,4,5,6,7,8,9])    b.shape = (10,)
   ```

6. numpy中多维数组的秩就为多维数组的轴。

   ```python
   a = np.arange(24).reshape(2,3,4)
   print(a)
   >>[[[ 0  1  2  3]
     [ 4  5  6  7]
     [ 8  9 10 11]]
   
    [[12 13 14 15]
     [16 17 18 19]
     [20 21 22 23]]]
   print(a[0,:,:])    #为第一片
   >>
   [[ 0  1  2  3]
    [ 4  5  6  7]
    [ 8  9 10 11]]
   print(a[:,0,:])    #每一片的第一行
   >>
   [[ 0  1  2  3]
    [12 13 14 15]]
   print(a[:,:,0])    #每一片的第一列
   >>
   [[ 0  4  8]
    [12 16 20]]
   #这个是求解a[:,:,0]方向的均值的
   b = tf.reduce_mean(a,[0,1],keep_dims=True)
   ```

   

   
