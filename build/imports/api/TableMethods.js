import { Meteor } from 'meteor/meteor';
import { check } from 'meteor/check';
import { TableCollection } from '../db/TableCollection';

Meteor.methods({
    'table.insert'(text) {
      check(text, String);
   
      if (!this.userId) {
        throw new Meteor.Error('Not authorized.');
      }
   
      TableCollection.insert({
        text,
        createdAt: new Date(),
        userId: this.userId,
      })
    },
   
    'table.remove'(lineId) {
      check(lineId, String);
   
      if (!this.userId) {
        throw new Meteor.Error('Not authorized.');
      }

      const line = TableCollection.findOne({ _id: lineId, userId: this.userId });

      if (!line) {
        throw new Meteor.Error('Access denied.');
      }
   
      TableCollection.remove(lineId);
    }

  });