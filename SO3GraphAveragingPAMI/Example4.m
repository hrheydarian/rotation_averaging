% Different loss functions
[R,RR,I]=RandomSO3Graph(500,.5,10,.01);
fprintf('Validating Input data w.r.t Ground truth\n');
ValidateSO3Graph(R,RR,I);close all;
fprintf('Evaluating different loss functions\n');
CompareRotationGraph(R,AverageSO3Graph(RR,I,'Method','L2'));
CompareRotationGraph(R,AverageSO3Graph(RR,I,'Method','L1'));
CompareRotationGraph(R,AverageSO3Graph(RR,I,'Method','L0.5'));
CompareRotationGraph(R,AverageSO3Graph(RR,I,'Method','Geman-McClure'));
CompareRotationGraph(R,AverageSO3Graph(RR,I,'Method','Huber'));
CompareRotationGraph(R,AverageSO3Graph(RR,I,'Method','Pseudo-Huber'));
CompareRotationGraph(R,AverageSO3Graph(RR,I,'Method','Andrews'));
CompareRotationGraph(R,AverageSO3Graph(RR,I,'Method','Bisquare'));
CompareRotationGraph(R,AverageSO3Graph(RR,I,'Method','Cauchy'));
CompareRotationGraph(R,AverageSO3Graph(RR,I,'Method','Fair'));
CompareRotationGraph(R,AverageSO3Graph(RR,I,'Method','Logistic'));
CompareRotationGraph(R,AverageSO3Graph(RR,I,'Method','Talwar'));
CompareRotationGraph(R,AverageSO3Graph(RR,I,'Method','Welsch'));