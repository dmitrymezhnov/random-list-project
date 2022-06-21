import { Meteor } from 'meteor/meteor';
import { check, Match } from 'meteor/check';
import { Accounts } from 'meteor/accounts-base';

Meteor.methods({
    'accounts.newUser'({username, password, repeatPass}) {

        const validStr = Match.Where(str => {
            check(str, String);
            return str.length >= 5;
        });
          
        check(username, validStr);

        check(password, validStr);

        check(repeatPass, Match.Where(str => 
            str === password
        ));

        Accounts.createUser({
            username,
            password
        });
    }

  });