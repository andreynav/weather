*** Settings ***
Resource        framework/import.resource
Resource        sample/resources/import.resource
Resource        weather/data/import.resource
Resource        weather/lib/import.resource
Resource        weather/resources/import.resource
Library         Collections
Library         JSONLibrary
Library         RequestsLibrary
Library         SeleniumLibrary
Library         String
