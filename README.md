# DSCI_532_individual-assignment_naishu

DSCI 532 individual-assignment for Aishwarya Nadimpally (naishu)

## Motivation

Target audience: Aviation industry analysts, and service providers

The dashboard provides a simple yet powerful tool for anyone involved in the aviation industry worldwide.It's designed to help those who manage, analyze, or plan air transport services, including those overseeing heliports, small airfields, and large international airports. It aids decision-making in aviation, from route planning to infrastructure investment. Here’s how the dashboard serves its purpose:

- It shows how many heliport and airport facilities (large, small, medium) there are, where they're located globally, and breaks it down further within country and its provinces.
- The map makes it easy to see the spread of airports and heliports at a glance, which is super helpful for planning routes or expanding services.

For anyone who needs to keep an eye on where air transport facilities are and how they're spread out, this dashboard makes that job a lot easier. It helps in making smart decisions on how to grow, where to focus resources, and how to better serve passengers and businesses.

## App Description

The current iteration of Dashboard boasts:

- Interactive filters for types of aviation data analysis.
- Interactive maps which update as per the filters.
- Has dynamic information cards to display the information.

<img src="img/demo.mp4" width="1000"/>

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

    Create a Conda environment using the environment.yaml file. This file contains all necessary dependencies:

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
    Install maps package
    ```
    install.packages("maps", type = "binary")
    ```
6.  **Run the Dashboard Application**

    ``` bash
    shiny::runApp('src/app.R')
    ```

This will launch the application, typically at your local web browser.

## License
This project is licensed under the terms of the [MIT license](https://github.ubc.ca/MDS-2023-24/DSCI_532_individual-assignment_anubanga/blob/master/LICENSE.md).

## Contributors
Aishwarya Nadimpally
