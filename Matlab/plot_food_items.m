function plot_food = plot_food_items(no_data_sets,matrix,no_columns,argos,folder)

max_food = [];
fileName = 'Food items collected';
fig = figure('Name',fileName,'NumberTitle','off','visible','off');
for i = 1:no_data_sets
    plot(matrix(((argos*(i-1))+1):(argos*i),1),matrix(((argos*(i-1))+1):(argos*i),(no_columns)))
    max_food = [max_food; matrix((argos*i),(no_columns))];
    hold on
end
xlabel('Time [min]')
ylabel('Number of food items')
subFileName = [folder + '/' + fileName];
fileName = [subFileName + '.png'];
saveas(fig,fileName);
hold off

plot_food = max_food;