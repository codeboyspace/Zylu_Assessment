# Zylu Backend API 🚀

Hey there! Welcome to the backend powerhouse of the Zylu Assessment project. This is a robust Node.js API built with Express and MongoDB, designed to handle employee management like a boss. Whether you're a dev looking to integrate or just curious about the tech stack, you've come to the right place. Im the RIGHT ONE for you guys. Go ahead!

The below is Technical Details about the Tech Stack of the Backend and the API Endpoint details based on Services and Models. >:

## Tech Stack 🛠️

- **Runtime**: Node.js (because JavaScript everywhere!)
- **Framework**: Express.js v5 (lightweight and powerful)
- **Database**: MongoDB Atlas (cloud-hosted for scalability)
- **ODM**: Mongoose (makes MongoDB feel like a relational database)
- **Middleware**: CORS, Body Parser, and custom error handling
- **Environment**: dotenv for config management

## API Endpoints 📡

All endpoints are prefixed with `/api/employees`. Here's the full CRUD breakdown:

### Get All Employees
```http
GET /api/employees
```
Returns a JSON array of all employees. Simple as that.

### Get Employee by ID
```http
GET /api/employees/:id
```
Fetch a specific employee. Pass the MongoDB ObjectId as the parameter.

### Create New Employee
```http
POST /api/employees
Content-Type: application/json

{
  "name": "Sunil Kumar",
  "role": "Developer",
  "years": 5,
  "isActive": true
}
```
Creates a new employee record. The API validates inputs, so make sure your data is clean!

### Update Employee
```http
PUT /api/employees/:id
Content-Type: application/json

{
  "name": "Preetika",
  "role": "Senior Developer",
  "years": 7
}
```
Update existing employee details. Only sends back what you change.

### Delete Employee
```http
DELETE /api/employees/:id
```
Removes an employee from the database. Careful with this one!

## Data Model 📊

Each employee has these fields:

- **name**: String (2-50 chars, required)
- **role**: String (must be one of: Developer, Designer, Manager, Analyst, Intern)
- **years**: Number (0-50, required)
- **isActive**: Boolean (defaults to true)
- **createdAt/updatedAt**: Timestamps (auto-generated)

Mongoose handles validation, so you'll get helpful error messages if something's off.
