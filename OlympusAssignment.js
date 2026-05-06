const url = "https://dummy.restapiexample.com/api/v1/employees";

async function fetchEmployees() {
    try {
        const response = await fetch(url);

        if (!response.ok) {
            throw new Error("Failed to fetch data");
        }

        const data = await response.json();

        console.log("Full Response:", data);
        console.log("Employee List:", data.data);

    } catch (error) {
        console.error("Error:", error);
    }
}


fetchEmployees();