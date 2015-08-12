function plotEllipse(p, radius, varargin)
    tt = linspace(0, 2*pi, 100)';
    ap = [cos(tt) sin(tt)]';
    [v,d] = eig(cov(p(:,1), p(:,2)));
    d = radius * sqrt(d);
    ep = (v*d*ap) + repmat(mean(p,1)', 1, size(ap,2));
    plot(ep(1,:), ep(2,:), varargin{1:nargin-2});