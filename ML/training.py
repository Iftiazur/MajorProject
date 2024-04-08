
'''Training the SVC Classifier '''

import face_recognition
from sklearn import svm
import os
import joblib

def train_face_recognizer(data_folder, model_filename):
    # Training the SVC classifier
    # The training data would be all the face encodings from all the known images and the labels are their names
    encodings = []
    names = []

    # Loop through each person in the training directory
    for person in os.listdir(data_folder):
        person_folder = os.path.join(data_folder, person)

        # Loop through each training image for the current person
        for person_img in os.listdir(person_folder):
            image_path = os.path.join(person_folder, person_img)

            # Get the face encodings for the face in each image file
            face = face_recognition.load_image_file(image_path)
            face_bounding_boxes = face_recognition.face_locations(face)

            # If the training image contains exactly one face
            if len(face_bounding_boxes) == 1:
                face_enc = face_recognition.face_encodings(face)[0]
                # Add face encoding for the current image with the corresponding label (name) to the training data
                encodings.append(face_enc)
                names.append(person)
            else:
                print(f"{person}/{person_img} is probably not a face")

    # Create and train the SVC classifier
    clf = svm.SVC(gamma='scale', verbose=True, max_iter=500)
    clf.fit(encodings, names)

    # Save the trained classifier to a file
    joblib.dump(clf, model_filename)

    print("Training completed and model saved to", model_filename)

def main():
    # Provide the path to the training data folder
    train_data_folder = "ExtractedFace"
    # Provide the filename for the trained model
    model_filename = "trial1.pkl"

    # Train the face recognizer
    train_face_recognizer(train_data_folder, model_filename)

if __name__ == "__main__":
    main()
