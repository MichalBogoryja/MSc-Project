function plot_avg = myplot(no_data_sets,matrix,no_columns)

fileName = 'Avarage swarm battery level';
fig = figure('Name',fileName,'NumberTitle','off');
for i = 1:no_data_sets
    plot(matrix(((10*(i-1))+1):(10*i),1),matrix(((10*(i-1))+1):(10*i),(no_columns+1)))
    hold on
end
xlabel('Time[min]')
ylabel('Avarage battery level')
fileName = [fileName '.png'];
saveas(fig,fileName);
hold off