const express = require('express');
const router = express.Router();
const Employee = require('../models/Employee');

// GET : All Employees :)
router.get('/', async (req, res) => {
  try {
    const employees = await Employee.find();
    res.status(200).json(employees);
  } catch (err) {
    console.error('Error fetching employees:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
});

// GET Employee by ID
router.get('/:id', async (req, res) => {
  try {
    const employee = await Employee.findById(req.params.id);
    if (!employee) {
      return res.status(404).json({ message: 'Employee not found' });
    }
    res.status(200).json(employee);
  } catch (err) {
    console.error('Error fetching employee:', err);
    if (err.name === 'CastError') {
      return res.status(400).json({ message: 'Invalid employee ID' });
    }
    res.status(500).json({ message: 'Internal server error' });
  }
});

// POST Create a slave(sorry) Employee
router.post('/', async (req, res) => {
  const employee = new Employee({
    name: req.body.name,
    role: req.body.role,
    years: req.body.years,
    isActive: req.body.isActive
  });

  try {
    const newEmployee = await employee.save();
    res.status(201).json(newEmployee);
  } catch (err) {
    console.error('Error creating employee:', err);
    if (err.name === 'ValidationError') {
      return res.status(400).json({ message: err.message });
    }
    res.status(500).json({ message: 'Internal server error' });
  }
});

// PUT : Software Update on Employee (Update Position)
router.put('/:id', async (req, res) => {
  try {
    const updatedEmployee = await Employee.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true, runValidators: true }
    );
    if (!updatedEmployee) {
      return res.status(404).json({ message: 'Employee not found' });
    }
    res.status(200).json(updatedEmployee);
  } catch (err) {
    console.error('Error updating employee:', err);
    if (err.name === 'ValidationError') {
      return res.status(400).json({ message: err.message });
    }
    if (err.name === 'CastError') {
      return res.status(400).json({ message: 'Invalid employee ID' });
    }
    res.status(500).json({ message: 'Internal server error' });
  }
});

// DELETE : Throw employee into Trash.
router.delete('/:id', async (req, res) => {
  try {
    const deletedEmployee = await Employee.findByIdAndDelete(req.params.id);
    if (!deletedEmployee) {
      return res.status(404).json({ message: 'Employee not found' });
    }
    res.status(200).json({ message: 'Employee deleted successfully' });
  } catch (err) {
    console.error('Error deleting employee:', err);
    if (err.name === 'CastError') {
      return res.status(400).json({ message: 'Invalid employee ID' });
    }
    res.status(500).json({ message: 'Internal server error' });
  }
});

module.exports = router;
