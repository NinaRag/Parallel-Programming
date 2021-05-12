#include "stdio.h"                                                                                                                                                      
#include <cuda.h>                                                                                                                                                       
#define COLUMNS 2                                                                                                                                                       
#define ROWS 2                                                                                                                                                          
__global__ void add(int *a, int *b, int *c) {                                                                                                                           
        int x = blockIdx.x * blockDim.x + threadIdx.x;
        int y = blockIdx.y * blockDim.y + threadIdx.y;
                                                                                                                                                                        
        for( int k =0;k<COLUMNS;k++){                                                                                                                                   
                                                                                                                                                                        
        int i = (COLUMNS*y) + k;                                                                                                                                        
        int f = (COLUMNS*y) + x;                                                                                                                                        
        int j = (COLUMNS*k) + x;                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
        c[f] = c[f] + a[i]*b[j]; 
        }                                                                                                                                                               
}                                                                                                                                                                       
int main() {                                                                                                                                                            
        int a[ROWS][COLUMNS], b[ROWS][COLUMNS], c[ROWS][COLUMNS]; 
        int *dev_a, *dev_b, *dev_c; 
        cudaMalloc((void **) &dev_a, ROWS*COLUMNS*sizeof(int));  
        cudaMalloc((void **) &dev_b, ROWS*COLUMNS*sizeof(int));                                                                                                         
        cudaMalloc((void **) &dev_c, ROWS*COLUMNS*sizeof(int));                                                                                                         
        for (int y = 0; y < ROWS; y++)                                                                                                                                  
                for (int x = 0; x < COLUMNS; x++)  {  
                        scanf("%d",&a[y][x]);                                                                                                                           
                }                                                                                                                                                       
        for (int y = 0; y < ROWS; y++)                                                                                                                                  
                for (int x = 0; x < COLUMNS; x++)  {   
                        scanf("%d",&b[y][x]);                 
        }                                                                                                                                                               
        cudaMemcpy(dev_a, a, ROWS*COLUMNS*sizeof(int), cudaMemcpyHostToDevice);  
        cudaMemcpy(dev_b, b, ROWS*COLUMNS*sizeof(int), cudaMemcpyHostToDevice);                                                                                         
        dim3 grid(COLUMNS,ROWS);
        add<<<grid,1>>>(dev_a, dev_b, dev_c);  
        cudaMemcpy(c, dev_c, ROWS*COLUMNS*sizeof(int), cudaMemcpyDeviceToHost);                                                                                         
        for (int y = 0; y < ROWS; y++) {
                for (int x = 0; x < COLUMNS; x++)  {  
                        printf("[%d][%d]=%d ",y,x,c[y][x]);                                                                                                             
                }
                printf("\n"); 
        }
        return 0; 
}