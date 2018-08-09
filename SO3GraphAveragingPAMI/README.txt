In this package we provide implementations of robust relative rotation averaging with different loss functions 

If you use this package, please cite the following paper:
Avishek Chatterjee and Venu Madhav Govindu, "Efficient and Robust Large-Scale Rotation Averaging", ICCV 2013.

The corresponding bibtex entry is :

@InProceedings{Chatterjee_2013_ICCV,
author = {Avishek Chatterjee and Venu Madhav Govindu},
title = {Efficient and Robust Large-Scale Rotation Averaging},
booktitle = {The IEEE International Conference on Computer Vision (ICCV)},
month = {December},
year = {2013}
}

ACKNOWLEDGMENT : We thank Justin Romberg for permission to use a modified version of l1magic from http://users.ece.gatech.edu/~justin/l1magic/ in our implementation.

CONTACT : For comments/help please email eeavishekchatterjee@gmail.com

USAGE : We provide below a brief guide for the functions available in this package. Please note that the functions in this package will be subsumed in the future into a toolbox for estimation on SO(3).

Conversion Functions:
==============
R2w.m: Convert rotation matrix to angle-axis form
w2R.m: Convert angle-axis form to rotation matrix
R2q.m: Convert rotation matrix to quaternion
q2R.m: Convert quaternion to rotation matrix

Main Functions:
==============

RandomSO3Graph.m: Simulating a random graph of SO(3) relationships
IMPORTANT: The arguments of this function are changed from the previous version

ValidateSO3Graph.m: Check the level of error in the simulated graph or relative rotations

AverageSO3Graph.m: Find a robust SO(3) averaging estimate [THIS IS THE MAIN FUNCTION HERE]

CompareRotationGraph.m: Align and compare two rotation estimates

Brief Function Descriptions:
===========================

[R,RR, I] = RandomSO3Graph(N,Completeness,Sigma,Noutlier)
is a simple program for generating simulated rotations

Usage :
N: number of nodes
Completeness: (0 to 1) fraction of connecting edges (relative rotations) observed.
Sigma: Standard deviation of the simulated noise in degrees 
Noutliers: Fraction of outliers.
R: ground truth rotations. 
RR: Contaminated Relative Rotations.
I: edge indices.
Example:[R, RR, I]=RandomSO3Graph(100,.5,10,0.01);

function [R] = AverageSO3Graph(RR,I,varargin)
  INPUT:        RR = 'm' number of 3 X 3 Relative Rotation Matrices (R_ij) 
                     stacked as a 3 X 3 X m Matrix
                     OR
                     'm' number of 4 X 1 Relative Quaternions (R_ij) 
                     stacked as a 4 X m  Matrix
                 I = Index matrix (ij) of size (2 X m) such that RR(:,:,p)
                     (OR RR(:,p) for quaternion representation)  is
                     the relative rotation from R(:,:,I(1,p)) to R(:,:,I(2,p))
                     (OR R(:,I(1,p)) and  R(:,I(2,p)) for quaternion representation)
  OPTIONALS: Rinit = Optional initial guess. 
     MaxIterations = MaxIterations(1) is Maximum number of L1 iterations. Default 10
                     MaxIterations(2) is Maximum number of IRLS iterations. Default 100
            Method = Type of the cost function to be optimized
                     Can be one among {'L2','L1','L1.5','L0.5','Geman-McClure','Huber','Pseudo-Huber','Andrews','Bisquare','Cauchy','Fair','Logistic','Talwar','Welsch'}
                     default is Geman-McClure.
             Sigma = Sigma value for M-Estimation in degree (5 degree is preferred)
                     Default is 5 degree. Put [] for default.
 
  OUTPUT:       R  = 'n' number of 3 X 3 Absolute Rotation matrices stacked as a  3 X 3 X n Matrix 
                     OR
                     'n' number of 4 X 1 Relative Quaternions (R_ij) stacked as a 4 X n  Matrix
					  
					  

CompareRotationGraph(R1,R2)
is for comparing the estimate with the ground truth
Example: CompareRotationGraph(R,Rm);

The user may also consult the example functions provided.