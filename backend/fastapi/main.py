from fastapi import FastAPI, File, UploadFile
import shutil
import numpy as np
import cv2
from core.yolo import predicts
app = FastAPI()

@app.get("/")
async def hello():
    return {"message": "Hello, this is FastAPI backend!"}
@app.post("/detect/")
async def detect_objects(file: UploadFile = File(...)):
 # Process the uploaded image for object detection
 image_bytes = await file.read()
 image = np.frombuffer(image_bytes, dtype=np.uint8)
 image = cv2.imdecode(image, cv2.IMREAD_COLOR)
 
 # Perform object detection with YOLOv8
 detections = predicts(image)
 print(detections[0].probs())
#  return {"detections": detections[0]}
