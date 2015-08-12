# utils
A collection of MATLAB helper functions for visualization and something miscellaneous.<br />
Copyright (c) 2015 Taehoon Lee

# Functions
<li> `visualization\overlayLevel.m`: overlay coefficients (*e.g.* activation level) on an image. </li>
<li> `visualization\plotEllipse.m`: plot a gaussian ellipsoid of a distribution. </li>

# Example Codes and Results

### overlayLevel
```MATLAB
% download an example image
urlwrite('http://www.nzbri.org/research/labs/mristatic/web_3TMRI_html_m3cf3a36c.jpg', 'test.jpg');
img = imread('test.jpg');

% generate a set of coefficients
c = 128:383;
X = zeros(512,512); X(c,c) = repmat(linspace(-3.14, 3.14, 256), 256, 1);
Y = zeros(512,512); Y(c,c) = repmat(linspace(-3.14, 3.14, 256)', 1, 256);
level = sin(X).*sin(Y);

% show results
figure;
subplot(1,3,1); imshow(img);
subplot(1,3,2); imagesc(level);
subplot(1,3,3); overlayLevel(img, level);
```
![Alt text](/visualization/results_overlayLevel.png?raw=true "Results of overlayLevel")

### plotEllipse
```MATLAB
% generate example data
a = randn(100, 2) * [1 -2; -2 1];

% show results
figure;
subplot(1,3,1); plot(a(:,1), a(:,2), 'k.');
subplot(1,3,2); plotEllipse(a, 1, 'r-');
subplot(1,3,3);
hold on;
plot(a(:,1), a(:,2), 'k.');
plotEllipse(a, 1, 'r-');
plotEllipse(a, 2, 'b-');
legend({'samples', '1 sigma', '2 sigma'});
hold off;
```
![Alt text](/visualization/results_plotEllipse.png?raw=true "Results of plotEllipse")
