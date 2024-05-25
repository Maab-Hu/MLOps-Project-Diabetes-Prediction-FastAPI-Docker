from fastapi import FastAPI
import pickle
from pydantic import BaseModel
import pandas as pd

with open('Models/model.pkl','rb') as f :
    model = pickle.load(f)

app = FastAPI()

class PredictionData(BaseModel):
    Glucose: int
    BMI: float
    Age: int
    Pregnancies: int
    DiabetesPedigreeFunction: float

@app.post('/')
async def predict(data: PredictionData):
    data_dict = data.model_dump()
    data_df = pd.DataFrame([data_dict.values()], columns=data_dict.keys())
    print(data_df)
    y_pred = model.predict(data_df)
    return {"prediction": int(y_pred)}