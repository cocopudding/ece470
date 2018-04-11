function [ r ] = mykuka( dh )
% Define the Robot based on the DH table provided
L1=link([dh(1,:) 0],'standard');
L2=link([dh(2,:) 0],'standard');
L3=link([dh(3,:) 0],'standard');
L4=link([dh(4,:) 0],'standard');
L5=link([dh(5,:) 0],'standard');
L6=link([dh(6,:) 0],'standard');
r=robot({L1 L2 L3 L4 L5 L6});
end

