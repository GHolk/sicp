
function fib(n) {
    // return iter(1,0,0,1, n)
    return whileLoop(n)

    function square(n) {
        return n*n
    }
    function isEven(n) {
        if (n%2 == 0) return true
        else return false
    }

    function whileLoop(n) {
        var a = 1
        var b = 0
        var p = 0
        var q = 1
        var count = n
        
        while (count != 0) {
            console.log(a,b,p,q, count) // 展示用
            if (isEven(count)) {
                var nextP = square(p) + square(q)
                var nextQ = 2*p*q + square(q)
                p = nextP
                q = nextQ
                count /= 2
            }
            else {
                var nextA = b*q + a*q + a*p
                var nextB = b*p + a*q
                a = nextA
                b = nextB
                count--
            }
        }
        return b
    }
    
    function iter(a, b, p, q, count) {
        console.log(a,b,p,q, count) // 展示用

        if (count == 0) return b
        else if (isEven(count)) {
            return iter(
                a,
                b,
                square(p) + square(q),
                2*p*q + square(q),
                count / 2
            )
        }
        else {
            return iter(
                b*q + a*q + a*p,
                b*p + a*q,
                p,
                q,
                count -1
            )
        }
    }
}

exports.fib = fib


new Promise(function () {
    
}).then(
    function onResolve(value) {
    },
    function onReject(error) {
    }
)
