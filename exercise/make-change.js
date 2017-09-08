function change(amount) {
    var set = new Set()
    makeChange(amount, 5, [], set)
    return set
}

function makeChange(amount, coin, list, set) {
    switch (true) {
    case (amount == 0):
        set.add(list)
        break
    case (amount < 0):
    case (coin == 0):
        break
    case true:
        var newList = list.slice(0)
        newList.push(coin)
        makeChange(
            amount - valueOfCoin(coin),
            coin,
            newList,
            set
        )
        makeChange(
            amount,
            coin - 1,
            list.slice(0),
            set
        )
        break
    }
}
function valueOfCoin(coin) {
    switch (coin) {
    case 5: return 50
    case 4: return 25
    case 3: return 10
    case 2: return 5
    case 1: return 1
    }
}

exports.change = change
