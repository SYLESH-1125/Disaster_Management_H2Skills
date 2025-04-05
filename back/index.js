const express = require("express");
const admin = require("firebase-admin");
const cors = require("cors");

const app = express();
app.use(express.json());
app.use(cors());

const serviceAccount = require("G:/back/serviceAccountKey.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();


app.post("/forum/posts", async (req, res) => {
  try {
    const { title, content, author } = req.body;
    
    if (!title || !content || !author) {
      return res.status(400).json({ error: "Missing fields" });
    }

    const newPost = {
      title,
      content,
      author,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    const docRef = await db.collection("forum_posts").add(newPost);
    res.status(201).json({ message: "Post added successfully!", id: docRef.id });

  } catch (error) {
    console.error("Error adding post:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});


const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
