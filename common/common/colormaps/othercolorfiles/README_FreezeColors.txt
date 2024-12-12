Matlab functions for using multiple colormaps per figure
version 2, 9/2006

AUTHOR
John Iversen
john_iversen@post.harvard.edu

Free for any use, so long as author information remains with code.

CONTENTS

A pair of functions

	freezeColors 	Converts colors of graphics objects (images, surfaces, patches, etc. using indexed color CData) into [r g b] making them immune to changes in the colormap.
	unfreezeColors 	Restores the original indexed color data, allowing the colormap and caxis to again affect the graphics objects. 

	freezeColors_demo  Demonstration of usage.

DESCRIPTION

Problem: There is only one colormap per figure, so all plots share the same colormap. Often one wants different colormaps.

Solution: This function pair provides an easy way to use different colomaps in the same figure.

Example:
subplot(2,1,1)
imagesc(X)
colormap hot
freezeColors

subplot(2,1,2)
surf(Y)
colormap hsv
etc...

Note, you can also pass a handle to freezeColors. This is useful if you'd like to freeze the colors of a colorbar:

h=colorbar;
freezeColors(h), or simply:
freezeColors(colorbar)

To undo the effects of freezeColors, simply use unfreezeColors.

JRI 6/2005
JRI 9/2006 now operates on all objects with CData (not just images as before)