function plot_charging = plot_charging_robots(no_data_sets,matrix,no_columns,argos,folder)

fileName = 'Recharging robots';
fig = figure('Name',fileName,'NumberTitle','off','visible','off');
for i = 1:no_data_sets
    plot(matrix(((argos*(i-1))+1):(argos*i),1),matrix(((argos*(i-1))+1):(argos*i),3))
    hold on
end
xlabel('Time [min]')
ylabel('Number of charging robots')
subFileName = [folder + '/' + fileName];
fileName = [subFileName + '.png'];
saveas(fig,fileName);
hold off
