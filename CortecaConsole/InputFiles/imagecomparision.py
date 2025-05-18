import numpy as np
from skimage import io
from skimage.color import rgb2gray
from skimage.metrics import structural_similarity as ssim
from skimage import transform

def calculate_image_similarity(image_path_1, image_path_2):
    image1 = io.imread(image_path_1)
    image2 = io.imread(image_path_2)

    if image2.shape[2] == 4:
        image2 = image2[:, :, :3]  # Remove the alpha channel

    if image1.ndim == 3:
        image1 = rgb2gray(image1)
    if image2.ndim == 3:
        image2 = rgb2gray(image2)

    image2_resized = transform.resize(image2, image1.shape, anti_aliasing=True)
    similarity_index, _ = ssim(image1, image2_resized, full=True, data_range=1.0)

    return similarity_index
