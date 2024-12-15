from fastapi import FastAPI, File, UploadFile
import numpy as np  # type: ignore
import cv2  # type: ignore

from core.yolo import detect_and_classify  # Import fungsi deteksi dan klasifikasi

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
    Endpoint untuk mendeteksi daun tomat dan mengklasifikasikan penyakitnya.
    """
    try:
        # Baca dan decode file gambar
        image_bytes = await file.read()
        image = np.frombuffer(image_bytes, dtype=np.uint8)
        image = cv2.imdecode(image, cv2.IMREAD_COLOR)

        if image is None:
            return {"success": False, "error": "Invalid image format or corrupt file."}

        # Deteksi dan klasifikasi
        results = detect_and_classify(image)

        # Jika tidak ada deteksi
        if not results:
            return {"success": True, "message": "No tomato leaves detected.", "classifications": []}


        return {"success": True, "classifications": results}

    except Exception as e:
        # Penanganan error jika terjadi kesalahan
        return {"success": False, "error": str(e)}

