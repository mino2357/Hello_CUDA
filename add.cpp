#include <iostream>
#include <cmath>
#include <algorithm>
#include <iomanip>

using Real = float;

template <typename T = float>
void add(int n, T* x, T* y){
	for(int i=0; i<n; ++i){
		y[i] = x[i] + y[i];
	}
}

int main(){
    std::cout << std::fixed << std::setprecision(20);
	
	int n = 1<<26;

	auto *x = new Real[n];
	auto *y = new Real[n];

	for(int i=0; i<n; i++){
		x[i] = static_cast<Real>(1);
		y[i] = static_cast<Real>(2);
	}

	add<Real>(n, x, y);

	Real maxError{};

	for(int i=0; i<n; ++i){
		maxError = std::max(maxError, std::fabs(y[i] - static_cast<Real>(3)));
	}

	std::cout << "Max Error: " << maxError << std::endl;

	delete [] x;
	delete [] y;

}
