% This example shows how to use WarmChorus function:
%
% Aku Rouhe & Niklas Sallinen


%% reading input files:

[gtr_lead, Fs1] = audioread('SoundSamples/GuitarLeadDRY.wav');
[gtr_crd, Fs2] = audioread('SoundSamples/GuitarChordsDRY.wav');
[gtr_dst, Fs3] = audioread('SoundSamples/GuitarDistortedDRY.wav');
[violin, Fs4] = audioread('SoundSamples/DRYSAMPLE.wav');
[music, Fs5] = audioread('SoundSamples/musicDRY.wav');


%% Processing:

distance = 5;   % Maximum distance between players
skill    = 0.5; % Skill factor of players

% Process with WarmChorus
violin_warm = WarmChorus(violin, Fs4, distance, skill);
% Process with BasicChorus
violin_basic = BasicChorus(violin, Fs4);

% horrible orchestra:
% distance = 50;
% skill = 0.1;
% violin_horrible = WarmChorus(violin, Fs4, distance, skill);

%% Uncomment to listen the examples:
% soundsc([violin; violin_basic; violin_warm], Fs4);
% soundsc(violin_horrible, Fs4);