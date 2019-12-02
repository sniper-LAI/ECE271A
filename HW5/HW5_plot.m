clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot for problem a
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dimension = [1,2,4,8,16,24,32,40,48,56,64];
for FG=1:1:5
    for BG=1:1:5
        load(['savedata/error_FG=',num2str(FG),'&BG=',num2str(BG),'.mat']);
        %Plot the data
        figure(1);
        plot(dimension,error);
        hold on;
    end
    saveas(gcf, ['images/FG=',num2str(FG)','.jpg']);
    close(gcf);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot for problem a
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dimension = [1,2,4,8,16,24,32,40,48,56,64];
for C=[1,2,4,8,16,32]
    load(['savedata/error_C=',num2str(C),'&M=',num2str(0),'.mat']);
    %Plot the data
    figure(1);
    plot(dimension,error);
    hold on;
end
saveas(gcf, ['images/mix_C.jpg']);
close(gcf);