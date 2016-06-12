# -------------------------------------------------------------------
# Create the LMDB for the labels
# Both train and validation lmdbs can be created using this 
# Author: Sukrit Shankar 
# -------------------------------------------------------------------

# -------------------------------------
import pylab as pltss
from pylab import *
import numpy as np
import matplotlib.pyplot as plt 
import scipy 
import scipy.io
import os.path
import lmdb						# May require 'pip install lmdb' if lmdb not found 

# -------- Import Caffe ---------------
caffe_root = '/home/sukrit/Desktop/caffe-master/' 
import sys 
sys.path.insert(0, caffe_root + 'python')
import caffe

# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
# Please set the following values and paths as per your needs 
N = 162770									# Number of data instances  
M = 40										# Number of possible labels for each data instance 
output_lmdb_path = '/home/sukrit/Desktop/caffe_project/lmdbs/label_lmdb'   	# Path of the output label LMDB
labels_mat_file = 'labels.mat'							# Mat file for labels N x M 
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+


# -------- Write in LMDB for Caffe ----------
X = np.zeros((N, M, 1, 1), dtype=np.uint8)
y = np.zeros(N, dtype=np.int64)
map_size = X.nbytes * 10
env = lmdb.open(output_lmdb_path, map_size=map_size)

# ---------------------------------
# Read the mat file and assign to X 
mat_contents = scipy.io.loadmat(labels_mat_file)
X[:,:,0,0] = mat_contents['labels'] 	
# The above expects that the MAT file contains the variable as labels	
# To instead check the variable names in the mat file, and use them in a more judicious way, do 
# array_names = scipy.io.whosmat(labels_mat_file) 	
# print '\n Array Names \n', array_names
print X						# Check to see if the contents are well populated within the expected range
print X.shape					# Check to see if X is of shape N x M x 1 x 1     

with env.begin(write=True) as txn:
    # txn is a Transaction object
    for i in range(N):
        datum = caffe.proto.caffe_pb2.Datum()
        datum.channels = X.shape[1]
        datum.height = X.shape[2]
        datum.width = X.shape[3]
        datum.data = X[i].tostring()  	# or .tobytes() if numpy < 1.9 
        datum.label = int(y[i])
        str_id = '{:08}'.format(i)

        # The encode is only essential in Python 3
        txn.put(str_id.encode('ascii'), datum.SerializeToString())

	# Print the progress 
	print 'Done Label Writing for Data Instance = ' + str(i)




