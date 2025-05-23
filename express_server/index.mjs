import Express from "express";
import helmet from "helmet";
import "dotenv/config";
import bodyParser from "body-parser";
import { dataModels } from "./models/dataModels.mjs";
import cors from "cors";
import { GoogleGenerativeAI } from "@google/generative-ai";
import { rateLimit } from 'express-rate-limit';
import axios from 'axios';
import { JSDOM } from 'jsdom';

const app = Express();

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
const model = genAI.getGenerativeModel({ model: "gemini-2.0-flash" });
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  limit: 40,
  standardHeaders: 'draft-7',
  legacyHeaders: false,
})

app.use(limiter)
app.use(helmet());
app.use(cors());
app.use(bodyParser.json());

const promptCache = {};

const prompt = "Parse the following webpage content to generate a recipe using the given Data Models. Use decimal numbers instead of fractions for ingredient quantities if needed. Limit the description of the Recipe to 150 characters. Only set the duration parameter (in minutes) of the CookingStep data model if a some duration is mentioned, else set the duration to 0. Only use ingredients mentioned in the article. Only set the units of an Ingredient using the given units; if an unspecified unit is mentioned, mention it in the name of the Ingredient instead. Return the recipe as a Recipe object as defined in the data models."

// Function to fetch webpage content and parse it
async function fetchWebpageContent(url) {
  try {
    const response = await axios.get(url);
    const dom = new JSDOM(response.data);
    const bodyContent = dom.window.document.body.textContent || '';
    // Clean up content and remove excess whitespace
    return bodyContent.replace(/\s+/g, ' ').trim();
  } catch (error) {
    console.error("Error fetching webpage content:", error.message);
    throw new Error("Failed to fetch webpage content");
  }
}

app.post("/recipe", async (req, res) => {
  try {
    const recipeURL = req.body.recipeURL;

    if (promptCache[recipeURL]) {
      res.status(200);
      res.send(JSON.parse(promptCache[recipeURL]));
    }
    else {
      // Fetch and parse the webpage content
      const webpageContent = await fetchWebpageContent(recipeURL);

      // Create prompt with actual webpage content instead of URL
      const fullPrompt = `${prompt}\n\nWebpage Content:\n${webpageContent}\n\nData Models:\n${JSON.stringify(dataModels, null, 2)}`;

      const result = await model.generateContent([fullPrompt]);
      const cleanText = result.response.text().replace(/```json\n|\n```/g, '');
      promptCache[recipeURL] = cleanText.trim();
      res.status(200);
      res.send(JSON.parse(cleanText.trim()));
    }
    console.log(promptCache[recipeURL]);
  } catch (error) {
    console.log(error);
    res.status(400).send("Invalid URL or failed to parse webpage");
  }
});


app.listen(3000, () => {
  console.log("Server is running on http://localhost:3000");
});


