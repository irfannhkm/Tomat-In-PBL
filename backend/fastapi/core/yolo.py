from ultralytics import YOLO
import os

# Load the YOLO model
model_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'model', 'best.pt'))
if not os.path.exists(model_path):
    raise FileNotFoundError(f"Model file not found at {model_path}. Please ensure 'best.pt' exists.")

model = YOLO(model_path)

def predicts(image):
    """
    Perform predictions using the YOLO model.

    Args:
        image (numpy.ndarray): Image array in BGR format.

    Returns:
        results: Predictions containing bounding boxes, labels, and confidence scores.
    """
    results = model.predict(image)
    return results
