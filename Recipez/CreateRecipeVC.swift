//
//  CreateRecipeVC.swift
//  Recipez
//
//  Created by Grayson faircloth on 1/3/16.
//  Copyright © 2016 Grayson Faircloth. All rights reserved.
//

import UIKit
import CoreData

class CreateRecipeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var recipeIngredients: UITextField!
    @IBOutlet weak var recipeSteps: UITextField!
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var addRecipeBtn: UIButton!
    @IBOutlet var createRecipeBtn: UIButton!
    
    
    var imagePicker: UIImagePickerController!
    
    var recipeTitleUpdate: String = ""
    var recipeIngredientsUpdate: String = ""
    var recipeStepsUpdate: String = ""
    
    var existingItem: NSManagedObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        recipeImg.layer.cornerRadius = 4.0
        recipeImg.clipsToBounds = true
        
        
        if (existingItem != nil) {
           
            // This code transfers what was originally filled in the Title, Ingredients, and Steps text fields. This is used in combination with an if statement in the createRecipe func.
            
            recipeTitle.text = recipeTitleUpdate
            recipeIngredients.text = recipeIngredientsUpdate
            recipeSteps.text = recipeStepsUpdate

            // I did this as a fix if I can't figure out how to succesfully allow users to edit the fields. This would make the fields not able to be edited but still be viewed.
            
          
            recipeTitle.userInteractionEnabled = false
            recipeIngredients.userInteractionEnabled = false
            recipeSteps.userInteractionEnabled = false
            
            addRecipeBtn.hidden = true
            createRecipeBtn.hidden = true
           
            
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        recipeImg.image = image
        
    }

    @IBAction func addImage(sender: AnyObject) {
        
        presentViewController(imagePicker, animated: true, completion: nil)
      
    }
    
    @IBAction func createRecipe(sender: AnyObject!) {
        if let title = recipeTitle.text where title != "" {
            
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Recipe", inManagedObjectContext: context)!
           
            // This if statement should update the existing information and save it. I think I am missing something here because whenever I click the button after putting in new information the app crashes.
            
          /* if (existingItem != nil) {
                
            existingItem.setValue(recipeTitle.text as String?, forKey: "recipeTitleUpdate")
            existingItem.setValue(recipeIngredients.text as String?, forKey: "recipeIngredientsUpdate")
            existingItem.setValue(recipeSteps.text as String?, forKey: "recipeStepsUpdate")
                
                
                
                
           } else {

            
            */
                
                
                let recipe = Recipe(entity: entity, insertIntoManagedObjectContext: context)
                recipe.title = title
                recipe.ingredients = recipeIngredients.text
                recipe.steps = recipeSteps.text
                recipe.setRecipeImage(recipeImg.image!)
                
                context.insertObject(recipe)
            
              
          //  }
            
            do {
                try context.save()
            } catch {
                print("Could not save recipe")
            }
            
            self.navigationController?.popViewControllerAnimated(true)
            
        }
    }


}