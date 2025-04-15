from flask import Flask, jsonify
import kagglehub
from kagglehub import KaggleDatasetAdapter

app = Flask(__name__)

# Trang chủ
@app.route('/')
def home():
    return "Welcome to the restaurant app!"

# Tải công thức nấu ăn từ Kaggle
@app.route('/load_recipes', methods=['GET'])
def load_recipes():
    try:
        # Tải dữ liệu từ Kaggle (Dataset về công thức nấu ăn)
        df = kagglehub.load_dataset(
            KaggleDatasetAdapter.PANDAS,
            "kaggle/recipe-ingredients-dataset",  # Dataset bạn muốn tải
            ""  # Đường dẫn tệp, nếu có
        )
        
        # Chuyển DataFrame thành dictionary và trả về dưới dạng JSON
        recipes = df.head().to_dict(orient="records")
        return jsonify(recipes)  # Trả về dữ liệu dưới dạng JSON
    except Exception as e:
        # Xử lý lỗi nếu có
        return jsonify({"error": str(e)})

if __name__ == '__main__':
    app.run(debug=True)
