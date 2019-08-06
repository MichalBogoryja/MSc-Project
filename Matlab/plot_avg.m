function plot_avg = plot_avg(no_data_sets,matrix,no_columns,argos,folder)

yolo = [];
fileName = 'Avarage swarm battery level';
fig = figure('Name',fileName,'NumberTitle','off','visible','off');
for i = 1:no_data_sets
    if i == 1
        plot(matrix(((argos*(i-1))+1):(argos*i),1),matrix(((argos*(i-1))+1):(argos*i),(no_columns+1)),'DisplayName',int2str(i))
    end
    yolo = [yolo; mean(matrix(((argos*(i-1))+1):(argos*i),(no_columns+1)))];
    hold on
end
xlabel('Time [min]')
ylabel('Avarage battery level')
subFileName = [folder + '/' + fileName];
fileName = [subFileName + '.png'];
lgd = legend('Location','northeast','Orientation','horizontal');
lgd.NumColumns = 5;
saveas(fig,fileName);
hold off
% legend({'1','2','3','4','5','6','7','8','9','10'},'Location','northeast','Orientation','horizontal')


plot_avg = yolo;