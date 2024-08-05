# Camera Based Attendance App

## Overview:
This project focuses on the development of **Camera Based Attendance App for Multiple Faces** as my fullfillment of my *Major Project*.This innovative project aimed at transforming traditional attendance management systems by leveraging advanced facial recognition technology. The primary objective of this project is to develop an automated image-based attendance recording solution, that eliminates the need for manual attendance recording,reduces the potential for errors, and provides real-time data

## Approach

* Model creation and training
* Developing a Mobile App 
* Facilating Communication between the app and the model using an API

## File structure:

|   Name                        |   Type        |   Description                                         |
| -------------                 |:-------------:|:-------------:                                        |
|ML                             | Directory     |Codefiles for the face detection and recognition model |
|MobileApp                      | Directory     |Codefiles for development of the mobile app            |
|Flask                          | Directory     |Creation of API                                        |
|attendanceAppTrial.apk         | APK file      |The final apk file for installation on android         |

## Process:

- ###  Capturing images for the dataset:

1. Navigate to the ML folder 
2. - For using Haar-Cascade Classifier to extract faces for training:<br>
    >Run `Haar_dataset_capture.py` <br>
   - For using MTCNN to extract faces for training:
    >Run `mtcnn_capture.py` 
3. The UI opens for the capture of the image files. The user needs to enter the name and roll number and then the camera automaticallly starts capturing the images for the dataset for that particular user.
4. The extracted face are saved for the next step of model training<br>
*(**Note:** The facial data gets saved to `Haar_Face_Dataset` folder or `MTCNN_Face_Dataset` for Haar-Cascade or MTCNN respectively)*



- ###  Training the model using SVC

1. In the ML folder:
    >Run the `svm1.py` file 

    *Notes: <br>*
    *1. Both the training and testing code for the model is present in `svm1.py`.*

    *2. The default folder for training images is `Haar_Face_Dataset` but can be    changed in the `main()` method by changing the variable `train_data_folder`.*

    *3. The test image is given by the variable `test_image_path` in the `main()`   method.*

    

2. The model gets saved as a `.pkl` file.

    *Note: The default name for the `.pkl` file is `FaceRecognition.pkl` an can be changed     by changing the variable `model_filename` in the train_face_recognizer() method*


- ## Creating an API for the model
    The `Flask` directory contains the code for the creation of api for the model. This api shall help in the communication between the app and the model and thus as long as the api is running the app can provide results. This also makes changing or updating the model easier.

- ### Creating the mobile App.
    The mobile app is created using Flutter the code files of which are present in 
