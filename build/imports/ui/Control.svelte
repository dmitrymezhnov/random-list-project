<script>
    export let table;

    let control__mewLine = "" //имя нового пункта

    const addLine = () => { //добавить пункт
        if(control__mewLine){
            Meteor.call('table.insert', control__mewLine);

            control__mewLine = ""; //очистить поле ввода
        }
    }

    const showResult = () => { //показать случайный пункт
        lineIndex = randomInteger(0, table.length - 1)

        alert(table[lineIndex].text)
    }
    
    const randomInteger = (min, max) => { //случайное целое число в интервале [min; max]
        let rand = min - 0.5 + Math.random() * (max - min + 1);
        return Math.round(rand);
    }

</script>

<form class="control" on:submit|preventDefault={addLine}>
    <input class="control__mewLine" type="text" bind:value={control__mewLine} >
    <button class="control__add-line" type="submit">add line</button>
    <button class="control__show-result" on:click={showResult}>show result</button>
</form>