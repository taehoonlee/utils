function overlayLevel(img, level)
    c = level - min(level(:));
    c = c / max(c(:));
    imshow(ind2rgb(floor(c*100), jet(100)));
    hold on;
    h = imagesc(img);
    hold off;
    level = abs(level);
    level = level / max(level(:));
    set(h, 'AlphaData', 1-level);