function curve2D = createParabole(height,width,numberOfPoints)
    %%% This function returns the [x,y] coordinates of a parabola of given
    %%% height and width
    %%% This parabola goes from the origin (0,0) to the point of 
    %%% coordinates (0,width) and culminates at the point (width/2, height)
    
    a = (-4*height)/(width.^2);
    b = 4*height/width ;
    t = linspace(0,width,numberOfPoints);
    y = a*t.^2 + b*t;

    curve2D = [t;y];
end