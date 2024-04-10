import face_recognition
import cv2
import joblib

def test_face_recognizer(model_filename, test_image_path):
    # Load the trained classifier from the model file
    classifier = joblib.load(model_filename)

    # Load the test image with unknown faces into a numpy array
    test_image = face_recognition.load_image_file(test_image_path)

    # Find all the faces in the test image using the default HOG-based model
    face_locations = face_recognition.face_locations(test_image)

    if not face_locations:
        print("No faces found in the test image.")
        return

    no = len(face_locations)
    print("Number of faces detected: ", no)

    # Get face encodings for all faces in the test image
    face_encodings = face_recognition.face_encodings(test_image)

    # Predict all the faces in the test image using the trained classifier
    print("Found:")
    for i in range(no):
        if i < len(face_encodings):
            test_image_enc = face_encodings[i]
            name = classifier.predict([test_image_enc])
            print(*name)

            # Draw a rectangle around the face
            top, right, bottom, left = face_locations[i]
            cv2.rectangle(test_image, (left, top), (right, bottom), (0, 255, 0), 2)

            # Add label text at the bottom of the rectangle
            label_text = f"Label: {name[0]}"
            cv2.putText(test_image, label_text, (left, bottom + 20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 2)
    cv2.destroyAllWindows()

    # Resize the output image to 1920x1080
    resized_image = cv2.resize(test_image, (1920, 1080))

    # Display the resized test image with rectangles and labels
    cv2.imshow('Resized Test Image with Recognized Faces', resized_image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

def main():
    # Provide the filename for the trained model
    model_filename = "SVC_model.pkl"
    # Provide the path to the test image
    test_image_path = "test_image.jpg"

    # Test the face recognizer
    test_face_recognizer(model_filename, test_image_path)

if __name__ == "__main__":
    main()
