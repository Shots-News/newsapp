String appName = "Gaming News";

const String SUPABASE_APi =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyOTI4MDQ4NSwiZXhwIjoxOTQ0ODU2NDg1fQ.Sq2bQOzdf2udAUZ0pgmorK-w8U_KVjP5hs3lhrH75ss";

const String SUPABASE_URL = "https://kopvjzxvcbtytallprvw.supabase.co/rest/v1/";

/// [Table Names]
const String CATEGORIES_TABLE = 'caregories';
const String ARTICLES_TABLE = 'articles?draft=eq.false&select=*,caregories(*)';

/// [Base Image Path]
const String BASE_IMAGE_PATH = 'https://res.cloudinary.com/kevin420/image/upload/v1/';
