
let display = document.getElementById('display');

document.querySelectorAll('button').forEach(button => {
    button.addEventListener('click', () => {
        let buttonText = button.innerText;

        if (buttonText === 'C') {
            display.innerText = '0';
        } else if (buttonText === '=') {
            try {
                display.innerText = eval(display.innerText);
            } catch {
                display.innerText = 'Error';
            }
        } else {
            if (display.innerText === '0') {
                display.innerText = buttonText;
            } else {
                display.innerText += buttonText;
            }
        }
    });
});
