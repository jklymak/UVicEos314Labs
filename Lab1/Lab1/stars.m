function stars(t)
  %STARS(T)       draws stars with parameter t
  n = t * 50;
  plot(rand(1,n), rand(1,n),'*');
  %that line plots n random points
  title('Oh My, Look at all the Stars!');
  %label the graph
