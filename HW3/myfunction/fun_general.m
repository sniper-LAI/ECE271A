function []=fun_general(dataset,train_BG,train_FG,alpha,i)
%This function is comparasion of using different strategy, different dataset and
%different method plugging in BDR
%i - represent the strategy we use

%Define the strategy we use
s=i; k=1;
%Define the array to store error
error_pre = zeros(size(alpha));
error_ml = zeros(size(alpha));
error_map = zeros(size(alpha));

% for Alpha=alpha
%     error_map(1,k) = fun_mapBDR(train_BG,train_FG,Alpha,s)
%     k=k+1;
% end

for Alpha=alpha
    error_pre(1,k) = fun_bayesBDR(train_BG,train_FG,Alpha,s)
    error_map(1,k) = fun_mapBDR(train_BG,train_FG,Alpha,s)
    k=k+1;
end
error_ml(1,:)=fun_mlBDR(train_BG,train_FG);
%Plot the data
figure(1);
line_pre = plot(alpha,error_pre);
hold on;
line_map = plot(alpha,error_map);
hold on;
line_ml = plot(alpha,error_ml);
legend({'Predictive','MAP','ML'},'Location','southeast');
set(gca,'XScale','log');
grid on;
title({['Dataset_',num2str(dataset),' and Strategy_',num2str(i)]...
    ;['PoE vs Alpha']},'Fontsize',12,'interpreter','latex');
ylabel('PoE', 'interpreter', 'latex');
xlabel('Alpha', 'interpreter', 'latex'); 
set(gcf,'Position',[400,100,900,600]);
saveas(gcf, ['images/PoE of D',num2str(dataset),' and strategy'...
   , num2str(i),'.jpg']);
close(gcf);

end