import pandas as pd
import uuid
import random

data = {
    "idx": [],
    "uuid": [],
    "levelIdx": [],
    "block1Num": [],
    "block2Num": [],
}
level0 = [
    (1,),
    (2,),
    (3,),
    (4,),
    (5,),
    (6,),
    (7,),
    (8,),
    (9,),
    (10,),
]  # 1,2,3,4,5,6,7,8,9,10

level1 = [
    (1, 1),
    (1, 2),
    (2, 2),
    (3, 1),
    (1, 3),
    (2, 1),
]  # 1+1, 1+2, 2+2, 3+1, 1+3, 2+1
level2 = [
    (5, 1),
    (5, 2),
    (5, 3),
    (5, 4),
    (5, 5),
]  # 5+1, 5+2, 5+3, 5+4, 5+5
level3 = [
    (1, 4),
    (2, 3),
    (3, 2),
    (4, 1),
]  # 1+4, 2+3, 3+2, 4+1
level4 = [
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
]  # 1+1, 2+2, 3+3, 4+4, 5+5
level5 = [
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10),
]  # 6+6, 7+7, 8+8, 9+9, 10+10

arr = []
quizIdx = 0
levelIdx = 0
levels = [level0, level1, level2, level3, level4, level5]

for order in range(len(levels)):
    level = levels[order]
    for i in range(10):
        for idx in range(len(level) + 3):
            block = level[idx % len(level)]
            if i > 0 or idx > len(level) - 1:
                block = level[random.randint(0, len(level) - 1)]

            arr.append(
                {
                    "idx": quizIdx,
                    "uuid": uuid.uuid4(),
                    "levelIdx": levelIdx,
                    "block1Num": block[0],
                    "block2Num": block[1] if len(block) > 1 else -1,
                }
            )
            quizIdx += 1

        levelIdx += 1
        if order == 0:
            break

print(arr)

for a in arr:
    data["idx"].append(a["idx"])
    data["uuid"].append(a["uuid"])
    data["levelIdx"].append(a["levelIdx"])
    data["block1Num"].append(a["block1Num"])
    data["block2Num"].append(a["block2Num"])

print(data)
df = pd.DataFrame(data)
df = pd.DataFrame(data)
df.set_index("idx", inplace=True)  # idx 열을 인덱스로 지정
print(df)

df.to_csv("./quiz.csv")
"""
idx, uuid, levelIdx, block1Num, block2Num

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
