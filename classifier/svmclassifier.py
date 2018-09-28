# 导入模块
import scipy.io
import numpy as np
from sklearn import svm

# 导入从matlab中得到的mat文件，获取gram矩阵
mat = scipy.io.loadmat('.\_n=20_nv=1_martin_gram.mat')
num = int(mat['num'])
X = mat['data'][:,0]
X = X[:,np.newaxis]
Y = mat['data'][:,1]
gram= mat['dist']

#根据高斯核函数意义设计gram_final，使得：当视频样本相似度高时，核函数值为趋于1；反之，趋于0
gamma=0.3
gram_final = np.exp(-gamma*gram)
# 拆分数据集，得到gram_train及gram_test
train_each_num=5
train_index=list(range(0,train_each_num))+list(range(num,num+train_each_num))+list(range(num*2,num*2+train_each_num))
gram_train = gram_final[train_index,:][:,train_index]
gram_test = gram_final[:,train_index]

# we create an instance of SVM and fit out data.
clf = svm.SVC(kernel='precomputed')
clf.fit(gram_train, Y[train_index])

# 预测以及评估
Z = clf.predict(gram_test)
p = sum(Y==Z)/Y.size
print(p)