var current_code = "######";
var current_index = 0;

function setCharAt(str, index, chr) {
  if (index > str.length - 1) return str;
  return str.substring(0, index) + chr + str.substring(index + 1);
}

function handleClick(value) {
  const display = document.getElementById("display");
  if (value === "⌫" && current_index > 0 && current_index < 6) {
    current_index--;
    current_code = setCharAt(current_code, current_index, "#");
  } else if (value == 1 && current_index < 6) {
    current_code = setCharAt(current_code, current_index, "1");
    current_index++;
  } else if (value == 2 && current_index < 6) {
    current_code = setCharAt(current_code, current_index, "2");
    current_index++;
  } else if (value == 3 && current_index < 6) {
    current_code = setCharAt(current_code, current_index, "3");
    current_index++;
  } else if (value == 4 && current_index < 6) {
    current_code = setCharAt(current_code, current_index, "4");
    current_index++;
  } else if (value == 5 && current_index < 6) {
    current_code = setCharAt(current_code, current_index, "5");
    current_index++;
  } else if (value == 6 && current_index < 6) {
    current_code = setCharAt(current_code, current_index, "6");
    current_index++;
  } else if (value == 7 && current_index < 6) {
    current_code = setCharAt(current_code, current_index, "7");
    current_index++;
  } else if (value == 8 && current_index < 6) {
    current_code = setCharAt(current_code, current_index, "8");
    current_index++;
  } else if (value == 9 && current_index < 6) {
    current_code = setCharAt(current_code, current_index, "9");
    current_index++;
  } else if (value == 0 && current_index < 6) {
    current_code = setCharAt(current_code, current_index, "0");
    current_index++;
  }
  updateDisplayedCode();

  if (current_index == 6) {
    document.getElementById("numericKeypad").style.visibility = "hidden";
    sendCode();
  }
}

function updateDisplayedCode() {
  const displayCode = document.getElementById("displayCode");
  displayCode.innerHTML = current_code;
}

async function sendCode() {
  await new Promise((r) => setTimeout(r, 200));

  flag_response = await fetch("/flag/" + current_code);

  if (!flag_response.ok) {
    throw new Error(`Response status: ${flag_response.status}`);
  }

  flag = await flag_response.text();

  document.getElementById("descriptionHeader").innerHTML = flag;

  await new Promise((r) => setTimeout(r, 8000));

  document.getElementById("descriptionHeader").innerHTML = "Please enter your code";
  document.getElementById("numericKeypad").style.visibility = "visible";

  current_code = "######";
  current_index = 0;
  updateDisplayedCode();
}
