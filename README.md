# General Notes
The current project is a test project executed due to the Robot Framework.

The project used the commonly used design patterns like Page object, Page element, Loadable component, Lib provider, Steps.



## Project structure

The project has multilayer structure: 
- `framework` - used to keep custom libraries that can be reused in any other projects
- `output` - used to keep test reports 
- `sample` - sample is project for illustrating how we can use more than one project in repo 
  - `resources` - used to keep keywords that can be used only in current projects
  - `tests` - contains tests 
- `weather` - main project
  - `data` - used to keep variables 
  - `lib` - used to keep specific libraries
  - `resources` - used to keep keywords that can be used only in current projects
    - `api` -  used to keep keywords for API calls
    - `pages` - used to keep keywords related to specific pages
    - `steps` - used to keep keywords related actions which used in tests
  - `tests` - contains tests
    - `API` - which runs via API
    - `E2E` - which runs via API and UI both
    - `UI` - which runs via UI

```
.
├── framework
├── output
├── sample
│   ├── resources
│   └── tests
└── weather
    ├── data
    ├── lib
    ├── resources
    │   ├── api
    │   │   ├── endpoints
    │   │   └── steps
    │   ├── pages
    │   └── steps
    └── tests
        ├── API
        ├── E2E
        ├── UI
```
## Scheme of project interactions

The project interactions between layers is displayed on the next scheme:

![scheme](scheme.png?raw=true)

The TESTS layer can interact with the DATA, PAGES (API), and STEPS layers. The gray arrow from STEPS to ROBOT LIBS means that the Log keyword of the robot framework can be used for logging. Any other direct interaction with ROBOT LIBS from STEPS is limited. 

The STEPS layer can interact with the PAGES (API) and ROBOT LIBS layers.

The PAGES layer includes sublayers PAGES (an entity of Page object pattern) and API sublayer. Can interact with FRAMEWORK, ROBOT LIBS, LIB, and DATA layers.
 
## Dependencies

The project has the next dependencies in the [requirements](requirements.txt) file

## Installation
  
1. Install browser driver
\
For this project, used only the *chromedriver*. 
Go to https://chromedriver.chromium.org/downloads and download the latest chromedriver. 
And also make sure that the Chrome version on your computer is updated to the latest version. 
Now place the driver file in a folder anywhere on your machine and add the path in the `.bash_profile` file or `.zshrc` file if you use it.
   
2. Clone project to your PC by the following command:
```bash
git clone https://github.com/andreynav/weather.git
```

3. Open the root of the project with the requirements file specified and run the following command:
```bash
pip install -r requirements.txt
```
## Running tests

To run tests, open the root of the project and run the following command:

```bash
  robot -d output -L TRACE tests/ 
```
flag `-d` points the output report directory 
\
flag `-L` points the output report level   

## License

The project is open source software provided under the [Apache License 2.0](LICENSE.md).