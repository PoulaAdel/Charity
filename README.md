# Charity

    A Full Project that serves charity to manage it's activity. Flutter frontend and DjangoRESTFramework backend, the Project wrapped in a Docker to run as a Whole

## Data Entities

    User        # for user management
    Donor       # keeping Donors data
    Service     # services that the charity provides
    Donation    # follow up donations for statistics
    Family      # families served
    Member      # individuals in families
    Statement   # the main data about served to be handled
    Social      # social state of served attached to specific statement
    Spiritual   # spiritual state of served attached to specific statement
    Residential # residential state of served attached to specific statement
    Economical  # economical state of served attached to specific statement
    Opinion     # Stage 1 discussing need of served for statement
    Suggestion  # Stage 2 discussing need of served for statement
    Judgement   # Stage 3 discussing need of served for statement
    Supply      # the base which the supplies will be given for served
    Check       # checks for applying supplies for served

## App Features

    1- Cross plateform application (works for windows / linux / web /android)
    2- Server / Client concept which helps in data centralization
    3- Data secured through powerful authentication

## UI Features

    1- Modern and clear design
    2- Flixable screen size (works in mobile / tablet / desktop)
    3- Supports light and dark mode
    4- Easy navigation and instant search

## Core Features 

    * Authintecation: (login / register / change pass) pages
    * Dashboard: will give fast info for the user about current statistics
    * Account Management: 
        - Donors: CRUD operations + list + instant search for donors
        - Members: holds data about individual members in families being served
    * Orgnization Assets:
        - Donations:  CRUD operations + list + instant search for donations
        - Services:  CRUD operations + list + instant search for services
        - Served families:  CRUD operations + list + instant search for families
    * Statement management:
            Social in-field investigation about family that need service
        - Info gathering:  CRUD operations + list of 4 statement types (spiritual/economical/resedintial/social)
        - Info Processing:  CRUD operations + list for discussion of statment ( opinions/decision) 
        - Final Decision:CRUD operations + list for the final decision took upon info gathered and processed
    * Action Plan: 
        - Supplies: detailed description for the supplies will be given for family upon statement
        - Checks: every time the supplies given we check in here for statistics
    * Reports:
        - Weekly: weekly report
        - Monthly: monthly report