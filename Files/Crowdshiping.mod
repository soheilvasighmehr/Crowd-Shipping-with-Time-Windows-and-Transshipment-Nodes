/*********************************************
 * OPL 22.1.0.0 Model
 * Author: Amir Mohammad Hemati
 * Creation Date: Jan 13, 2024 at 3:18:50 PM
 *********************************************/
/* Sets*/
{int} s={1};
{int} t={2};
{int}  C={3,4,5};
{int}  R={6,7};
{int}  T={8};
{int}  U={9,10};
{int}  V={11,12};
{int}  K={13,14};


/* Parameters*/
float Auk[K]=[5,9];
float Lvk[K] =[35,40];
int nNode=14;
range origin=1..nNode;
range dest=1..nNode;
int cost[origin][dest]=...;
int time[origin][dest]=...;
{int} CR= C union R;
int e[CR]=[1,2,3,1,2];      /*i in C+R*/
int l[CR]=[8,12,20,28,32];      /*i in C+R*/
int d[CR]=[6,9,12,8,15];      /*i in C+R*/
{int} CRTs= C union R union T union s;
int w[CRTs]=[2,3,5,6,4,3,3];      /*i in C+R+T+{s}*/
int P=1;
int Q=10;
int QKk=20;
int QTp=50;
int M = sum(i in CR)d[i];
int start=1;
int Uk[K]=[11,12];
int Vk[K]=[13,14];
int TN[T]=[8];

/* Variables */
range CV_Origin=1..2;
range CV_Dest=1..2;
dvar  boolean x[CV_Origin][CV_Dest];
dvar  int+ y[CV_Origin][CV_Dest];
dvar  float+ S[C];
range p=1..P;
{int} Ts= T union s;
dvar boolean r_k_ip[K][CR][Ts];
dvar float+ f_k_p[K][Ts];
dvar float+ tw[CR];
dvar int+ delta[T];
{int} CT= C union T;
dvar boolean Z[CT];

/* THE MODEL OPTIMIZATION*/

minimize  (sum(k in K,p in Ts ,i in CR)(cost[Uk[k]][p] + cost[p][i] + cost[i][Vk[k]] - cost[Uk[k]][Vk[k]]) + sum(i in C)2*cost[start][i]*Z[i] + sum(p in T)2*cost[start][p]*Z[p]); 

subject to
{
  cons1:forall(k in K) sum(p in Ts,i in CR) r_k_ip[k][i][p] <= card(CR);
  cons2:forall(i in R) sum(p in Ts,k in K) r_k_ip[k][i][p]==1;
  cons3:forall(p in Ts,k in K)f_k_p[k][p]>=( Auk[k] + time[Uk[k]][p] - M*(1-sum(i in CR)r_k_ip[k][i][p]));
  cons4:forall(i in CR,p in Ts,k in K) tw[i] >= (f_k_p[k][p] + w[p] + time[p][i]- M*(1-r_k_ip[k][i][p]));
  cons5:forall(i in R)e[i]<=tw[i]<=l[i];
  cons6:forall(i in C)e[i]-M*(1-sum(p in Ts,k in K)r_k_ip[k][i][p]) <= tw[i];
  cons7:forall(i in C)tw[i] <= l[i] + M*(1-sum(p in Ts,k in K)r_k_ip[k][i][p]);
  cons8:forall(i in CR, p in Ts ,k in K) tw[i] + w[i] + time[i][Vk[k]] <= Lvk[Vk[k]] + M*( 1 - r_k_ip[k][i][p]);
  cons9:forall(i in CR, p in Ts,k in K) r_k_ip[k][i][p] <= (QKk)/ d[i];
  cons10:forall(p in T) delta[p]== sum(i in CR,k in K)d[i]*r_k_ip[k][i][p];
  cons11:forall(p in T) Z[p] >= delta[p]/sum(i in CR)d[i];
  cons12:forall(p in T) delta[p] <= QTp;
  cons13:forall(i in C) Z[i]+ sum(p in Ts,k in K)r_k_ip[k][i][p] == 1;
  cons14:sum(p in T) delta[p] <= P*Q;
  cons15:forall(p in T) delta[p] <= Q;
  }