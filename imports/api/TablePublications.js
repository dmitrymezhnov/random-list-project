import { Meteor } from 'meteor/meteor';
import { TableCollection } from '/imports/db/TableCollection';

Meteor.publish('table', function publishTable() {
  return TableCollection.find({ userId: this.userId });
});