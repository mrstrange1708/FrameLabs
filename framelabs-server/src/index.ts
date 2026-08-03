import 'dotenv/config';
import express, { Request, Response } from 'express';
import cors from 'cors';

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

app.get('/api/health', (req: Request, res: Response) => {
  res.json({ status: 'ok', message: 'Server is running normally' });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
