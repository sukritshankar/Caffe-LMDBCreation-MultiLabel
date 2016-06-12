# -------------------------------------------------------------------
# Create the LMDB for the data instances
# Both train and validation lmdbs can be created using this 
# The file is adapted from BVLC Caffe, and requires Caffe tools
# Author: Sukrit Shankar 
# -------------------------------------------------------------------

# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
# Please set the appropriate paths
EXAMPLE=/home/sukrit/Desktop/caffe_project/lmdbs       			# Path where the output LMDB is stored
DATA=/home/sukrit/Desktop/caffe_project/datasets       			# Path where the data.txt file is present 
TOOLS=/home/sukrit/Desktop/caffe-master/build/tools    			# Caffe dependency to access the convert_imageset utility 
DATA_ROOT=/home/sukrit/Desktop/datasets/images/     			# Path prefix for each entry in data.txt
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

# ----------------------------
# Checks for DATA_ROOT Path
if [ ! -d "$DATA_ROOT" ]; then
  echo "Error: DATA_ROOT is not a path to a directory: $DATA_ROOT"
  echo "Set the DATA_ROOT variable to the path where the data instances are stored."
  exit 1
fi

# ------------------------------
# Creating LMDB
 echo "Creating data lmdb..."
 GLOG_logtostderr=1 $TOOLS/convert_imageset \
    $DATA_ROOT \
    $DATA/data.txt \
    $EXAMPLE/data_lmdb

# ------------------------------
echo "Done."



