<script>
    export let table;

    const dellLine = lineId => //удалить пункт
      Meteor.call('table.remove', lineId);
</script>

<div class="table">
    {#each table as line (line._id)}
      <p class="table__line">
        {line.text} 
        <button class="table__del-line" on:click={()=>{dellLine(line._id)}}>&times;</button>
      </p>
    {/each}
</div>