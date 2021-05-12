//#include "cuda_runtime.h"                                                                                                                                             
//#include "device_launch_parameters.h"                                                                                                                                 
#include <stdio.h>                                                                                                                                                      
#include<cuda.h>                                                                                                                                                        
#define n 10                                                                                                                                                            
__global__ void add(int *a, int *maxim) {                                                                                                                               
                                                                                                                                                                        
        int i = blockIdx.x;                                                                                                                                             
                if (i < n) {                                                                                                                                            
                for(i=0;i<n;i++){                                                                                                                                       
                if(a[i]>*maxim)                                                                                                                                         
         *maxim=a[i];                                                                                                                                                   
         }                                                                                                                                                              
         }                                                                                                                                                              
}                                                                                                                                                                       
int main(){                                                                                                                                                             
        int a[n];                                                                                                                                                       
        //      int b[n];                                                                                                                                               
        int i;                                                                                                                                                          
        int maxim;                                                                                                                                                      
                                                                                                                                                                        
        int* dev_a;                                                                                                                                                     
        //      int* dev_b;                                                                                                                                             
        int* dev_max;                                                                                                                                                   
        cudaMalloc((void**)&dev_max, sizeof(int));                                                                                                                      
        cudaMalloc((void**)&dev_a, n * sizeof(int));                                                                                                                    
                                                                                                                                                                        
        printf("\narray elements (1st):\n");                                                                                                                            
        for(i=0;i<n;i++){                                                                                                                                               
                scanf("%d",&a[i]);                                                                                                                                      
        }                                                                                                                                                               
        maxim = a[0];                                                                                                                                                   
                                                                                                                                                                        
        cudaMemcpy(dev_a, a, n * sizeof(int), cudaMemcpyHostToDevice);                                                                                                  
        cudaMemcpy(dev_max, &maxim, sizeof(int), cudaMemcpyHostToDevice);                                                                                               
        //      dim3 grid(n,1);                                                                                                                                         
        add<<<n,1>>>(dev_a,dev_max);                                                                                                                                    
        cudaMemcpy(&maxim, dev_max, sizeof(int), cudaMemcpyDeviceToHost);                                                                                               
                                                                                                                                                                        
        printf("\n Max is %d\n",maxim);                                                                                                                                 
        cudaFree(dev_max);                                                                                                                                              
        cudaFree(dev_a);                                                                                                                                                
                                                                                                                                                                        
                                                                                                                                                                        
        cudaDeviceReset();                                                                                                                                              
        return 0;                                                                                                                                                       
