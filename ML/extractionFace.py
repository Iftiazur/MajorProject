"""This program extracts the face from the dataset for model training"""


import os
import cv2

# Define a function to extract the face region from an image using Haar Cascade
def extract_face_haar(image_path, output_dir, face_cascade):
    image = cv2.imread(image_path)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Detect faces in the image
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))

    for (i, (x, y, w, h)) in enumerate(faces):
        face_region = gray[y:y+h, x:x+w]  # Convert the face region to grayscale

        # Extract the name of the person from the parent folder name
        person_name = os.path.basename(os.path.dirname(image_path))

        # Create a directory for the person if it doesn't exist
        person_dir = os.path.join(output_dir, person_name)
        os.makedirs(person_dir, exist_ok=True)

        # Save the extracted face to the person's directory in grayscale
        face_filename = os.path.splitext(os.path.basename(image_path))[0] + f"_face_{i}.jpg"
        face_path = os.path.join(person_dir, face_filename)
        cv2.imwrite(face_path, face_region)

# Specify the input folder containing the subfolders of people's images
input_dir = "Dataset/FaceData"

# Specify the output folder where extracted faces will be saved
output_dir = "ExtractedFace"

# Load the Haar Cascade classifier for face detection
face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')

# Loop through the subfolders and extract faces
for person_folder in os.listdir(input_dir):
    person_folder_path = os.path.join(input_dir, person_folder)
    if os.path.isdir(person_folder_path):
        for file in os.listdir(person_folder_path):
            image_path = os.path.join(person_folder_path, file)
            if file.lower().endswith((".jpg", ".jpeg", ".png")):
                extract_face_haar(image_path, output_dir, face_cascade)

print("Face extraction complete.")
