//
// Created by Ebubekir Ogden on 3/15/2017.
// Copyright © 2017 Ebubekir. All rights reserved.

import {  errorConsole, responseWithStatusandMessage, statusEnum } from '../helpers'; // 3 Parameters -> Place, Id, Error

export function setHeader(req, res, next){
    res.setHeader('Charset', 'utf-8');
    res.setHeader('X-Powered-By', "Ebubekir Ogden");
    next();
};

export function bodyLengthCheck(req, res, next){
    const body = req.body;

    const bodyLength = Object.keys(body).length;

    if(bodyLength > 0){
        next();
    }
    else{
      errorConsole("Body Length", "No ID", "Body cannot Found");

      responseWithStatusandMessage(res, statusEnum.FAIL, "Body cannot Found.");
    }
}
