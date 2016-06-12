# -------------------------------------------------------------------
# Create the data mean from LMDB
# The file is adapted from BVLC Caffe, and requires Caffe tools
# Author: Sukrit Shankar 
# -------------------------------------------------------------------

# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
# Please set the appropriate paths
EXAMPLE=/home/sukrit/Desktop/caffe_project/lmdbs       			# Path where the input LMDB is stored
DATA=/home/sukrit/Desktop/caffe_project/datasets       			# Path where the output mean file is stored
TOOLS=/home/sukrit/Desktop/caffe-master/build/tools    			# Caffe dependency to access the compute_image_mean utility 
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

# ------------------------------
$TOOLS/compute_image_mean $EXAMPLE/data_lmdb \
  $DATA/data.binaryproto

# ------------------------------
echo "Done."
