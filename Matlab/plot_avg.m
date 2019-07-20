function plot_avg = plot_avg(no_data_sets,matrix,no_columns,argos,folder)

yolo = [];
fileName = 'Avarage swarm battery level';
fig = figure('Name',fileName,'NumberTitle','off','visible','off');
for i = 1:no_data_sets
    plot(matrix(((argos*(i-1))+1):(argos*i),1),matrix(((argos*(i-1))+1):(argos*i),(no_columns+1)))
    yolo = [yolo; mean(matrix(((argos*(i-1))+1):(argos*i),(no_columns+1)))];
    hold on
end
xlabel('Time [min]')
ylabel('Avarage battery level')
subFileName = [folder + '/' + fileName];
fileName = [subFileName + '.png'];
saveas(fig,fileName);
hold off

plot_avg = yolo;