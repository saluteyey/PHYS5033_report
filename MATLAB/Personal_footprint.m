% this is a script to calculate my personal footprint
% Nov 5, 2024

%load in matrices provided
load("IntermediateDemand.mat");
load("Output.mat");
load("Satellite.mat");

T = IntermediateDemand;
X = Output;
Q = Satellite;

% load in my expenditure data
y = readmatrix("MyShopping.csv");

%Calculate A,q,L matrix
X_hat = diag(X);
inv_X_hat = inv(X_hat);

A = T * inv_X_hat;
q = Q * inv_X_hat;

I = eye(size(T));
L = inv(I - A);

% calculate footprint
my_fp = q * L * y;
fp_sector = q * L * diag(y);

% save fp_sector to csv file
writematrix(fp_sector,'footprint_sector.csv')
writematrix(q,'q_matrix.csv')

%conduct PLD calculation (not presented in report)
layer_1 = q * y;
layer_2 = q * A * y;
layer_3 = q * A^2 * y;
layer_4 = q * A^3 * y;
layer_5 = q * A^4 * y;

PLD = [layer_1; layer_1 + layer_2; layer_1 + layer_2 + layer_3; layer_1 + layer_2 + layer_3 + layer_4;];
    
figure
    plot(PLD);