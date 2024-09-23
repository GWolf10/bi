#!/usr/bin/env python3
# -*- coding: utf-8 -*-

""""
Contains all the functions which related to files
such as read write delete create



"""
import os
import shutil
import json


def deleteFolder(folderName):
    try:
        shutil.rmtree(folderName)
    except OSError:
        print("error deleteFolder")
        pass


def ensureDirectory(path):
    if not os.path.exists(path):
        os.makedirs(path)


def readJsonFile(fileName):
    try:
        with open(fileName, "rb") as file:
            return json.load(file)
    except IOError as err:
        if err.errno == 2:  # File didn't exist, no biggie
            return {}
        else:  # Something weird, just re-raise the error
            raise


def header(string):
    x = len(string)*"="
    print(f"{string}\n{x}\n")


def readFile(fileName):
    with open(fileName, "r") as file:
        data = file.read()
        file.close()
    return data


def writeFile(fileName, Data):
    with open(fileName, "w") as file:
        file.write(Data)
    file.close()


def writeJsonFile(fileName, state):
    # type: (object, object) -> object
    out = json.dumps(state, indent=4, sort_keys=False)
    jsonfile = open(fileName, 'w')
    jsonfile.write(out)
    jsonfile.close()