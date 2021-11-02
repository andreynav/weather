# General Notes
The current project is a test project executed due to the Robot Framework.

The project used the commonly used design patterns like Page object, Page element, Loadable component, Lib provider, Steps.



## Project structure

The project has multilayer structure: 
- `env` - used to keep a virtual environment (can be kept in another place)
- `framework` - used to keep variables, specific keywords that can be used only in current projects
- `lib` - used to keep custom libraries that can be reused in any other projects
- `output` - used to keep test reports 
- `tests` - contains test

```
.
├── env
│   ├── bin
│   └── lib
│       └── python3.9
├── framework
│   ├── data
│   └── resources
│       ├── homework
│       └── weather
│           ├── api
│           ├── pages
│           └── steps
├── lib
├── output
└── tests
    ├── homework
    └── weather
```

  
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
git clone https://github.com/Andrei1982/wp1.git
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
