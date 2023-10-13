import pandas as pd
import uuid

data = {"idx": [], "uuid": [], "unitIdx": [], "title": []}
arr = []
idx = 0
for i in range(6):
    for j in range(10):
        arr.append(
            {
                "idx": idx,
                "uuid": uuid.uuid4(),
                "unitIdx": i,
                "title": "Lv." + str(j + 1),
            }
        )
        idx += 1


for a in arr:
    data["idx"].append(a["idx"])
    data["uuid"].append(a["uuid"])
    data["unitIdx"].append(a["unitIdx"])
    data["title"].append(a["title"])

print(data)
df = pd.DataFrame(data)
df = pd.DataFrame(data)
df.set_index("idx", inplace=True)  # idx 열을 인덱스로 지정
print(df)

df.to_csv("./level.csv")

"""
idx, uuid, unitIdx, title

 🔸️0단계 (준비하기)
 1,2,3,4,5,6,7,8,9,10

 🔸️1단계 (두 수의 합이 4이하)
 1+1, 1+2, 2+2, 3+1, 1+3, 2+1

 🔹️2단계(5에 +1, +2, +3, +4, +5)
 5+1, 5+2, 5+3, 5+4, 5+5
 
 🔸️3단계 (5만들기)
 1+4, 2+3, 3+2, 4+1

 🔹️4단계(작은동수 더하기)
 1+1, 2+2, 3+3, 4+4, 5+5

 🔸️5단계(큰 동수 더하기)
 6+6, 7+7, 8+8, 9+9, 10+10

"""
