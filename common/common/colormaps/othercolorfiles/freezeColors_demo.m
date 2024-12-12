% freezeColors_demo  demonstration of freezeColors
%
%   JRI 9/1/06  

%   Author:
%   John Iversen
%   john_iversen@post.harvard.edu

figure
set(gcf,'color',[1 1 1])

%plot a variety of objects using different colormaps
subplot(3,2,1); imagesc(peaks); axis xy; colormap jet; title('jet');freezeColors; freezeColors(colorbar)
subplot(3,2,2); imagesc(peaks); axis xy; colormap hot; title('hot');freezeColors; freezeColors(colorbar)

subplot(3,2,3); surf(peaks); shading interp; colormap jet; title('jet');freezeColors; freezeColors(colorbar)
subplot(3,2,4); surf(peaks); shading interp; colormap hot; title('hot');freezeColors; freezeColors(colorbar)

subplot(3,2,5); scatter(randn(100,1),randn(100,1),rand(100,1)*100,rand(100,1),'filled'); title('cool')
    colormap cool; freezeColors; axis(3*[-1 1 -1 1]); freezeColors(colorbar)
subplot(3,2,6); bar('v6',randn(4,3));xlim([0 5]);title('jet')
    colormap jet; freezeColors;
    
disp(' ')
disp('==freezeColors / unfreezeColors demo==')
disp(' ')
disp(' freezeColors enables you to use multiple colormaps in a single figure.')
disp(' ')
disp('For example, you should now be seeing plots using many different colormaps')
disp('  on the same figure. The way to do this is, e.g.:')
disp(' ')
disp('>> subplot(3,2,1); imagesc(peaks); colormap hot; freezeColors')
disp('>> subplot(3,2,3); surf(peaks); colormap hsv; freezeColors')
disp('  etc...')
disp(' ')
disp('  After running freezeColors on an axis, its objects'' colors are fixed and')
disp('  any further changes to the colormap or caxis won''t change its appearance.')
disp(' ')
disp('For example, hit any key to execute: ')
disp('>> colormap gray')

%show that changing the colormap has no effect on 'frozen' plots
pause
colormap gray

disp(' ')
disp('  As you can see, the colors are unchanged.')
disp('  ')
disp('  freezeColors can be undone using unfreezeColors.')
disp('  If you hit any key, the plots will be unfrozen, meaning that they will')
disp('  now be subject to the current colormap (gray).')
disp('  After you hit a key, you should see them change to a gray colormap.')

%demonstrate unfreezing
pause
unfreezeColors(gcf)
colormap gray

disp('==End of Demo==')

