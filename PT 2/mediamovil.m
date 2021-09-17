function [f]=mediamovil(h)

[m n]=size(h);

fmm=dsp.MovingAverage('Method','Sliding window','SpecifyWindowLength',true ...
           ,'WindowLength',6615)

for i=1:n
    f(:,i)=step(fmm,h(:,i));
end

end