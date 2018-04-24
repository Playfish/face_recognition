
#include <stdio.h>

main()
{

FILE  *f;
int m,i,j;
unsigned char *matrix_pgm,*m_p;
double *matrix;
matrix=(double*)malloc(sizeof(double)*10304);
matrix_pgm=(unsigned char*)malloc(sizeof(unsigned char)*10304);

memset(matrix_pgm,0,10304);

f=fopen("./a/1.pgm","r");
if(f==NULL)
{printf("open file failed \n");
return 0;}
//fseek(f,14,SEEK_SET);
m_p=matrix_pgm;
//fread(matrix_pgm,1,10304,f);
for(m=0;m<10;m++)
{
fseek(f,14+1024*m,SEEK_SET);

fread(m_p,1,1024,f);
m_p+=1024;

}


fseek(f,14+1024*m,SEEK_SET);
fread(m_p,1,1024,f);

fclose(f);



for(i=0;i<112;i++)
{
for(j=0;j<92;j++)
{
printf(" %d ",matrix_pgm[i*92+j]);
}
printf("\n");
}
printf("m=%d\n",m);
printf("matrix_pgm %d \n",matrix_pgm[10303]);

for(i=0;i<10304;i++)
{
	matrix[i]=(double)matrix_pgm[i];
	
}

for(i=0;i<112;i++)
for(j=0;j<92;j++)
{
printf(" %2.3f ",matrix[i*92+j]);
}
printf("\n");

}
