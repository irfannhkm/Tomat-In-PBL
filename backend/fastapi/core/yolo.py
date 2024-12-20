from ultralytics import YOLO  # type: ignore
import os

# Load YOLO model for object detection
object_detection_model_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'model', 'tomato_leaf_detection.pt'))
if not os.path.exists(object_detection_model_path):
    raise FileNotFoundError(f"Object detection model not found at {object_detection_model_path}.")

object_detection_model = YOLO(object_detection_model_path)

# Load YOLO model for classification
classification_model_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'model', 'best.pt'))
if not os.path.exists(classification_model_path):
    raise FileNotFoundError(f"Classification model not found at {classification_model_path}.")

classification_model = YOLO(classification_model_path)

def detect_and_classify(image, confidence_threshold=0.75):
    """
    Perform object detection and classification.

    Args:
        image (numpy.ndarray): Image array in BGR format.
        confidence_threshold (float): Minimum confidence required to consider a detection valid.

    Returns:
        List of results with bounding boxes, detection confidence, and classification results.
    """
    # Object detection
    detection_results = object_detection_model.predict(image)
    detected_objects = detection_results[0].boxes  # Bounding boxes and scores

    results = []
    for box in detected_objects:
        confidence = box.conf[0].item()  # Detection confidence

        # Filter detections by confidence threshold
        if confidence < confidence_threshold:
            continue  # Skip low-confidence detections

        x1, y1, x2, y2 = map(int, box.xyxy[0])  # Bounding box coordinates
        class_id = int(box.cls[0].item())  # Detected class ID

        # Crop the detected region
        cropped_image = image[y1:y2, x1:x2]

        # Classification on the cropped image
        classification_results = classification_model.predict(cropped_image)
        top1 = classification_results[0].probs.top1  # Top-1 class
        top1_label = classification_results[0].names[top1]
        top1_confidence = classification_results[0].probs.top1conf.item() * 100

        results.append({
            "bounding box": [x1, y1, x2, y2],
            "detection_confidence": round(confidence * 100, 2),
            "class_id": class_id,
            "top1_label": top1_label,
            "top1_confidence": round(top1_confidence, 2)
        })

    return results
