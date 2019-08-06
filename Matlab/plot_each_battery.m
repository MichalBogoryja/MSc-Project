function plot_battery = plot_each_battery(no_data_sets,matrix,no_columns,argos,folder)

for i = 1:no_data_sets
    fileName = sprintf('Robots battery level %d', i);
    fig = figure('Name',fileName,'NumberTitle','off','visible','off');
    for j = 5:(no_columns-1)
        plot(matrix(((argos*(i-1))+1):(argos*i),1),matrix(((argos*(i-1))+1):(argos*i),j));
        hold on
    end
    xlabel('Time [min]')
    ylabel('Battery level')
    subFileName = [folder + '/' + fileName];
    fileName = [subFileName + '.png'];
    saveas(fig,fileName);
    hold off
end
