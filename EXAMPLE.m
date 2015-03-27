% This example shows how to use WarmChorus function:
%
% Aku Rouhe & Niklas Sallinen

%%Reading input files:
[gtr_lead, Fs1] = audioread('SoundSamples/GuitarLeadDRY.wav');
[gtr_crd, Fs2] = audioread('SoundSamples/GuitarChordsDRY.wav');
[gtr_dst, Fs3] = audioread('SoundSamples/GuitarDistortedDRY.wav');
[violin, Fs4] = audioread('SoundSamples/DRYSAMPLE.wav');
[music, Fs5] = audioread('SoundSamples/musicDRY.wav');

%%Parameter values
% typical values:
distance = 5;   % Maximum distance between players
skill    = 0.5; % Skill factor of players
% horrible orchestra:
horrible_distance = 50;
horrible_skill = 0.1;

%%Processing
% Process with WarmChorus:
violin_warm = WarmChorus(violin, Fs4, distance, skill);
% Process with BasicChorus for comparison:
violin_basic = BasicChorus(violin, Fs4);

violin_horrible = WarmChorus(violin, Fs4, horrible_distance, horrible_skill);

%% Uncomment to listen the examples:
% soundsc([violin; violin_basic; violin_warm], Fs4); %First the dry, then the generic and finally Warm Chorus.
% soundsc(violin_horrible, Fs4);
