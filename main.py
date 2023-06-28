from PIL import Image
import numpy as np
import matplotlib.pyplot as plt
import os

annotation_path = "./annotation"


def find_file_txt(image_name):
    for f in os.listdir(annotation_path):
        with open(os.path.join(annotation_path, f), "r") as file:
            x = file.readline()[:-1]
        if x == (image_name.split("/")[1]).split(".")[0]:
            return f
    return None

def read_point(p):
    ps = p[:-1].split(" , ")
    return [float(i) for i in ps]

def read_founded_file(f):
    print(f)
    with open(os.path.join(annotation_path, f), "r") as file:
        points = file.readlines()[1:]
    points = [read_point(p) for p in points]
    return np.array(points)

def crop(image_name, save_path):
    f = find_file_txt(image_name)
    landmarks = read_founded_file(f)
    img = Image.open(image_name).convert("RGB")
    img = np.array(img)

    cy, cx = np.mean(landmarks, axis=0).astype(int)
    max_y, max_x = np.max(landmarks, axis=0).astype(int)
    w, h = max_x - cx, max_y - cy
    img = img.astype(np.uint8)
    img = img[cx - w:cx + w, cy - h:cy + h]
    img = Image.fromarray(img)
    img.save(f"{save_path}/cropped_{image_name}")

save_path = "cropped_train"
for j in range(1, 5):
    for f in os.listdir("train_{}"):
        image_name = f"train_{j}/{f}"
        crop(save_path, image_name)

save_path = "cropped_test"
for f in os.listdir("test"):
    image_name = f"test/{f}"
    crop(save_path, image_name)
