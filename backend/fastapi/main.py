from fastapi import FastAPI, File, UploadFile
import numpy as np  # type: ignore
import cv2  # type: ignore
from core.yolo import detect_and_classify  # Import fungsi deteksi dan klasifikasi
from core.yolo import detect_and_classify_with_segmentation  # Import fungsi deteksi dengan segmentasi dan klasifikasi

app = FastAPI()

@app.get("/")
async def hello():
    """
    Endpoint untuk memeriksa apakah backend aktif.
    """
    return {"message": "Halo, ini backend FastAPI! Selamat datang di TomatIn."}

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
            return {"success": False, "error": "Format gambar tidak valid atau file rusak."}

        # Deteksi dan klasifikasi
        results = detect_and_classify(image)

        # Jika tidak ada deteksi
        if not results:
            return {"success": False, "message": "Tidak ada daun tomat yang terdeteksi.", "classifications": []}


        return {"success": True, "message": "Terdeteksi daun tomat", "classifications": results}

    except Exception as e:
        # Penanganan error jika terjadi kesalahan
        return {"success": False, "error": str(e)}
    
@app.post("/detect-segment/")
async def detect_object_with_segmentation(file: UploadFile = File(...)):
    """
    Endpoint untuk mendeteksi daun tomat menggunakan model segmentasi
    dan mengklasifikasikan penyakitnya jika terdeteksi sebagai daun tomat.
    """
    try:
        # Baca dan decode file gambar
        image_bytes = await file.read()
        image = np.frombuffer(image_bytes, dtype=np.uint8)
        image = cv2.imdecode(image, cv2.IMREAD_COLOR)

        if image is None:
            return {"success": False, "error": "Format gambar tidak valid atau file rusak."}

        # Deteksi dan klasifikasi menggunakan segmentasi
        results = detect_and_classify_with_segmentation(image)

        if not results:
            return {
                "success": True, 
                "message": "Tidak ada daun tomat yang terdeteksi.", 
                "is_tomato_leaf": False,
                "details": []
            }

        return {
            "success": True, 
            "message": "Deteksi berhasil. Daun tomat terdeteksi.", 
            "is_tomato_leaf": True,
            "details": results
        }

    except Exception as e:
        # Penanganan error jika terjadi kesalahan
        return {"success": False, "error": str(e)}
