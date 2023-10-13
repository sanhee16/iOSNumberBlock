import pandas as pd
import uuid

data = {"idx": [], "uuid": [], "title": [], "subTitle": []}
arr = []
titles = ["0단계", "1단계", "2단계", "3단계", "4단계", "5단계"]
subTitles = [
    "준비하기",
    "두 수의 합이 4이하",
    "5에 작은수 더하기",
    "5 만들기",
    "작은동수 더하기",
    "큰 동수 더하기",
]
for idx in range(len(titles)):
    arr.append(
        {
            "idx": idx,
            "uuid": uuid.uuid4(),
            "title": titles[idx],
            "subTitle": subTitles[idx],
        }
    )
print(arr)

for a in arr:
    data["idx"].append(a["idx"])
    data["uuid"].append(a["uuid"])
    data["title"].append(a["title"])
    data["subTitle"].append(subTitles[a["idx"]])

print(data)
df = pd.DataFrame(data)
df = pd.DataFrame(data)
df.set_index("idx", inplace=True)  # idx 열을 인덱스로 지정
print(df)

df.to_csv("./unit.csv")

"""
idx, uuid
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
