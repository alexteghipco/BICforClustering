function [knee] = findKneeScatter(curveX,curveY,lnEndPts)
% lnEndPts is either 'minmax' or 'firstlast'
%figure('Name','Elbow in scatterplot'), scatter(curveX,curveY,4,[0.8500 0.3250 0.0980],'filled')
figure('Name','Elbow in scatterplot'), scatter(curveX,curveY,4,[0 0 0],'filled')
hold on
%% create line
switch lnEndPts
    case 'firstlast'
        %# get vector between first and last point - this is the line
        s = (curveY(1) - curveY(end)) / (curveX(1) - curveX(end));
        for i = 1:length(curveX)
            newY(i) = (s*(curveX(i) - curveX(1))) + curveY(1);
        end
        %scatter(curveX,newY,4,[0.3010 0.7450 0.9330],'filled')
        scatter(curveX,newY,4,[0.8500 0.3250 0.0980],'filled')

    case 'minmax'
        %# get vector between min and max point - this is the line
%         [maxV maxIdx] = max(curveY);
%         [minV minIdx] = min(curveX);
%         
%         scatter(xx,yy,4,'or','filled')
end

%% get distances and plot lines
for i = 1:length(curveX)
   diff(i,1) = curveY(i) - newY(i);

   p = plot([curveX(i) curveX(i)],[newY(i) curveY(i)],'Color',[0.6 0.6 0.6]);
   p.LineStyle = ':';
   p.LineWidth = 0.2;
end

%# now all you need is to find the maximum
[maxDist,idxOfBestPoint] = max(diff);

%# plot
knee = curveX(idxOfBestPoint);
scatter(knee,curveY(idxOfBestPoint),50,[1 0 0],'LineWidth',1)
q = plot([curveX(idxOfBestPoint) curveX(idxOfBestPoint)],[newY(idxOfBestPoint) curveY(idxOfBestPoint)],'r');
q.LineWidth = 1;
set(gcf,'color','w');
ax = gca;
ax.TickLength = [0 0];

%figure('Name','Distance from line'), scatter(curveX,diff,4,[0.3010 0.7450 0.9330],'filled')
figure('Name','Distance from line'), scatter(curveX,diff,4,[0 0 0],'filled')
hold on 
scatter(knee,diff(idxOfBestPoint),50,'or','LineWidth',1)
set(gcf,'color','w');
ax = gca;
ax.TickLength = [0 0];
