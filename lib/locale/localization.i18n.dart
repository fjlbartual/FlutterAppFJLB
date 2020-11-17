import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en_us") +
      {
        "en_us": "Push the down button to take a photo, upload it and...",
        "es_es": "Pulsa el botón inferior para realizar una foto, subirla y...",
      } +
      {
        "en_us": "Freak out with the advanced facial recognition!",
        "es_es": "¡Flipar con el reconocimiento de cara avanzado!",
      } +
      {
        "en_us": "Url couldn't be opened: ",
        "es_es": "No se ha podido abrir la url: ",
      } +
      {
        "en_us": "I have read and accept the Privacy Policy",
        "es_es": "He leído y acepto la Política de Privacidad.",
      } +
      {
        "en_us": "Surprise me!",
        "es_es": "¡Sopréndeme!",
      } +
      {
        "en_us": "You must accept our Privacy Policy.",
        "es_es": "Debes aceptar nuestra Política de Privacidad.",
      } +
      {
        "en_us": "Camera permissions are needed.",
        "es_es": "Se necesitan permisos de cámara.",
      } +
      {
        "en_us": "You must be connected to Internet.",
        "es_es": "Se necesita conexión a Internet.",
      } +
      {
        "en_us": "OK",
        "es_es": "Vale",
      } +
      {
        "en_us": "Error",
        "es_es": "Error",
      } +
      {
        "en_us": "Take a photo with a face",
        "es_es": "Toma una foto con una cara",
      } +
      {
        "en_us": ": Result",
        "es_es": ": Resultado",
      } +
      {
        "en_us": ": Loading...",
        "es_es": ": Cargando...",
      } +
      {
        "en_us": "Creating the magic...",
        "es_es": "Creando la magia...",
      } +
      {
        "en_us": "Face Nº ",
        "es_es": "Cara Nº ",
      } +
      {
        "en_us": "Error uploading the image.",
        "es_es": "Error subiendo la imagen.",
      } +
      {
        "en_us": "There was an error processing the image.",
        "es_es": "Ha sucedido un error procesando la imagen..",
      } +
      {
        "en_us": "No face was found on the photo.",
        "es_es": "No se ha encontrado ninguna cara.",
      } +
      {
        "en_us": "Unknown.",
        "es_es": "Indeterminado.",
      } +
      {
        "en_us": "age",
        "es_es": "edad",
      } +
      {
        "en_us": "gender",
        "es_es": "género",
      } +
      {
        "en_us": "ethnicity",
        "es_es": "etnia",
      } +
      {
        "en_us": "female",
        "es_es": "femenino",
      } +
      {
        "en_us": "male",
        "es_es": "masculino",
      } +
      {
        "en_us": "kids",
        "es_es": "niño",
      } +
      {
        "en_us": "adults",
        "es_es": "adulto",
      } +
      {
        "en_us": "babies",
        "es_es": "bebe",
      } +
      {
        "en_us": "elderly",
        "es_es": "anciano",
      } +
      {
        "en_us": "latino",
        "es_es": "latino",
      } +
      {
        "en_us": "caucasian",
        "es_es": "caucásico",
      } +
      {
        "en_us": "east indian",
        "es_es": "hindú",
      } +
      {
        "en_us": "east asian",
        "es_es": "asia oriental",
      } +
      {
        "en_us": "afroamerican",
        "es_es": "afroamericano",
      };

  String get i18n => localize(this, _t);
}
