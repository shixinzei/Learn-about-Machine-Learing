%% I. ��ջ���
clc
clear all

%% II. ����Ŀ�꺯������ͼ
x = 1:0.01:10;
y = sin(10*pi*x) ./ x;
% y = 1/2.*x.^4-3.*x.^3+2.*x+10;
figure
plot(x, y)
hold on

%% III. ������ʼ��
c1 = 1.49445;
c2 = 1.49445;

maxgen = 50;   % ��������  
sizepop = 10;   %��Ⱥ��ģ

Vmax = 0.5;
Vmin = -0.5;
popmax = 10;
popmin = 1;

%% IV. ������ʼ���Ӻ��ٶ�
for i = 1:sizepop
    % �������һ����Ⱥ
    pop(i,:) = (rands(1) + 1) / 2 + 1;    %��ʼ��Ⱥ
    V(i,:) = 0.5 * rands(1);  %��ʼ���ٶ�
    % ������Ӧ��
%     �޸ĵ�
    fitness(i) = fun(pop(i,:));   
%     if pop(i,:)>1.5
%         fitness(i) = fun(pop(i,:)); 
%     end
end

%% V. ���弫ֵ��Ⱥ�弫ֵ
[bestfitness bestindex] = max(fitness);
zbest = pop(bestindex,:);   %ȫ�����
gbest = pop;    %�������
fitnessgbest = fitness;   %���������Ӧ��ֵ
fitnesszbest = bestfitness;   %ȫ�������Ӧ��ֵ

%% VI. ����Ѱ��
for i = 1:maxgen
    
    for j = 1:sizepop
        % �ٶȸ���
        V(j,:) = V(j,:) + c1*rand*(gbest(j,:) - pop(j,:)) + c2*rand*(zbest - pop(j,:));
        V(j,find(V(j,:)>Vmax)) = Vmax;
        V(j,find(V(j,:)<Vmin)) = Vmin;
        
        % ��Ⱥ����
        pop(j,:) = pop(j,:) + V(j,:);
        pop(j,find(pop(j,:)>popmax)) = popmax;
        pop(j,find(pop(j,:)<popmin)) = popmin;
        
        % ��Ӧ��ֵ����
%         �޸ĵ�
        fitness(j) = fun(pop(j,:)); 
%         if pop(j,:)>1.5
%             fitness(j) = fun(pop(j,:)); 
%         end
    end
    
    for j = 1:sizepop    
        % �������Ÿ���
        if fitness(j) > fitnessgbest(j)
            gbest(j,:) = pop(j,:);
            fitnessgbest(j) = fitness(j);
        end
        
        % Ⱥ�����Ÿ���
        if fitness(j) > fitnesszbest
            zbest = pop(j,:);
            fitnesszbest = fitness(j);
        end
    end 
    yy(i) = fitnesszbest;          
end

%% VII. ����������ͼ
[fitnesszbest zbest]
plot(zbest, fitnesszbest,'r*')

figure
plot(yy)
title('���Ÿ�����Ӧ��','fontsize',12);
xlabel('��������','fontsize',12);ylabel('��Ӧ��','fontsize',12);

