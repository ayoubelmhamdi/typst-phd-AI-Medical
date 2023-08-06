// #import "../functions.typ": heading_center, images, italic
#let finchapiter = text(fill:rgb("#1E045B"),[■])
= ANNEXE.
#text(weight: "bold" ,size: 18pt ,"CODE SOURCE EN C")

```c
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
// Train Data
float td[][2] = {
    // C   F
    {-40, -40},
    {-20, -4 },
    {0,   32 },
    {20,  68 },
    {40,  104},
    {60,  140},
    {80,  176},
    {100, 212},
};
#define N 8 // Number of item in Train Data
#define ALPHA 0.00001 // Define the learning alpha
#define EPOCS 100 * 1000 // Define the number of iterations
```
// #pagebreak()
```c
// Define a function to compute the mean squared error
double cost(double w, double b) {
  double error = 0.0;
  for (int i = 0; i < N; ++i) {
    double x = td[i][0];
    double y = td[i][1];
    double d = y - (w * x + b);
    error += d * d;
  }
  return error / (int) N;
}

// Define a function to perform gradient descent
void gradient_descent(double *w, double *b) {
  // Derivative of cost function with respect to w or b
  double dw = 0.0;
  double db = 0.0;
  for (int i = 0; i < N; i++) {
    double x  = td[i][0];
    double y0 = td[i][1];
    double y  = *w * x + *b;
    dw += x * (y - y0);
    db += (y - y0);
  }
  // Update w and b using the learning rate and the derivatives
  *w = *w - ALPHA * dw;
  *b = *b - ALPHA * db;
}

// Define a function to train the neuron using gradient descent
void train(double *w, double *b) {
  for (int i = 0; i < EPOCS; i++) {
    gradient_descent(w, b);
    if (i % 101000 == 0)
      printf("Iteration: %d, Cost:%3.3f w=%.6lf b=%.6lf\n", i, cost(*w, *b), *w, *b);
  }
}

// Define a function to predict the output using the neuron
double predict(double x, double w, double b) {
  return w * x + b;
}
```
```c
int main() {
  // Initialize w and b randomly
  double w = (double) rand() / RAND_MAX;
  double b = (double) rand() / RAND_MAX;

  // Train the neuron using gradient descent
  train(&w, &b);

  // Print the final values of w and b
  printf("\nFinal values are: w = %.6f and b = %.6f\n\n", w, b);

  // Test the neuron with some new inputs
  double x_new = 50;                   // Celsius
  double y_new = predict(x_new, w, b); // Fahrenheit
  printf("Fahrenheit of 50C: 122F\n");
  printf("Prediction of 50C: %.6fF\n", y_new);

  return 0;
}
```

```log
Iteration:  10000, Cost:227.982250 w=1.980511 b=13.953147
Iteration:  20000, Cost: 74.392002 w=1.903113 b=21.691058
Iteration:  30000, Cost: 24.274565 w=1.858902 b=26.111201
Iteration:  40000, Cost:  7.920939 w=1.833647 b=28.636129
Iteration:  50000, Cost:  2.584651 w=1.819220 b=30.078449
Iteration:  60000, Cost:  0.843387 w=1.810979 b=30.902348
Iteration:  70000, Cost:  0.275202 w=1.806272 b=31.372986
Iteration:  80000, Cost:  0.089800 w=1.803583 b=31.641830
Iteration:  90000, Cost:  0.029302 w=1.802046 b=31.795402
Iteration: 100000, Cost:  0.009562 w=1.801169 b=31.883127

Final values are: w = 1.801169 and b = 31.883127

Fahrenheit of 50C: 122F
Prediction of 50C: 121.94F
```
#finchapiter
