import mongoose, { Schema, Document } from 'mongoose';

export interface IAppointmentPatientProfile {
    name: string;
    age: number;
    gender: 'male' | 'female' | 'other';
    relationship?: string;
}

export interface IAppointment extends Document {
    patientId: mongoose.Types.ObjectId;
    doctorId: mongoose.Types.ObjectId;
    date: Date;
    timeSlot: {
        start: string;
        end: string;
    };
    type: 'video' | 'clinic' | 'home';
    status: 'pending' | 'confirmed' | 'in-progress' | 'completed' | 'cancelled' | 'no-show';
    symptoms?: string;
    notes?: string;
    prescription?: string;
    amount: number;
    paymentStatus: 'pending' | 'paid' | 'refunded';
    meetingLink?: string;
    // Who the appointment is actually for — lets one patient account book for a family
    // member. Optional for backward compatibility with appointments created before this field
    // existed; falls back to the account holder when absent.
    patientProfile?: IAppointmentPatientProfile;
    createdAt: Date;
    updatedAt: Date;
}

const AppointmentSchema = new Schema<IAppointment>({
    patientId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    doctorId: { type: Schema.Types.ObjectId, ref: 'Doctor', required: true },
    date: { type: Date, required: true },
    timeSlot: {
        start: { type: String, required: true },
        end: { type: String, required: true },
    },
    type: { type: String, enum: ['video', 'clinic', 'home'], required: true },
    status: {
        type: String,
        enum: ['pending', 'confirmed', 'in-progress', 'completed', 'cancelled', 'no-show'],
        default: 'pending'
    },
    symptoms: { type: String },
    notes: { type: String },
    prescription: { type: String },
    amount: { type: Number, required: true },
    paymentStatus: {
        type: String,
        enum: ['pending', 'paid', 'refunded'],
        default: 'pending'
    },
    meetingLink: { type: String },
    patientProfile: {
        name: { type: String, trim: true },
        age: { type: Number, min: 0, max: 120 },
        gender: { type: String, enum: ['male', 'female', 'other'] },
        relationship: { type: String, trim: true },
    },
}, { timestamps: true });

// Indexes for query performance
AppointmentSchema.index({ patientId: 1, date: 1 });
AppointmentSchema.index({ doctorId: 1, date: 1 });
AppointmentSchema.index({ date: 1, status: 1 });
AppointmentSchema.index({ status: 1, createdAt: -1 }); // Admin panel: filter by status
AppointmentSchema.index({ type: 1, status: 1 }); // Admin panel: filter by type
AppointmentSchema.index({ paymentStatus: 1, createdAt: -1 }); // Revenue stats
AppointmentSchema.index({ createdAt: -1 }); // Dashboard recent appointments

// Prevent double-booking: unique compound index on doctor + date + slot start (excluding cancelled/no-show)
AppointmentSchema.index(
    { doctorId: 1, date: 1, 'timeSlot.start': 1 },
    {
        unique: true,
        partialFilterExpression: { status: { $nin: ['cancelled', 'no-show'] } }
    }
);

export const Appointment = mongoose.model<IAppointment>('Appointment', AppointmentSchema);
