#include <iostream>
#include <cmath>
#include <algorithm>
#include <iomanip>

typedef double Real;

__global__
void add(int n, Real* x, Real* y){
	int index = blockIdx.x * blockDim.x + threadIdx.x;
	int stride = blockDim.x * gridDim.x;

	for(int i=index; i<n; i+=stride){
		y[i] = x[i] + y[i];
	}
}

int main(){
    std::cout << std::fixed << std::setprecision(20);

	int n = 1<<20;

	Real *x, *y;
	cudaMallocManaged(&x, n*sizeof(Real));
	cudaMallocManaged(&y, n*sizeof(Real));

	for(int i=0; i<n; i++){
		x[i] = static_cast<Real>(1);
		y[i] = static_cast<Real>(2);
	}

	int blocksize = 32*8;
	int numBlock = (n + blocksize - 1) / blocksize;
	
	add<<<numBlock, blocksize>>>(n, x, y);
	cudaDeviceSynchronize();

	Real maxError = static_cast<Real>(0);

	for(int i=0; i<n; ++i){
		maxError = std::max(maxError, std::fabs(y[i] - static_cast<Real>(3)));
	}

	std::cout << "Max Error: " << maxError << std::endl;

	cudaFree(x);
	cudaFree(y);
}
