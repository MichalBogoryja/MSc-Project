fileID = fopen('data1.txt','r');
fgetl(fileID);
fgetl(fileID);
formatSpecA = '%f %d %d %f %f %f %f %f %f %f %f %f %f %d';
dimensionsA = [14 Inf];
A = fscanf(fileID,formatSpecA,dimensionsA);
fclose(fileID);

fileBatteryID = fopen('battery_data3.txt','r');
fgetl(fileBatteryID);
formatSpecB = '%d %d %d %d %f %f %f';
dimensionsB = [7 Inf];
B = fscanf(fileBatteryID,formatSpecB,dimensionsB);
fclose(fileBatteryID);

A = A';
A(:,1) = (A(:,1)/10)/60;
[rows,columns] = size(A);
%caluculate mean battery level of all robots in particular moment 
for i = 1:rows
A(i,(columns+1)) = mean(A(i,4:(columns-1)));   
end

fileName = 'Avarage swarm battery level';
fig = figure('Name',fileName,'NumberTitle','off');
plot(A(:,1),A(:,(columns+1)))
xlabel('Time[min]')
ylabel('Avarage battery level')
fileName = [fileName '.png'];
saveas(fig,fileName);

fileName = 'Robots battery level';
fig = figure('Name','Robots battery level','NumberTitle','off');
for i = 4:(columns-1)
    plot(A(:,1),A(:,i))
    hold on
end
xlabel('Time[min]')
ylabel('Battery level')
fileName = [fileName '.png'];
saveas(fig,fileName);

fileName = 'Food items collected';
fig = figure('Name',fileName,'NumberTitle','off');
plot(A(:,1),A(:,(columns)))
xlabel('Time[min]')
ylabel('Number of food items')
fileName = [fileName '.png'];
saveas(fig,fileName);

fileName = 'Percentage of operating robots';
fig = figure('Name',fileName,'NumberTitle','off');
plot(A(:,1),((A(:,2))/10)*100)
xlabel('Time[min]')
ylabel('%')
fileName = [fileName '.png'];
saveas(fig,fileName);

B = B';
fileName = ['Charge when deciding to recharge' '.png'];
xlabel('Different algorithms')
box = boxplot(B(:,5),'Labels',{'Algorithm#1'});
saveas(gcf,fileName)