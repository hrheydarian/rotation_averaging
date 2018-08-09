% Test script for rotation averaging algorithms

%% Testing SO3GraphAveragingPAMI
% This test script generates a set of angles about a common axis (z here), 
% then computes their differences (relative angles) and finally averages 
% them to get the initial absolute angles.

% add toolbox directory
addpath(genpath('SO3GraphAveragingPAMI'));

% generate the initial absolute angles

N = 5;                          % the number of nodes
R(:,:,1)=eye(3);        
ang = linspace(0,1,N)*pi;       % angles
estAngle = zeros(size(ang));    % estimated angle
w = [0 0 1];                    % unit vector along z axis
    
for i=2:N
    
    w = w/norm(w)*ang(i);
    R(:, :, i) = w2R(w);
    
end

I = zeros(2, N*(N-1)/2);        % the Indicator matrix
RR = zeros(3, 3, N*(N-1)/2);    % initialize Relative Rotation (RR) matrices


k=1;
for i=1:N-1
    for j=i+1:N
        I(:,k)=[i;j];
        RR(:,:,k)=R(:,:,j)*R(:,:,i)';
        k=k+1;
    end
end

% average relative rotations to get the absolute ones
Rest = AverageSO3Graph(RR, I);
for i=1:numel(ang)
    tmpAng = R2w(Rest(:,:,i));
    estAngle(i) = tmpAng(3);
end

% compare the results
CompareRotationGraph(R,Rest);

% compare actual angles
disp('original angles:')
disp(num2str(ang));

disp('averaging result')
disp(num2str(estAngle));