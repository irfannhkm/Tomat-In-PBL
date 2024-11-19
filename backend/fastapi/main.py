from fastapi import FastAPI, File, UploadFile
import numpy as np  # type: ignore
import cv2  # type: ignore
from core.yolo import predicts  # Pastikan modul ini tersedia dan benar

app = FastAPI()

@app.get("/")
async def hello():
    """
    Endpoint sederhana untuk memeriksa apakah backend aktif.
    """
    return {"message": "Hello, this is FastAPI backend!"}

@app.post("/detect/")
async def detect_objects(file: UploadFile = File(...)):
    """
    Endpoint untuk mendeteksi penyakit daun tomat melalui file gambar yang diunggah.
    """
    try:
        # Baca dan decode file gambar
        image_bytes = await file.read()
        image = np.frombuffer(image_bytes, dtype=np.uint8)
        image = cv2.imdecode(image, cv2.IMREAD_COLOR)

        if image is None:
            return {"success": False, "error": "Invalid image format or corrupt file."}

        # Prediksi menggunakan model
        detections = predicts(image)

        # Validasi hasil deteksi
        if len(detections) == 0 or not hasattr(detections[0], 'probs'):
            return {"success": True, "classifications": []}

        # Format hasil klasifikasi
        results = []
        for detection in detections:
            if hasattr(detection, 'probs') and detection.probs:
                # Ambil prediksi top-1
                top1 = detection.probs.top1  # Indeks kelas dengan probabilitas tertinggi
                top1_label = detection.names[top1]  # Nama kelas dari indeks top-1
                top1_confidence = detection.probs.top1conf.item()  # Skor kepercayaan top-1

                # Ambil prediksi top-5
                top5 = detection.probs.top5  # Indeks kelas dengan 5 probabilitas tertinggi
                top5_confidence = detection.probs.top5conf  # Skor kepercayaan top-5

                # Gabungkan hasil
                results.append({
                    "top1_label": top1_label,
                    "top1_confidence": round(top1_confidence, 2),
                    "top5": [
                        {
                            "label": detection.names[class_idx],
                            "confidence": round(conf.item(), 2),
                        }
                        for class_idx, conf in zip(top5, top5_confidence)
                    ],
                })

        # Return hasil klasifikasi
        return {"success": True, "classifications": results}

    except Exception as e:
        # Penanganan error jika terjadi kesalahan
        return {"success": False, "error": str(e)}
