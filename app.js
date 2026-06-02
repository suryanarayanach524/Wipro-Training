const { Formik } = formik;

const BookStore = {
  books: [],

  addBook(book) {
    this.books.push(book);
    renderApp();
  }
};

function App() {

  return (
    <div className="container">

      <h1>BookVerse</h1>

      <Formik
        initialValues={{
          title: "",
          author: "",
          price: ""
        }}

        validate={(values) => {

          let errors = {};

          if (!values.title) {
            errors.title = "Title is required";
          }

          if (!values.author) {
            errors.author = "Author is required";
          }

          if (!values.price) {
            errors.price = "Price is required";
          }

          return errors;
        }}

        onSubmit={(values, { resetForm }) => {

          BookStore.addBook(values);

          resetForm();
        }}
      >

        {
          ({ values, errors, handleChange, handleSubmit }) => (

            <form onSubmit={handleSubmit}>

              <input
                type="text"
                name="title"
                placeholder="Book Title"
                value={values.title}
                onChange={handleChange}
              />

              <div className="error">{errors.title}</div>

              <input
                type="text"
                name="author"
                placeholder="Author"
                value={values.author}
                onChange={handleChange}
              />

              <div className="error">{errors.author}</div>

              <input
                type="number"
                name="price"
                placeholder="Price"
                value={values.price}
                onChange={handleChange}
              />

              <div className="error">{errors.price}</div>

              <button type="submit">
                Add Book
              </button>

            </form>
          )
        }

      </Formik>

      <h2>Book List</h2>

      {
        BookStore.books.map((book, index) => (

          <div className="book" key={index}>

            <h3>{book.title}</h3>

            <p>Author: {book.author}</p>

            <p>Price: ₹{book.price}</p>

          </div>
        ))
      }

    </div>
  );
}

function renderApp() {
  ReactDOM.createRoot(document.getElementById("root")).render(<App />);
}

renderApp();