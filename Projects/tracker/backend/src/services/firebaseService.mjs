import admin from 'firebase-admin';

const serviceAccount = await import('../../firebase_credential.json', { assert: { type: 'json' } });

const firebaseAdmin = () => {
    admin.initializeApp({
        credential: admin.credential.cert(serviceAccount['default']),
    });
}
firebaseAdmin();
const fb = admin.firestore();
const auth = admin.auth();
const storage = admin.storage();

console.log('🐦‍🔥 Firebase connected!');

export default { fb, auth, storage };
