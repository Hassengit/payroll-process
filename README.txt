To run this munit use the env= dev and the normal secure.config.key for workday that is used in the dev environment.

This app can be very hard to test because of the object store load, and the time that it takes, and the amount of data that 
is stored. For future updates, recommendation is to mock and use munit for all local testing.    