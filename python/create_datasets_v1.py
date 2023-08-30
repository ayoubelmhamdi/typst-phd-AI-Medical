# Import pylidc, os, cv2, and pandas
#!pip install -U pylidc -qq
import gc
import random

import cv2
import pandas as pd
import pylidc as pl
from tqdm.auto import tqdm

# import pydicom as dicom


class ScanData:
    def __init__(self, paths=None):
        if paths is None:
            raise KeyError("please provied paths list")
        self.scans = self.create_pylidcrc(paths)
        self.extract_data()

    def create_pylidcrc(self, paths):
        scans = []
        for path in tqdm(paths):
            config_file = "/root/.pylidcrc"
            f = open(config_file, "w")
            s = f"[dicom]\npath={path}"
            f.write(s)
            f.close()
            # scans += pl.query(pl.Scan).all()
            scans += pl.query(pl.Scan).filter(
                pl.Scan.slice_thickness <= 3, pl.Scan.pixel_spacing <= 1
            )
        return scans

    def extract_data(self):
        self.data = []
        total_scans = len(self.scans)
        for i, scan in tqdm(enumerate(self.scans), total=total_scans):
#             if i == 3:
#                 break
            nodules = scan.cluster_annotations()
            # for each scan.id we have many nodules, each nodules has many anns
            # we can use scan.visualize(annotation_groups=nodules)
            for anns in nodules:
                malignancies = 0
                for ann in anns:
                    malignancies += ann.malignancy
                avg_malignancy = malignancies / len(anns)
                cancer = 1 if avg_malignancy >= 3 else 0
                cancer_name = "cancer" if cancer else "normal"

                ann = random.choice(anns)
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
        # TODO check if dir available

        # padding = [(30, 10), (10, 25), (0, 0)]
        # padding = [(10,10,10)]
        padding = [(0, 0), (0, 0), (0, 0)]
        for i, row in tqdm(enumerate(self.data), total=len(self.data)):
            vol, roi, bbox, ann = None, None, None, None
#             if i == 4:
#                 break
            ann = row["ann"]
            bbox = ann.bbox(pad=padding)
            vol = ann.scan.to_volume()
            # print("vol.shape", vol.shape)
            # print("vol[bbox].shape", vol[bbox].shape)

            for region in range(vol[bbox].shape[2]):
                roi = vol[bbox][:, :, region]
                # Rescale the ROI image to the range of 0 to 255 for 8-bit images
                roi = cv2.normalize(roi, None, 0, 255, cv2.NORM_MINMAX, dtype=cv2.CV_8U)

                # Save the image as a PNG file in the patient directory
                filename = row["roi_name"]
                cv2.imwrite(f"{dir}/{filename}", roi)
            if i % 10:
                gc.collect()
        return self


# fin class
