# 
# Library of middleware functions to DRY up common REST operations
# 

_ = require 'underscore'
ObjectID = require('mongodb').ObjectID
db = require "#{process.cwd()}/config/db"
validate = require './validate'

# Creates a document with `req.body`
# 
# @param {String} collection Name of mongo collection

@create = (collection) -> (req, res) ->
  data = validate[collection] req.body
  db.collection collection, (err, collection) ->
    collection.insert data, (err, docs) ->
      res.end JSON.stringify docs[0]

# Find all documents of a given collection
# 
# @param {String} collection Name of mongo collection

@all = (collection) -> (req, res) ->
  db.collection collection, (err, collection) ->
    collection.find().toArray (err, data) ->
      res.end JSON.stringify data
      
# Find a document by `req.params.id` of a given collection
# 
# @param {String} collection Name of mongo collection

@findById = (collection) -> (req, res) ->
  db.collection collection, (err, collection) ->
    collection.findOne { '_id': new ObjectID(req.params.id) }, (err, data) ->
      res.end JSON.stringify data

# Updates a document where _id = `req.params.id` with `req.body`
# 
# @param {String}

@updateById = (collection) -> (req, res) ->
  data = validate[collection] _.extend req.body, { id: req.params.id }
  db.collection collection, (err, collection) ->
    collection.findAndModify(
      { '_id': new ObjectID(req.params.id) }
      [['_id','asc']]
      { $set: data }
      { new: true }
      (err, data) ->
        res.end JSON.stringify data
    )

# Delete a document by `req.params.id` of a given collection
# 
# @param {String} collection Name of mongo collection

@delById = (collection) -> (req, res) ->
  db.collection collection, (err, collection) ->
    collection.remove { '_id': new ObjectID(req.params.id) }, (err, count) ->
      res.end JSON.stringify { success: err || true }