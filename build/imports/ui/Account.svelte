<script>
    import { Meteor } from 'meteor/meteor';
    import { TableCollection } from '../db/TableCollection';

    let username = "";
    let password = "";
    let repeatPass = "";

    const logIn = (callback) =>{
        Meteor.loginWithPassword(username, password, callback);
    }
    const newUser = () =>
            Meteor.call('accounts.newUser', {username, password, repeatPass}, err => {
                if(err){
                    console.log(err);
                }else{
                    firstLogIn();
                }
            });

    const firstLogIn = () =>
        logIn(err=>{
            if(err){
                console.log(err);
            }else{
                const user = Meteor.user();
                const filter = { userId: user._id };

                if (TableCollection.find(filter).count() === 0) { //добавляем стандартные пункты
                    ['First', 'Second','Third']
                        .forEach(lineText => Meteor.call('table.insert', lineText));
                };
            }
        });

</script>

<h1>Log in:</h1>

<form class="login-form" on:submit|preventDefault={()=>logIn()}>
    <div>
        <label for="username">Username</label>
        <input
                type="text"
                placeholder="Username"
                name="username"
                required
                bind:value={username}
        />
    </div>
    <div>
        <label for="password">Password</label>
        <input
                type="password"
                placeholder="Password"
                name="password"
                required
                bind:value={password}
        />
    </div>
    <div>
        <button type="submit">Log In</button>
    </div>
</form>

<hr>

<h1>Registration:</h1>

<form class="registration-form" on:submit|preventDefault={newUser}>
    <div>
        <label for="username">Username</label>
        <input
                type="text"
                placeholder="Username"
                name="username"
                required
                bind:value={username}
        />
    </div>
    <div>
        <label for="password">Password</label>
        <input
                type="password"
                placeholder="Password"
                name="password"
                required
                bind:value={password}
        />
    </div>
    <div>
        <label for="password">Repeat password</label>
        <input
                type="password"
                placeholder="Password"
                name="repeatPas"
                required
                bind:value={repeatPass}
        />
    </div>
    <div>
        <button type="submit">Registration</button>
    </div>
</form>