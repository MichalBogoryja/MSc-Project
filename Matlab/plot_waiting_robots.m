function plot_waiting = plot_waiting_robots(no_data_sets,matrix,no_columns,argos,folder)

fileName = 'Waiting robots';
fig = figure('Name',fileName,'NumberTitle','off','visible','off');
for i = 1:no_data_sets
    plot(matrix(((argos*(i-1))+1):(argos*i),1),matrix(((argos*(i-1))+1):(argos*i),4))
    hold on
end
xlabel('Time [min]')
ylabel('Number of waiting robots')
subFileName = [folder + '/' + fileName];
fileName = [subFileName + '.png'];
saveas(fig,fileName);
hold off
