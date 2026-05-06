const url = "https://jsonplaceholder.typicode.com/users";

// for retrieving all the users in form of table
async function getUsers() {

  const res = await fetch(url);
  const users = await res.json();

  let output = "";

  users.map((u) => {
    output += `
      <tr>
        <td>${u.name}</td>
        <td>${u.email}</td>
        <td>${u.company.name}</td>
        <td>
          <button onclick="editUser(${u.id}, '${u.name}', '${u.email}')">Edit</button>
          <button onclick="deleteUser(${u.id})">Delete</button>
        </td>
      </tr>
    `;
  });

  document.getElementById("tableBody").innerHTML = output;
}
// for adding the user
async function addUser() {

  const name = document.getElementById("nameInput").value;
  const email = document.getElementById("emailInput").value;

  if (name === "" || email === "") {
    alert("Enter all details");
    return;
  }

  await fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ name, email }),
  });

  alert("User Added");
  clearForm();
  getUsers();
}

function editUser(id, name, email) {
  document.getElementById("id").value = id;
  document.getElementById("nameInput").value = name;
  document.getElementById("emailInput").value = email;
}

// updating the user
async function updateUser() {

  const id = document.getElementById("id").value;
  const name = document.getElementById("nameInput").value;
  const email = document.getElementById("emailInput").value;

  if (id === "") {
    alert("Select user to update");
    return;
  }

  await fetch(`${url}/${id}`, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ name, email }),
  });

  alert("User Updated");
  clearForm();
  getUsers();
}
// deleting the user
async function deleteUser(id) {

  const ok = confirm("Delete?");
  if (!ok) return;

  await fetch(`${url}/${id}`, {
    method: "DELETE",
  });

  alert("User Deleted");
  getUsers();
}

//clearing the input fields after every operation
function clearForm() {
  document.getElementById("id").value = "";
  document.getElementById("nameInput").value = "";
  document.getElementById("emailInput").value = "";
}

// for initial loading of the users
getUsers();