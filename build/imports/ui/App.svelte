<script>
  import { TableCollection } from '../db/TableCollection';
  import { Meteor } from 'meteor/meteor';
  import Account from './Account.svelte';
  import Control from './Control.svelte';
  import Table from './Table.svelte';

  let table = [];
  let user = null;

  const sort = { createdAt: -1 };
  let isLoading = true;
  const handler = Meteor.subscribe('table');

  $m: {
    user = Meteor.user(); //получить данные пользователя

    if(user){
      isLoading = !handler.ready();

      const filter = { userId: user._id };
      table = TableCollection.find(filter, {sort}).fetch();
    }

  }

</script>

<div class="container">
  {#if user}
    <div class="user" on:click={()=>{Meteor.logout()}}>
      {user.username} 🚪
    </div>

    <Control table={table}/>

    {#if isLoading}
      <div class="loading">loading...</div>
    {/if}

    <Table table={table}/>
  {:else}
    <Account/>
  {/if}
</div>