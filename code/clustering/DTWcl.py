#!/usr/bin/env python

__author__ = 'klanna'

import scipy.io
import numpy as np, h5py


mat = scipy.io.loadmat('datatest_X.mat')

data = np.array(mat) # For converting to numpy array

a = mat['x']

print a[1, 1]

print 'Hello, World'