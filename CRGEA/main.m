%The designed CRGEA
clc
clear
close all
load Urban.mat; 
load su_m_Urban.mat;
tic

run_times=30;
% CRGEA_data  Storing operational data
% CRGEA_data_time  Storage Runtime
[CRGEA_data,CRGEA_data_time]=jieguo(Urban,su_m_Urban,run_times);
toc