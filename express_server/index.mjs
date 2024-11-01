import Express from "express";
import "dotenv/config";
import bodyParser from "body-parser";
import { dataModels } from "./models/dataModels.mjs";

const app = Express();

import { GoogleGenerativeAI } from "@google/generative-ai";
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

app.use(bodyParser.json());

const promptCache = {};

const prompt = "Use the following URL to generate a recipe using the given Data Models. Use decimal numbers instead of fractions for ingredient quantities if needed. Return the recipe as a pure JSON object."
app.get("/recipe", async (req, res) => {
  try {
    const recipeURL = req.body.recipeURL;
    if (promptCache[recipeURL]) {
      console.log('cached');
      res.send(JSON.parse(promptCache[recipeURL]));
    }
    else {
      console.log('not cached');
      const fullPrompt = `${prompt} URL:${recipeURL}\n\nData Models:\n${JSON.stringify(dataModels, null, 2)}`;
      const result = await model.generateContent([fullPrompt]);
      const cleanText = result.response.text().replace(/```json\n|\n```/g, '');
      promptCache[recipeURL] = cleanText.trim();
      res.send(JSON.parse(cleanText.trim()));
    }

  } catch (error) {
    console.log(error);
    res.status(400).send("Invalid URL");
  }
});


app.listen(3000, () => {
  console.log("Server is running on http://localhost:3000");
});


