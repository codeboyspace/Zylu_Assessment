const mongoose = require('mongoose');

const employeeSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, 'Employee name is required'],
    trim: true,
    minlength: [2, 'Name must be at least 2 characters long'],
    maxlength: [50, 'Name cannot exceed 50 characters']
  },
  role: {
    type: String,
    required: [true, 'Employee role is required'],
    enum: {
      values: ['Developer', 'Designer', 'Manager', 'Analyst', 'Intern'],
      message: 'Role must be one of: Developer, Designer, Manager, Analyst, Intern'
    },
    trim: true
  },
  years: {
    type: Number,
    required: [true, 'Years of experience is required'],
    min: [0, 'Years cannot be negative'],
    max: [50, 'Years cannot exceed 50']
  },
  isActive: {
    type: Boolean,
    default: true
  }
}, {
  timestamps: true
});

employeeSchema.index({ name: 1 });
employeeSchema.index({ role: 1 });

module.exports = mongoose.model('Employee', employeeSchema);
