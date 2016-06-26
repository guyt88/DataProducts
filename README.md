## R Datasets Explorer

The __R Datasets Explorer__ Shiny App: [http://guyt88.shinyapps.io/rdatasets/] (http://guyt88.shinyapps.io/rdatasets/)

__Purpose:__ This Shiny App loads a subset of the R datasets package and allows the user to preview, plot and then run a 
multivariable regression on variables in the chosen dataset.

__Documentation__ 
The application is fairly simple and self explanatory, but below are the steps to help you work through 
using the application.

__Step 1:__ Select a dataset from the dropdown list on the first tab. This will give you the title and description of 
        the dataset as well as a preview of the first 5 records.
        
__Step 2:__ Click on the second tab. There you will see a dropdown list with all of the variables in the dataset. You must
        select 2 variables from the list and you will be prevented from selecting more than two. The first variable 
        selected will be plotted on the x-axis and the second on the y-axis. Click the 'Plot' button to see the 
        scatter plot.
        
__Step 3:__ Click on the third tab. This tab will allow you to perform a multivariable regression. In the first dropdown, 
        select the _Outcome_ variable. In the next dropdown, select your _Predictor_ variables. You can choose as many 
        as you would like to include. Click on the 'Regression' button. The lm() function is used to create a
        regression model and the coefficient table is displayed.
        
You can then return to the first tab to select another dataset and work through the steps again.

A pitch for this application was created using RStudio Presenter.

The slides can be found here:[http://rpubs.com/guyt88/192012](http://rpubs.com/guyt88/192012)

The server.R and ui.R files used to create the R Datasets Explorer application can be found in this Github repo.




