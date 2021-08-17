//#include "cuda_runtime.h"                                                                                                                                             
//#include "device_launch_parameters.h"                                                                                                                                 
#include <stdio.h>                                                                                                                                                      
#include<cuda.h>                                                                                                                                                        
#define n 15                                                                                                                                                             
__global__ void sum_array(int *a, int *c) {                                                                                                                           

        int i = threadIdx.x;
        int j;
        for(j=blockDim.x>>1, j>0;j>>=1){
        _syncthreads();
        if (i < j) {
                c = a[i] + a[i+1];     
        }  
        }
}                                                                                                                                                                       
int main(){                                                                                                                                                             
        int a[n];                                                                                                                                                                                                                                                                                                              
        int i;                                                                                                                                                          
        int c;                                                                                                                                                  
                                                                                                                                                                        
        int* dev_a;                                                                                                                                                                                                                                                                                                      
        int* dev_c;                                                                                                                                                     
                                                                                                                            
        cudaMalloc((void**)&dev_a, n * sizeof(int));                                                                                                                    
        cudaMalloc((void**)&dev_c, sizeof(int));                                                                                                                    
        printf("\narray elements (1st):\n");                                                                                                                            
        for(i=0;i<n;i++){                                                                                                                                               
        scanf("%d",&a[i]);                                                                                                                                              
        }                                                                                                                                                                                                                                                                                                                            
        cudaMemcpy(dev_a, a, n * sizeof(int), cudaMemcpyHostToDevice);                                                                                                  
                                                                                                          
        sum_array<<<1,n/2>>>(dev_a, dev_c);                                                                                                                              
        cudaMemcpy(dev_b, b, n* sizeof(int), cudaMemcpyHostToDevice);                                                                                                    
        printf("\nsum is\n");                                                                                                         
        printf("%d\n",c);                                                                                                                                                                                                                                                                                                 
                                                                                                                                                                        
        cudaFree(dev_c);                                                                                                                                                
        cudaFree(dev_a);                                                                                                                                                
                                                                                                                                                      
                                                                                                                                                                        
        cudaDeviceReset();                                                                                                                                              
        return 0;                                                                                                                                                       
}               
