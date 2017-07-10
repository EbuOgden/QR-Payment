//
// Created by Ebubekir Ogden on 3/12/2017.
// Copyright © 2017 Ebubekir. All rights reserved.

export const statusEnum = {
  FAIL : 0,
  SUCCESS : 1
}

export const errorConsole = function(place, id, error){
  console.log("Error Has Occured at " + place + ". " + id + ". " + error);
}

export const responseWithStatusandMessage = function(res, status, message){
    res.json({
      status : status,
      message : message
    })
}
