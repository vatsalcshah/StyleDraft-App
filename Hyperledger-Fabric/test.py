import requests
import json
import time
data = {"password":"DuBaraMatPuchna"}
a = json.loads(requests.post("http://localhost:3000/api/login",json=data).text)
print(a)
#data_n = {"ItemName":"item2","price":"300"}
#result = requests.post("http://localhost:3000/api/CreateAsset",headers={"Authorization":"Bearer "+a['token']},json=data_n)
#print(result.text)
data_n = {"ItemName":"item2","component_name":"com2","dict":{"location":"India","vendor":"NonameCompany"}}
result = requests.post("http://localhost:3000/api/AddComponentInfo",headers={"Authorization":"Bearer "+a['token']},json=data_n)
print(result.text)

