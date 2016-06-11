# CaffeLMDBCreationMultiLabel
LMDB Creation in Caffe is conventionally supported for a single label setting, i.e. each given data instance has only  one label. For a multi-label scenario (where each of N data instances can have M multiple labels), LMDB creation in Caffe is not straightforward. This code repository provides a way to create an LMDB for training and testing with a multi-label setting in Caffe. We will work with RGB image data here. 

-------------------------------
For a multi-label scenario, the data will be a N x H x W x 3 4D blob, and the *corresponding* labels will be a N x M x 1 x 1 4D blob. The necessary steps can now be listed as follows: 

(1) Shuffle all the data in sync with their corresponding labels before proceeding onto the next steps, as we will not use any shuffle operation during LMDB creation.  

(2) Make a data.txt file which lists the data file names (in order) and a dummy label (which will never be used) for each file. 

(3) Use create_data_lmdb.sh script to create the data_lmdb database from the data.txt file, and lets call it data_lmdb. Use data_lmdb to create the mean file with create_mean.sh. Both the create_data_lmdb and create_mean files will need [Caffe](https://github.com/BVLC/caffe). 

(4) For the order of the data files specified in data.txt, let the corresponding labels be stored in a labels.mat file as a N x M matrix. We will import this into python. Alternatively, you can have this N x M matrix directly in the numpy format. Scale the label values so that the min label value is 0 and the max is 255. 

(5) Use create_label_lmdb.py to form a label_lmdb database with labels.mat file (or any alternative specification of N x M matrix)

(6) Specify data_lmdb, label_lmdb for train and validation datasets along with the mean file in the train prototxt similar to train_vgg_11_sigmoid_cross_entropy_loss.prototxt. The idea is to essentially create two data layers, one for the data and one for the (corresponding) labels. Note the scaling of the labels in the transform_param of the DATA layer. This is to convert the label range from [0,255] to [0,1] as per the requirement of the Sigmoid Cross Entropy Loss function. Depending on your multi-label loss function requirements, please adjust the scaling parameters. 

You should now be ready to train your prototxt (of step 6) with a multi-label loss (like sigmoid cross-entropy) with your data and labels both in LMDB format. 
