# primal-dual-gradient-nmf
Primal-Dual and Gradient-based algorithms for Non-negative Matrix Factorization (from scratch in MATLAB) and used it for topic modelling on textual data.

File description:

1. script.py- This file was used to preprocess the data and getting the 500x500 matrix.

2. driver.m- This file was used to run various experiments for three algorithms and for different values of rank and number of iterations. 

3.pgwithlin.m- This file is for the algorithm projected gradient with lin approach.

4.pgwitharmijo.m-This file is for the algorithm projected gradient with armijo condition.

5.dualkl.m-This file is for the algorithm primal dual algorithm.

6.data500x500.txt-consists of the 500x500 matrix generated from script.py

Steps to run the code:

1.Just running driver.m will run the algorithms for different number of iterations. If we want to change the algorithm,change the name of the algorithm in for-loop.


2. We just have to make sure that the matlab files corresponding to the algorithms are in the same folder as the driver file.
