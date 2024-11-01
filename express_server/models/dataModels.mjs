export const dataModels = {
    Recipe: {
      title: "string",
      description: "string",
      rating: "number",
      tags: "string[]",
      ingredients: "Ingredient[]",
      cookingSteps: "CookingStep[]"
    },
    Ingredient: {
      id: "number",
      name: "string", 
      quantity: "number",
      unit: "keyof {'', 'g', 'kg', 'ml', 'L', 'tsp', 'tbsp', 'cup', 'pt', 'qt', 'gal', 'oz', 'lb'}",
      isDone: "boolean"
    },
    CookingStep: {
      stepNumber: "number",
      description: "string",
      duration: "number"
    }
  };

  // class Recipe {
  //   constructor( title, description) {
  //     this.title = title;
  //     this.description = description;
  //     // this.imagePath = imagePath;
  //     this.rating = rating;
  //     this.tags = [];
  //     /** @type {Ingredient[]} */
  //     this.ingredients = [];
  //     /** @type {CookingStep[]} */
  //     this.cookingSteps = [];
  //   }
  // }
  
  
  
  // class CookingStep {
  //   constructor(stepNumber, description, duration) {
  //     this.stepNumber = stepNumber;
  //     this.description = description;
  //     this.duration = duration;
  //   }
  // }
  
  // class Ingredient {
  //   constructor(id, name, quantity, unit = null, isDone = false) {
  //     this.id = id;
  //     this.name = name;
  //     this.quantity = quantity;
  //     this.unit = unit;
  //     this.isDone = isDone;
  //   } 
  // }
  