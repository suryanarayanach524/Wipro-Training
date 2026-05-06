let empName = prompt("Enter Employee Name:");
let basicSalary = Number(prompt("Enter Basic Monthly Salary:"));
let workingDays = Number(prompt("Enter Working Days:"));
let bonus = Number(prompt("Enter Bonus:"));

let totalDays = 30;
let perDaySalary = basicSalary / totalDays;
let earnedSalary = perDaySalary * workingDays;
let grossSalary = earnedSalary + bonus;

let tax;
if (grossSalary <= 25000) {
    tax = grossSalary * 0.05;
} else {
    tax = grossSalary * 0.10;
}

let netSalary = grossSalary - tax;

document.getElementById("empName").innerText = empName;
document.getElementById("gross").innerText = "₹" + grossSalary;
document.getElementById("tax").innerText = "₹" + tax;
document.getElementById("net").innerText = "₹" + netSalary;