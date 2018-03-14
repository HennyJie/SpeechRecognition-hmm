function [frq,mr] = mel2frq(mel)

persistent k
if isempty(k)
    k=1127.01048;
end
frq=700*sign(mel).*(exp(abs(mel)/k)-1);
mr=(700+abs(frq))/k;
if ~nargout
    plot(mel,frq,'-x');
    xlabel(['Frequency (' xticksi 'Mel)']);
    ylabel(['Frequency (' yticksi 'Hz)']);
end
