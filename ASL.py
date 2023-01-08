import numpy as np
import cv2
import os
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing import image
import tensorflow as tf
import time

# model = load_model("98,97 Sign Language ALS Classifier.h5")
# model = load_model("Sign Language ALS Classifier.h5")
model = load_model("C:/Users/pc/Desktop/Grad project/pyton/training/try cv2/best_hand_detection (18).h5") # best model
Video_path = "http://192.168.1.9:8080/video"
# labels = ['ain',
#  'al',
#  'aleff',
#  'bb',
#  'dal',
#  'dha',
#  'dhad',
#  'fa',
#  'gaaf',
#  'ghain',
#  'ha',
#  'haa',
#  'jeem',
#  'kaaf',
#  'khaa',
#  'la',
#  'laam',
#  'meem',
#  'nun',
#  'ra',
#  'saad',
#  'seen',
#  'sheen',
#  'ta',
#  'taa',
#  'thaa',
#  'thal',
#  'toot',
#  'waw',
#  'ya',
#  'yaa',
#  'zay']
# labels = [
#     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
# ]
labels = ['ا',
 'احبك',
 'انا',
 'انت',
 'اهلا',
 'ب',
 'ت',
 'توقف',
 'ث',
 'ج',
 'ح',
 'خ',
 'د',
 'ذ',
 'ر',
 'ز',
 'س',
 'ش',
 'ص',
 'ض',
 'ط',
 'ظ',
 'ع',
 'غ',
 'ف',
 'ق',
 'ك',
 'ل',
 'لست بخير',
 'م',
 'ن',
 'ه',
 'و',
 'ي']
labels = [
    'Alef',
    'Love You',
    "I'm",
    "You",
    "Hi",
    "Ba",
    "Ta",
    "Stop",
    "Thaa",
    "Jeem",
    "HHaa",
    "Khaa",
    "Dal",
    "Thal",
    "Ra",
    "Zai",
    "Seen",
    "Sheen",
    "Saad",
    "Daad",
    "TTa",
    "Zaa",
    "Ain",
    "Ghain",
    "Faa",
    "Qaf",
    "Kaf",
    "Lam",
    "Meem",
    "Noon",
    "Not Ok",
    "Ha",
    "Wow",
    "Yaa"
]
word = ""
predictions = np.array([])
cap = cv2.VideoCapture(1)

font                   = cv2.FONT_HERSHEY_SIMPLEX
bottomLeftCornerOfText = (100,300)
fontScale              = 2
fontColor              = (255,255,255)
lineType               = 2
i = 0
#Detection
while True:
    #Face Detection
    ret, frame = cap.read() #BGR
    original = frame.copy()#cv2.rectangle(frame,(0,0),(224,224),(0,255,0),2)
#     img = frame[0:224, 0:224]
#     frame = cv2.flip(frame, 1)
    img = cv2.resize(frame, (224, 224))
#     img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    img = img * (1.0 / 255.0)
    img = image.img_to_array(img)
#     img = tf.keras.applications.mobilenet_v2.preprocess_input(img)
#     cv2.imshow("dasd", img)
    
#     if cv2.waitKey(1) == ord('q'):
#         break
#     continue
#     img = img / 255.

#     img = tf.keras.applications.mobilenet_v2.preprocess_input(img)
    
    img = np.array([img])
    
    # Get probability of each letter
    result_probabilities = model.predict([img])
    # Select the highest probability index, since it's the answer (letter)
    letter_index = np.argmax(result_probabilities)
    
    letter = labels[letter_index]
#     predictions = np.append(predictions, letter)
#     if predictions.shape[0] > 30:
#         last_50_letters = predictions[30-i:i]
#         if np.unique(last_50_letters).shape[0] == 1:
#             new_word = np.unique(last_50_letters)[0]
#             print(new_word)
#             if new_word == '':
#                 pass
#             else:
#                 word += new_word
#                 predictions = np.array([])
#                 i = 0
    cv2.putText(original,letter, 
                            bottomLeftCornerOfText, 
                            None, 
                            fontScale,
                            fontColor,
                            lineType)
    print(letter, end="\r")
    cv2.imshow("", original)
    i += 1
    k = cv2.waitKey(1)
    if k == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()