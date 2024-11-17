from ultralytics import YOLO
import os
model_path = os.path.join(__file__.replace('yolo.py',""),'..', "model", "best.pt")
model = YOLO(model_path)

def predicts(image_path):
    results = model.predict(image_path)
    return results