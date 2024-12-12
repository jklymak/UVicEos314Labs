function unfreezeColors(h)
% unfreezeColors  Restore colors of a plot to original indexed color
%
%   Useful if you want to apply a new colormap to plots whose
%       colors were previously frozen with freezeColors.
%
%   Usage:
%       unfreezeColors          unfreezes all objects in current axis, 
%       unfreezeColors(axh)     same, but works on axis axh.
%       unfreezeColors(figh)    same, but for on all objects figure figh.
%
%       Has no effect on objects on which freezeColors was not already called.
%
%   See also freezeColors, freezeColors_demo.
%
%   John Iversen (iversen@nsi.edu) 3/23/05
%
%   Changes:
%   JRI 9/1/06 now restores any object with frozen CData;
%           can unfreeze an entire figure at once

% Free for all uses, but please retain the following:
%   Original Author:
%   John Iversen
%   john_iversen@post.harvard.edu

if nargin < 1,
    h = gca;
end

%if h is a figure, loop on its axes
if strcmp(get(h,'type'),'figure'),
    h = get(h,'children');
end

for h1 = h', %loop on axes

    %process all children, acting on those with saved CData (JRI_freezeColorsData)
    ch = findobj(h1);
    for hh = ch',
        try %some object handls may be invalidated when their parent changes 
            %   (e.g. restoring colors of a scattergroup unfortunately changes
            %   the handles of all its children) so, wrap this test in try in
            %   case it fails.
            g=get(hh);
            if isappdata(hh,'JRI_freezeColorsData'),
                ad = getappdata(hh,'JRI_freezeColorsData');
                %get old cdata for size consistency check
                if ~strcmp(get(hh,'type'),'patch'),
                    cdata = get(hh,'cdata');
                else
                    cdata = get(hh,'facevertexcdata');
                    cdata = permute(cdata,[1 3 2]);
                end
                indexed = ad{1};
                scalemode = ad{2};
                if all(size(indexed) == size(cdata(:,:,1))),
                    %restore indexed cdata
                    if ~strcmp(get(hh,'type'),'patch'),
                        set(hh,'cdata',indexed);
                    else
                        set(hh,'facevertexcdata',indexed);
                    end
                    %restore cdatamapping, if needed
                    g = get(hh);
                    if isfield(g,'CDataMapping'),
                        set(hh,'cdatamapping',scalemode);
                    end
                    %clear appdata
                    rmappdata(hh,'JRI_freezeColorsData')
                else
                    warning(['Could not restore indexed data: it is the wrong size. ' ...
                        'Were the axis contents changed since the call to freezeColors?'])
                end
            end %test if has our appdata
        catch
        end

    end %loop on children

end %loop on axes

