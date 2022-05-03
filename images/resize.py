# -*- coding: utf-8 -*-

import cv2 as cv

image = cv.imread("entry_background.jpg")
image = cv.resize(image, (1800, 900), interpolation=cv.INTER_AREA)
cv.imwrite("ok_entry_background.jpg", image)
