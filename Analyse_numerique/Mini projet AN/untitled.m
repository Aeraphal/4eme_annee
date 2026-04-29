clear variables;
close all;
v=VideoWriter('seq_video.avi');
open(v);
t=-5:0.01:5;
for a=5:-0.02:0.01
plot(t,exp(-(t.^2)/a),'linewidth',2);
drawnow;
thisframe=getframe(gcf);
writeVideo(v,thisframe);
end
close(v);