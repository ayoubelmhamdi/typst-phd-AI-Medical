// #import "../functions.typ": heading_center, images, italic
#let finchapiter = text(fill:rgb("#1E045B"),[■])
= ANNEXE 1.
#text(weight: "bold" ,size: 18pt ,"CODE EN LANGAGE C POUR CONVERTIR LES CELSIUS EN FAHRENHEIT")

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


= ANNEXE 2.
#text(weight: "bold" ,size: 18pt ,"TRPMLN IMPLANTATION")

```python
# This script generates the Dataset TRPMLN for lung nodules from LIDC-IDRI.

import os
import sys
import argparse


import gc # clean ram used by garbage collecrtore
import random

import cv2 # for normalise image and save in specific format
import pandas as pd # for save some information to scv
import pylidc as pl # we need pylidc to query lcidi-idri datasete
from tqdm.auto import tqdm # progress bar


class ScanData:
    def __init__(self, path=None):
        if path is None:
            raise KeyError("please provied path of LIDCI-IDRI")
        self.scans = self.create_pylidcrc(path)
        self.extract_data()

    def create_pylidcrc(self, path):
        config_file = "/root/.pylidcrc"
        config = f"[dicom]\npath={path}"    
        with open(config_file, "w") as f:
            f.write(config)
        # scans += pl.query(pl.Scan).all() # for query all slices
        return pl.query(pl.Scan).filter(pl.Scan.slice_thickness <= 3, pl.Scan.pixel_spacing <= 1)

    def extract_data(self):
        self.data = []
        total_scans = self.scans.count()
        for i, scan in tqdm(enumerate(self.scans), total=total_scans):
            # if i > 4: # deactivate the test for the 5 first items.
            #     break
            nodules = scan.cluster_annotations()
            # Note: for each scan.id we have many nodules, each nodules
            # has many anns from diffrent experts.
            for anns in nodules:
                malignancies = 0
                for ann in anns:
                    malignancies += ann.malignancy
                avg_malignancy = malignancies / len(anns)
                cancer = 1 if avg_malignancy >= 3 else 0
                cancer_name = "cancer" if cancer else "normal"

                #ann = random.choice(anns) # ROI extracting depend the ann celected.
                ann = anns[0]
                roi_name = f"{cancer_name}_{scan.patient_id}_{scan.id}_{ann.id}.tiff"

                row = {
                    "roi_name": roi_name,
                    "ann": ann,
                    # "scan_id": scan.id,
                    # "rand_nodule_id": ann.id,
                    "cancer": cancer,
                }
                self.data.append(row)

        return self

    def write_to_csv(self, filename):
        if filename is None or filename == "":
            raise KeyError("you miss name of csv file to store into data info")
        df = pd.DataFrame(self.data, columns=["roi_name", "cancer"])
        df.to_csv(filename, index=False)
        return self

    def save_roi_to_tiff(self, dir=None):
        if dir is None or dir == "":
            raise KeyError("you miss name of dir to store images")
        # padding = [(0, 0), (0, 0), (0, 0)] # for no padding
        padding = [(30, 10), (10, 25), (0, 0)]
        for i, row in tqdm(enumerate(self.data), total=len(self.data)):
            vol, roi, bbox, ann = None, None, None, None
            ann = row["ann"]
            bbox = ann.bbox(pad=padding)
            try:
                vol = ann.scan.to_volume()
            except Exception as e:
                print(f'Warning: {e}')
                continue

            for region in range(vol[bbox].shape[2]):
                roi = vol[bbox][:, :, region]
                # Rescale the ROI image to the range of 0 to 255 for 8-bit images
                roi = cv2.normalize(roi, None, 0, 255, cv2.NORM_MINMAX, dtype=cv2.CV_8U)

                # Save the image as a TIFF file in the patient directory
                filename = row["roi_name"]
                cv2.imwrite(f"{dir}/{filename}", roi)
            if i % 10: # clean some ram usage, use more cpu and time.
                gc.collect()
        return self

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="generate the Dataset TRPMLN for lung nodules from LIDC-IDRI.")
    parser.add_argument("-d", "--dataset", type=str, help="The path for Dataset LIDC-IDRI")
    parser.add_argument("-r", "--roi", type=str, help="The path for the ROI directory extracted.")
    parser.add_argument("-c", "--csv", type=str, help="The path for the csv file generated.")

    args = parser.parse_args(sys.argv[1:])


    if args.dataset is None:
        raise ValueError("Please provide the path for LIDC-IDRI Dataset.")

    if not os.path.exists(args.dataset):
        raise ValueError(f"Dir {args.dataset} does not exist.")

    if args.roi is None:
        raise ValueError("Please provide the path for ROI Directory output.")

    if not os.path.exists(args.roi):
        raise ValueError(f"Dir {args.roi} does not exist.")

    if args.csv is None:
        raise ValueError("Please provide the path to store the csv filename generated.")

    scan_data = ScanData(path=args.dataset)
    scan_data.write_to_csv(filename=args.csv)
    scan_data.save_roi_to_tiff(args.roi)
```
#finchapiter
