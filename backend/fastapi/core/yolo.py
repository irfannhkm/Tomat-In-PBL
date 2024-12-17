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

# Load YOLO model for segmentation
segmentation_model_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'model', 'segmentation_tomatoleaf.pt'))
if not os.path.exists(segmentation_model_path):
    raise FileNotFoundError(f"Segmentation model not found at {segmentation_model_path}.")

segmentation_model = YOLO(segmentation_model_path)

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

def detect_and_classify_with_segmentation(image, confidence_threshold=0.75):
    """
    Perform segmentation to detect tomato leaves and classify their diseases.

    Args:
        image (numpy.ndarray): Image array in BGR format.
        confidence_threshold (float): Minimum confidence required to consider a segmentation valid.

    Returns:
        A single result with the highest confidence segmentation and its classification result.
    """
    # Segmentasi untuk mendeteksi daun tomat
    segmentation_results = segmentation_model.predict(image)
    masks = segmentation_results[0].masks  # Dapatkan mask hasil segmentasi

    if masks is None or len(masks) == 0:
        return None  # Tidak ada daun yang terdeteksi

    # Pilih mask dengan confidence tertinggi
    highest_confidence = 0.0
    best_mask = None
    best_segments_x = None
    best_segments_y = None

    for i, conf in enumerate(segmentation_results[0].boxes.conf):
        conf = float(conf.item())  # Konversi Tensor ke float
        if conf > highest_confidence:
            highest_confidence = conf
            best_mask = masks.xy[i]  # Segmen terbaik
            best_segments_x = best_mask[:, 0].tolist()  # Koordinat X
            best_segments_y = best_mask[:, 1].tolist()  # Koordinat Y

    if best_mask is None or highest_confidence < confidence_threshold:
        return None  # Tidak ada mask yang memenuhi threshold

    # Hitung bounding box dari mask terbaik
    x_min, y_min = min(best_segments_x), min(best_segments_y)
    x_max, y_max = max(best_segments_x), max(best_segments_y)
    x1, y1, x2, y2 = map(int, [x_min, y_min, x_max, y_max])

    # Crop gambar berdasarkan bounding box
    cropped_image = image[y1:y2, x1:x2]

    # Klasifikasi penyakit daun tomat pada region yang di-crop
    classification_results = classification_model.predict(cropped_image)
    top1 = classification_results[0].probs.top1  # Top-1 class
    top1_label = classification_results[0].names[top1]
    top1_confidence = float(classification_results[0].probs.top1conf.item()) * 100

    return {
        "bounding_box": [x1, y1, x2, y2],
        "shape": [x2 - x1, y2 - y1],
        "classification": {
            "top1_label": top1_label,
            "top1_confidence": round(top1_confidence, 2)
        },
        "segmentation": {
            "confidence": round(highest_confidence * 100, 2),
            "segments_x": best_segments_x,
            "segments_y": best_segments_y
        }
    }
