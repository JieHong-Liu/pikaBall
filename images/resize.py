# -*- coding: utf-8 -*-

import cv2 as cv

image = cv.imread("picwish.png")
image = cv.resize(image, (200, 100), interpolation=cv.INTER_AREA)
cv.imwrite("cloud.png", image)
