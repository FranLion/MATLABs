function y1 = update1(x1)
   y1 = 1 + update2(x1);
end
function y2 = update2(x2)
   y2 = 2 * x2;
   
   X = [1,2,3];
   Y = update1(X);

end