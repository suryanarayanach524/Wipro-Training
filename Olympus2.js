async function getUser() {
    const url = "https://randomuser.me/api/";

    try {
        const response = await fetch(url);
        const data = await response.json();

        const user = data.results[0];

        const name = user.name.first + " " + user.name.last;
        const email = user.email;
        const image = user.picture.large;

        document.getElementById("userData").innerHTML = `
            <h3>${name}</h3>
            <p>${email}</p>
            <img src="${image}" alt="User Image">
        `;

    } catch (error) {
        console.error("Error:", error);
    }
}