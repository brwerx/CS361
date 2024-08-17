const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

const User = require('./models/users');
const Recipe = require('./models/recipe');

const app = express();
app.use(bodyParser.json());

const PORT = process.env.PORT || 19130;
const mongoURI = 'mongodb+srv://shelbymi:Easy13@cluster1.dieb8.mongodb.net/?retryWrites=true&w=majority&appName=Cluster1';

mongoose.connect(mongoURI, {
    useNewUrlParser: true,
    useUnifiedTopology: true
}).then(() => console.log('MongoDB connected'))
  .catch(err => console.log(err));

// Register Account (Microservice B)
app.post('/register', async (req, res) => {
    const { username, email, password } = req.body;
    try {
        const user = new User({ username, email, password });
        await user.save();
        res.status(201).json({ message: 'User registered successfully' });
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
});

// Save Favorite Recipe (Microservice C)
app.post('/favorites', async (req, res) => {
    const { userId, label, image, source, url, ingredients, calories } = req.body;
    try {
        const recipe = new Recipe({ userId, label, image, source, url, ingredients, calories });
        await recipe.save();
        res.status(201).json({ message: 'Recipe saved successfully' });
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
});

// View Favorite Recipes (Microservice D)
app.get('/favorites', async (req, res) => {
    const { userId } = req.query;
    try {
        const recipes = await Recipe.find({ userId });
        res.status(200).json(recipes);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
});

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));

