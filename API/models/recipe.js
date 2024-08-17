const mongoose = require('mongoose');

const RecipeSchema = new mongoose.Schema({
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
    label: String,
    image: String,
    source: String,
    url: String,
    ingredients: [String],
    calories: Number
});

module.exports = mongoose.model('Recipe', RecipeSchema);
