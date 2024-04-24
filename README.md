# DSCI_532_naishu_individualassignment

## Motivation

The Aviation Atlas Dashboard is a user-friendly tool for exploring global airports. It aids decision-making in aviation, from route planning to infrastructure investment. It's easy to use and has all the info you need, making it great for everyone from industry experts to curious learners. Aviation professionals, researchers, and enthusiasts can use it to gain insights into airport distribution, types, and characteristics worldwide.

## App Description
## Installation Instructions
To run `Aviation Atlas Dashboard` locally:

1.  **Clone the Repository**

    Clone the repository using Git:

    ``` bash
    git clone https://github.ubc.ca/MDS-2023-24/DSCI_532_individual-assignment_naishu.git
    ```

2.  **Navigate to the Project Directory**

    Change into the project directory:

    ``` bash
    cd DSCI_532_individual-assignment_naishu

    ```
3.  **Create a Conda Environment**

    Create a Conda environment named 532_HomeScope using the environment.yaml file. This file contains all necessary dependencies:

    ``` bash
    conda env create -f environment.yaml
    ```

4.  **Activate the Conda Environment**

    Activate the newly created environment:

    ``` bash
    conda activate shiny_dashboard_environment
    ```

5.  **Activate R session in Bash**

    Launch the R session in the environment:

    ``` bash
    r
    ```

5.  **Activate R session in Bash**

    ``` bash
    shiny::runApp('src/app.R')
    ```

This will launch the application, typically at your local web browser.
