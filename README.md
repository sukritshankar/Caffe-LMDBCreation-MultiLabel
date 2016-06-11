# CaffeLMDBCreationMultiLabel
LMDB Creation in Caffe is conventionally supported for training a single label setting, i.e. each given data instance has only  one label. For a multi-label scenario (where each of N data instances can have M multiple labels), LMDB creation in Caffe is not straightforward. This code repository provides a way to create a LMDB for training and testing with a multi-label setting in Caffe. 

For a multi-label scenario, the data will be a N x H x W x 3 4D blob, and the corresponding labels will be a N x M x 1 x 1 4D blob. The necessary steps are as follows: 
(1) 
