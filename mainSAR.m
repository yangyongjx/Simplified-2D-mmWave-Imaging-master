% Main function of 2-D SAR Image reconstruction
% -------------------------------------------------------------------------
% Developed by:
% Muhammet Emin Yanik
% Prof. Murat Torlak

% -------------------------------------------------------------------------
%  Copyright 2018, The University of Texas at Dallas
% -------------------------------------------------------------------------


%% Load rawData3D
transD = readDCA1000();
rawData = selectData(transD);


%% Define parameters, update based on the scenario
nFFTtime = 512; % Number of FFT points for Range-FFT
z0 = 170e-3; % Range of target (range of corresponding image slice)��ָ����Ŀ������ײ�֮��ľ���
% dx = 200/406;       % Sampling distance at x (horizontal) axis in mm
dx = 180/360;
% dy=2;
dy = 2.1; % Sampling distance at y (vertical) axis in mm
% nFFTspace = 1024;   % Number of FFT points for Spatial-FFT
nFFTspace = 512;


%% Fixed parameters for all scenarios
c = physconst('lightspeed');
% fS=5000e3;
fS = 9121e3; % Sampling rate (sps)
Ts = 1 / fS; % Sampling period
% K = 15.015e12;      % Slope const (Hz/sec)
K = 63.343e12;


%% Take Range-FFT of rawData3D
rawDataFFT = fft(rawData, nFFTtime);


%% Range focusing to z0
% tI = 4.5225e-10; % Instrument delay for range calibration (corresponds to a 6.78cm range offset)
tI = 0e-10;
k = round(K * Ts * (2 * z0 / c + tI) * nFFTtime); % corresponing range bin
sarData = squeeze(rawDataFFT(k + 1, :, :));
% Create Matched Filter
matchedFilter = createMatchedFilterSimplified(nFFTspace, dx, nFFTspace, dy, z0 * 1e3);


%% Create SAR Image
% imSize = 200; % Size of image area in mm
xSize = 200;
ySize = 200;
sarImage = reconstructSARimageMatchedFilterSimplified(sarData, matchedFilter, dx, dy, xSize, ySize);
