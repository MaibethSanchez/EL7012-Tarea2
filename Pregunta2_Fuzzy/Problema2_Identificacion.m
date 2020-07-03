clear all, clc
% load('DataEstanque.mat')
% % 
% % % % % %------------Contrucci�n del vector de datos-------------------
% [Ref,Entrada,Salida,Tiempo] = MuestreoConstante(Ref,Entrada,Salida,Tiempo);
% %60% para entrenamiento
% %20% test y 20% validaci�n
% Dt=6500;         %Tama�o del vector
% y=normalizar(Salida,[15 50],[0 1]);  %Normalizar la altura de [15 55] a [0 1]
% u=normalizar(Entrada,[0 100],[0 1]); %Normalizar le frecuencia de [0 100] a [0 1]
% ry=3;
% ru=1;
% [X, Y] = createMatrixInput(Dt, ry, ru, y, u);
% 
% le=Dt*0.6;      %Limites de los conjuntos de entrenamiento y prueba
% lp=Dt*(0.6+0.2);
% 
% Xent = X(1:le,:);
% Yent = Y(1:le,:);
% Xtest = X(le+1:lp, :);
% Ytest = Y(le+1:lp, :); 
% Xval = X(lp+1:Dt, :);
% Yval = Y(lp+1:Dt, :);
% 
% savefile = 'DatosProblema2_r4.mat';
% save(savefile, 'Xent', 'Xtest','Xval', 'Yent', 'Ytest', 'Yval');
%  %----------------------------------------------------------------------- 

% %---------------------Modelo Difuso--------------------------------------
% %-----------------Analisis de sensibilidad-------------------------------
% load('DatosProblema2_r12');
% % % % Seleccion del n�mero �ptimo de clusters
% % max_clusters=15;
% % [errtest,errent] = clusters_optimo(Ytest,Yent,Xtest,Xent,max_clusters);
% reglas=3; %Clusters
% [~, v]=size(Xent);
% errS=zeros(v,1);
% VarDelete=zeros(v,1);
% varD=1:v;
% for i=v:-1:1
%     % Calcular el error con el numero de cluster (reglas)
%     errS(i)=errortest(Yent,Xent,Ytest,Xtest,reglas);
%     
%     % Analisis de sensibilidad
%     [p, indice]=sensibilidad(Yent,Xent,reglas);
%     VarDelete(i)=p;
%     Xent(:,p)=[];
%     Xtest(:,p)=[];
%     Xval(:,p)=[];
%     varD(p)
%     varD(p)=[];
% end

% %Grafico Sensibilidad
% figure()
% c = categorical({'y(k-1)','y(k-2)','y(k-3)','u(k-1)'},{'y(k-1)','y(k-2)','y(k-3)','u(k-1)'});
% bar(c,indice,'b','LineWidth',2);
% xlabel('Variables de entrada')
% ylabel('I')


%----------Seleccion de Variables Relevantes---
MD=[1 2 2]; %Meto de clusterin difuso a utilizar MD(2)=1 GK   MD(2)=2 Fuzzy C-Means
% Seleccion del n�mero �ptimo de clusters
load('DatosProblema2_r4');
% max_clusters=15;
% [errtest,errent] = clusters_optimo(Ytest,Yent,Xtest,Xent,max_clusters);
reglas=6; %Clusters
%-----Obtenci�n modelo. Parametros antecedentes y consecuentes-------------
[model_r1, result_r1]=TakagiSugeno(Yent,Xent,reglas,MD);

% Modelo 3
y_r1_e=ysim(Xent,model_r1.a,model_r1.b,model_r1.g);
y_r1_t=ysim(Xtest,model_r1.a,model_r1.b,model_r1.g);
y_r1_v=ysim(Xval,model_r1.a,model_r1.b,model_r1.g);

e_r1(1,1)=RMSE(Yent,y_r1_e);
e_r1(2,1)=MAPE(Yent,y_r1_e);
e_r1(3,1)=MAE(Yent,y_r1_e);
e_r1(1,2)=RMSE(Ytest,y_r1_t);
e_r1(2,2)=MAPE(Ytest,y_r1_t);
e_r1(3,2)=MAE(Ytest,y_r1_t);
e_r1(1,3)=RMSE(Yval,y_r1_v);
e_r1(2,3)=MAPE(Yval,y_r1_v);
e_r1(3,3)=MAE(Yval,y_r1_v);


load('DatosProblema2_r6');
max_clusters=9;
[errtest,errent] = clusters_optimo(Ytest,Yent,Xtest,Xent,max_clusters);
reglas=5; %Clusters
%-----Obtenci�n modelo. Parametros antecedentes y consecuentes-------------
[model_r6, result_r6]=TakagiSugeno(Yent,Xent,reglas,MD);

Modelo 2
y_r6_e=ysim(Xent,model_r6.a,model_r6.b,model_r6.g);
y_r6_t=ysim(Xtest,model_r6.a,model_r6.b,model_r6.g);
y_r6_v=ysim(Xval,model_r6.a,model_r6.b,model_r6.g);

e_r6(1,1)=RMSE(Yent,y_r6_e);
e_r6(2,1)=MAPE(Yent,y_r6_e);
e_r6(3,1)=MAE(Yent,y_r6_e);
e_r6(1,2)=RMSE(Ytest,y_r6_t);
e_r6(2,2)=MAPE(Ytest,y_r6_t);
e_r6(3,2)=MAE(Ytest,y_r6_t);
e_r6(1,3)=RMSE(Yval,y_r6_v);
e_r6(2,3)=MAPE(Yval,y_r6_v);
e_r6(3,3)=MAE(Yval,y_r6_v);

load('DatosProblema2_r24');
max_clusters=9;
[errtest,errent] = clusters_optimo(Ytest,Yent,Xtest,Xent,max_clusters);
reglas=5; %Clusters
% -----Obtenci�n modelo. Parametros antecedentes y consecuentes-------------
[model_r24, result_r24]=TakagiSugeno(Yent,Xent,reglas,MD);

% Modelo 1
y_r24_e=ysim(Xent,model_r24.a,model_r24.b,model_r24.g);
y_r24_t=ysim(Xtest,model_r24.a,model_r24.b,model_r24.g);
y_r24_v=ysim(Xval,model_r24.a,model_r24.b,model_r24.g);

e_r24(1,1)=RMSE(Yent,y_r24_e);
e_r24(2,1)=MAPE(Yent,y_r24_e);
e_r24(3,1)=MAE(Yent,y_r24_e);
e_r24(1,2)=RMSE(Ytest,y_r24_t);
e_r24(2,2)=MAPE(Ytest,y_r24_t);
e_r24(3,2)=MAE(Ytest,y_r24_t);
e_r24(1,3)=RMSE(Yval,y_r24_v);
e_r24(2,3)=MAPE(Yval,y_r24_v);
e_r24(3,3)=MAE(Yval,y_r24_v);

% Graficas de cluster para la salida
figure()
plot(Yent,model_r24.h (:,1),'b+',Yent,model_r24.h (:,2),'r+')
title('Clusters para  la salida. Modelo 1')
xlabel('y(k)')
ylabel('Grado de pertenencia')

figure()
plot(Yent,model_r6.h (:,1),'b+',Yent,model_r6.h (:,2),'r+')
title('Clusters para  la salida. Modelo 2')
xlabel('y(k)')
ylabel('Grado de pertenencia')

figure()
plot(Yent,model_r1.h (:,1),'b+',Yent,model_r1.h (:,2),'r+')
title('Clusters para  la salida. Modelo 3')
xlabel('y(k)')
ylabel('Grado de pertenencia')

%Grafica de los modelos. Conjunto de validaci�n.  
figure ()
plot(y_r1_v,'--')
hold on
plot(Yval,'red')
legend('Estimaci�n Modelo 3','Modelo real')
xlabel('t')
ylabel('Salida del modelo')% %Evaluaci�n del modelo Original
xlim([168 288])

figure ()
plot(y_r24_v,'--')
hold on
plot(Yval,'red')
legend('Estimaci�n Modelo 1','Modelo real')
xlabel('t')
ylabel('Salida del modelo')
xlim([168 288])

figure ()
plot(y_r6_v,'--')
hold on
plot(Yval,'red')
legend('Estimaci�n Modelo 2','Modelo real')
xlabel('t')
ylabel('Salida del modelo')
xlim([168 288])

%-----------%Prediccion a j-pasos del modelo Original. Paso 6 y 12
% Modelo 1
RA=ones(1,24);
[y6_r24_v,x6_r24_v]=ysim_p2(Xval,model_r24.a,model_r24.b,model_r24.g,1,RA); %prediccion a 6 pasos
e6(1,1)=RMSE(Yval,y6_r24_v);
e6(2,1)=MAE(Yval,y6_r24_v);

[y12_r24_v,x12_r24_v]=ysim_p2(Xval,model_r24.a,model_r24.b,model_r24.g,11,RA); %prediccion a 12 pasos
e12(1,1)=RMSE(Yval,y12_r24_v);
e12(2,1)=MAE(Yval,y12_r24_v);

% Modelo 2
RA=[1 1 0 0 0 0 0 0 0 1  1 1 0 0 0 0 0 0 0 0 0 0 1 0];
[y6_r6_v,x6_r6_v]=ysim_p2(Xval,model_r6.a,model_r6.b,model_r6.g,1,RA); %prediccion a 6 pasos
e6(1,2)=RMSE(Yval,y6_r6_v);
e6(2,2)=MAE(Yval,y6_r6_v);

[y12_r6_v,x12_r6_v]=ysim_p2(Xval,model_r6.a,model_r6.b,model_r6.g,11,RA); %prediccion a 12 pasos
e12(1,2)=RMSE(Yval,y12_r6_v);
e12(2,2)=MAE(Yval,y12_r6_v);

% Modelo 3
RA=[1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
[y6_r1_v,x6_r1_v]=ysim_p2(Xval,model_r1.a,model_r1.b,model_r1.g,1,RA); %prediccion a 6 pasos
e6(1,3)=RMSE(Yval,y6_r1_v);
e6(2,3)=MAE(Yval,y6_r1_v);

[y12_r1_v,x12_r1_v]=ysim_p2(Xval,model_r1.a,model_r1.b,model_r1.g,11,RA); %prediccion a 12 pasos
e12(1,3)=RMSE(Yval,y12_r1_v);
e12(2,3)=MAE(Yval,y12_r1_v);

%Grafica de los modelos a p pasos. Conjunto de validaci�n.  
figure ()
plot(y6_r1_v,'--')
hold on
plot(Yval,'red')
legend('Estimaci�n Modelo 3','Modelo real')
xlabel('t')
ylabel('Salida del modelo')% %Evaluaci�n del modelo Original
title('Estimaci�n a 6 pasos ');
xlim([168 288])
% 
figure ()
plot(y6_r24_v,'--')
hold on
plot(Yval,'red')
legend('Estimaci�n Modelo 1','Modelo real')
xlabel('t')
ylabel('Salida del modelo')
title('Estimaci�n a 6 pasos ');
xlim([168 288])

figure ()
plot(y6_r6_v,'--')
hold on
plot(Yval,'red')
legend('Estimaci�n Modelo 2','Modelo real')
xlabel('t')
ylabel('Salida del modelo')
title('Estimaci�n a 6 pasos ');
xlim([168 288])

%12 pasos
figure ()
plot(y12_r1_v,'--')
hold on
plot(Yval,'red')
legend('Estimaci�n Modelo 3','Modelo real')
xlabel('t')
ylabel('Salida del modelo')% %Evaluaci�n del modelo Original
title('Estimaci�n a 12 pasos ');
xlim([168 288])
% 
figure ()
plot(y12_r24_v,'--')
hold on
plot(Yval,'red')
legend('Estimaci�n Modelo 1','Modelo real')
xlabel('t')
ylabel('Salida del modelo')
title('Estimaci�n a 12 pasos ');
xlim([168 288])

figure ()
plot(y12_r6_v,'--')
hold on
plot(Yval,'red')
legend('Estimaci�n Modelo 2','Modelo real')
xlabel('t')
ylabel('Salida del modelo')
title('Estimaci�n a 12 pasos ');
xlim([168 288])

% -----------------Intervalos Difusos
% M�todo de la Covarianza
alpha=3;
% Modelo 1
% Estimaci�n a un paso
[~,yEst_u,yEst_l]=Covarianza(Xent,Yent,Xval,model_r24.a,model_r24.b,model_r24.g,alpha);
% Estimaci�n a  6 paso
[~,yEst_u8,yEst_l8]=Covarianza(Xent,Yent,x6_r24_v,model_r24.a,model_r24.b,model_r24.g,alpha);
% Estimaci�n a 12 paso
alpha=8;
[~,yEst_u16,yEst_l16]=Covarianza(Xent,Yent,x12_r24_v,model_r24.a,model_r24.b,model_r24.g,alpha);

y_u=[yEst_u; yEst_u8; yEst_u16];
y_l=[yEst_l; yEst_l8; yEst_l16];

[a,b]=size(y_l);
for i=1:a
    for j=1:b
        if y_l(i,j)<0
            y_l(i,j)=0;
        end
    end
end


for i=1:3
ePINAW_r24(i)= PINAW(Yval,y_u(i,:),y_l(i,:));
ePICP_r24(i)= PICP(Yval,y_u(i,:),y_l(i,:));
plot_Intervalos(Yval',y_u(i,:),y_l(i,:))
end

Modelo 2
% Estimaci�n a un paso
load('DatosProblema2_r6');
alpha=3;
[~,yEst_u,yEst_l]=Covarianza(Xent,Yent,Xval,model_r6.a,model_r6.b,model_r6.g,alpha);
% Estimaci�n a  6 paso
[~,yEst_u8,yEst_l8]=Covarianza(Xent,Yent,x6_r6_v,model_r6.a,model_r6.b,model_r6.g,alpha);
% Estimaci�n a 12 paso
alpha=8;
[~,yEst_u16,yEst_l16]=Covarianza(Xent,Yent,x12_r6_v,model_r6.a,model_r6.b,model_r6.g,alpha);

y_u=[yEst_u; yEst_u8; yEst_u16];
y_l=[yEst_l; yEst_l8; yEst_l16];

[a,b]=size(y_l);
for i=1:a
    for j=1:b
        if y_l(i,j)<0
            y_l(i,j)=0;
        end
    end
end

for i=1:3
ePINAW_r6(i)= PINAW(Yval,y_u(i,:),y_l(i,:));
ePICP_r6(i)= PICP(Yval,y_u(i,:),y_l(i,:));
plot_Intervalos(Yval',y_u(i,:),y_l(i,:))
end

% Modelo 3
load('DatosProblema2_r1');
% Estimaci�n a un paso
alpha=3;
[~,yEst_u,yEst_l]=Covarianza(Xent,Yent,Xval,model_r1.a,model_r1.b,model_r1.g,alpha);
% Estimaci�n a  6 paso
[~,yEst_u8,yEst_l8]=Covarianza(Xent,Yent,x6_r1_v,model_r1.a,model_r1.b,model_r1.g,alpha);
% Estimaci�n a 12 paso
alpha=8;
[~,yEst_u16,yEst_l16]=Covarianza(Xent,Yent,x12_r1_v,model_r1.a,model_r1.b,model_r1.g,alpha);

y_u=[yEst_u; yEst_u8; yEst_u16];
y_l=[yEst_l; yEst_l8; yEst_l16];

[a,b]=size(y_l);
for i=1:a
    for j=1:b
        if y_l(i,j)<0
            y_l(i,j)=0;
        end
    end
end

for i=1:3
ePINAW_r1(i)= PINAW(Yval,y_u(i,:),y_l(i,:));
ePICP_r1(i)= PICP(Yval,y_u(i,:),y_l(i,:));
plot_Intervalos(Yval',y_u(i,:),y_l(i,:))
end

