function plot_dead = plot_dead_robots(no_data_sets,matrix,no_columns,argos,folder)

max_dead = [];
fileName = 'Robots completely discharged';
fig = figure('Name',fileName,'NumberTitle','off','visible','off');
for i = 1:no_data_sets
    plot(matrix(((argos*(i-1))+1):(argos*i),1),matrix(((argos*(i-1))+1):(argos*i),(no_columns+2)))
    max_dead = [max_dead; matrix((argos*i),(no_columns+2))];
    hold on
end
xlabel('Time [min]')
ylabel('Percentage of robots')
subFileName = [folder + '/' + fileName];
fileName = [subFileName + '.png'];
saveas(fig,fileName);
hold off

plot_dead = max_dead;