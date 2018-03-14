function sample(varargin)
global h

if (str2num(varargin{1}) == 1);
    x=invoke(h,'readwave');
    plot(x);
    soundsc(x);
end