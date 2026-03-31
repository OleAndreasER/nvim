//
// File for testing color scheme
//

interface Person {
	name: string;
	age: number;
	greet(): void;
}

interface Employee extends Person {
	employeeId: string;
	jobTitle: string;
	getDetails(): string;
}

class Developer implements Employee {
	constructor(
		public name: string,
		public age: number,
		public employeeId: string,
		public jobTitle: string
	) {}

	greet() {
		console.log(`Hello, my name is ${this.name} and I am a ${this.jobTitle}.`);
	}

	getDetails() {
		return `ID: ${this.employeeId}, Job Title: ${this.jobTitle}`;
	}
}

function createEmployee(name: string, age: number, employeeId: string, jobTitle: string): Employee {
	return new Developer(name, age, employeeId, jobTitle);
}

createEmploye('hey', 544, '1', 'Something')
createEmployee('hey', 544, '1', 'Something')

function createSomething(name: string, age: number, employeeId: string): {
	name: string;
	age: number;
	employeeId: string;
} {
	return { name, age, employeeId }
}

const employees: Employee[] = [
	createEmployee("Alice", 30, "E123", "Software Engineer"),
	createEmployee("Bob", 25, "E124", "Product Manager"),
	createEmployee("Charlie", 35, "E125", "UX Designer")
];

employees.forEach((employee) => {
	employee.greet();
	console.log(employee.getDetails());
});

function findEmployeeById(id: string): Employee | undefined {
	return employees.find(employee => employee.employeeId === id);
}

enum TaskStatus {
	Pending = "Pending",
	InProgress = "In Progress",
	Completed = "Completed"
}

interface Task2 {
	title: string;
	status: TaskStatus;
	assignTo(employee: Employee): void;
	completeTask(): void;
}

// TODO: make this good instead of bad.
class ProjectTask implements Task2 {
	status: TaskStatus = TaskStatus.Pending;

	constructor(public title: string, private assignedTo?: Employee) {}

	assignTo(employee: Employee) {
		this.assignedTo = employee;
		console.log(`Task ${this.title} assigned to ${employee.name}.`);
	}

	completeTask() {
		this.status = TaskStatus.Completed;
		console.log(`Task ${this.title} is completed.`);
	}
}

const task1 = new ProjectTask("Build New Feature");
const task2 = new ProjectTask("Fix Bugs");

task1.assignTo(employees[0]);
task2.assignTo(employees[1]);

task1.completeTask();
task2.completeTask();

async function fetchEmployeeData(id: string): Promise<Employee> {
	return new Promise((resolve, reject) => {
		setTimeout(() => {
			const employee = findEmployeeById(id);
			if (employee) {
				resolve(employee);
			} else {
				reject("Employee not found.");
			}
		}, 2000);
	});
}

fetchEmployeeData("E123")
.then((employee) => console.log(`Employee found: ${employee.name}`))
.catch((error) => console.error(error));

function getFirstItem<T>(arr: T[], secondArg: string,): T | undefined {
	console.log(secondArg)
	return arr.length > 0 ? arr[0] : undefined;
}

console.log(getFirstItem(employees, 'hey'));

type Product = {
	name: string;
	price: number;
	description: string;
};

const product: Product = {
	name: "Laptop",
	price: 1200,
	description: "A high-end gaming laptop"
};

const a = () => {
	console.log('hello')
}

const b = () => {
	a()
}

const c = () => {
	b()
}

const d = () => {
	a()
}

type Task = {
	id: number;
	payload: number[];
	priority: number;
};

type Result = {
	id: number;
	value: number;
	attempts: number;
	status: "ok" | "failed";
};

function sleep(ms: number): Promise<void> {
	return new Promise((resolve) => setTimeout(resolve, ms));
}

function randomInt(min: number, max: number): number {
	return Math.floor(Math.random() * (max - min + 1)) + min;
}

// hey

function computePayloadSum(payload: number[]): number {
	let sum = 0;
	for (let i = 0; i < payload.length; i++) {
		sum += payload[i];
	}
	return sum;
}

// What's up yo
async function fakeIOWork(task: Task, jitterMs: number): Promise<number> {
	await sleep(jitterMs);
	let acc = 0;
	for (let i = 0; i < task.payload.length; i++) {
		const v = task.payload[i];
		acc += v * (i + 1);
	}
	if (Math.random() < 0.15) {
		throw new Error("Transient IO error");
	}
	return acc + task.priority;
}

async function retryWithBackoff<T>(
	fn: () => Promise<T>,
	maxRetries: number,
	baseDelay: number
): Promise<{ value?: T; attempts: number; ok: boolean }> {
	let attempt = 0;
	let delay = baseDelay;
	while (attempt <= maxRetries) {
		try {
			const value = await fn();
			return { value, attempts: attempt + 1, ok: true };
		} catch (err) {
			attempt++;
			if (attempt > maxRetries) {
				break;
			}
			await sleep(delay);
			delay *= 2;
		}
	}
	return { attempts: attempt, ok: false };
}

export async function processTasksImperative(): Promise<{
	results: Result[];
	stats: { processed: number; failed: number; totalValue: number };
}> {
	const results: Result[] = [];
	let processed = 0;
	let failed = 0;
	let totalValue = 0;

	const tasks: Task[] = [];
	const taskCount = 120;

	for (let i = 0; i < taskCount; i++) {
		const payload: number[] = [];
		const payloadSize = randomInt(5, 20);
		for (let j = 0; j < payloadSize; j++) {
			payload.push(randomInt(1, 10));
		}
		tasks.push({
			id: i + 1,
			payload,
			priority: randomInt(1, 5),
		});
	}

	tasks.sort((a, b) => {
		if (a.priority === b.priority) return a.id - b.id;
		return b.priority - a.priority;
	});

	const batchSize = 10;
	let index = 0;

	while (index < tasks.length) {
		const batch: Task[] = [];
		for (let i = 0; i < batchSize && index < tasks.length; i++) {
			batch.push(tasks[index]);
			index++;
		}

		const promises: Promise<void>[] = [];

		for (let i = 0; i < batch.length; i++) {
			const task = batch[i];

			const p = (async () => {
				let localAttempts = 0;
				let localValue = 0;
				let ok = false;

				const payloadSum = computePayloadSum(task.payload);

				if (payloadSum % 2 === 0) {
					await sleep(5);
				} else {
					await sleep(2);
				}

				// hey 
				const retry = await retryWithBackoff<number>(
					async () => {
						const jitter = randomInt(5, 25);
						const val = await fakeIOWork(task, jitter);
						let adjusted = val;

						if (task.priority > 3) {
							adjusted += 10;
						} else if (task.priority === 3) {
							adjusted += 5;
						} else {
							adjusted += 1;
						}

						if (adjusted % 7 === 0) {
							adjusted -= 3;
						} else if (adjusted % 5 === 0) {
							adjusted += 2;
						}

						let checksum = 0;
						for (let k = 0; k < task.payload.length; k++) {
							checksum ^= task.payload[k] << (k % 4);
						}

						adjusted += checksum % 13;

						return adjusted;
					},
					3,
					10
				);

				localAttempts = retry.attempts;

				if (retry.ok && typeof retry.value === "number") {
					localValue = retry.value;
					ok = true;
				} else {
					ok = false;
				}

				if (ok) {
					results.push({
						id: task.id,
						value: localValue,
						attempts: localAttempts,
						status: "ok",
					});
				} 
				else {
					results.push({
						id: task.id,
						value: 0,
						attempts: localAttempts,
						status: "failed",
					});
				}
			})();

			promises.push(p);
		}

		for (let i = 0; i < promises.length; i++) {
			try {
				await promises[i];
			} catch (err) {
				// swallow to continue batch processing
			}
		}

		for ( let i = 0; i < batch.length; i++ ) {
			processed++;
		}
	}

	for (let i = 0; i < results.length; i++) {
		const r = results[i];
		if (r.status === "ok") {
			totalValue += r.value;
		} else {
			failed++;
		}
	}

	for (let i = 0; i < results.length; i++) {
		for (let j = i + 1; j < results.length; j++) {
			if (results[j].value > results[i].value) {
				const tmp = results[i];
				results[i] = results[j];
				results[j] = tmp;
			}
		}
	}

	const deduped: Result[] = [];
	const seen: Record<number, boolean> = {};

	for (let i = 0; i < results.length; i++) {
		const r = results[i];
		if (!seen[r.id]) {
			deduped.push(r);
			seen[r.id] = true;
		}
	}

	let sanityCheck = 0;
	for (let i = 0; i < deduped.length; i++) {
		const r = deduped[i];
		if (r.status === "ok") {
			sanityCheck += r.value % 10;
		} else {
			sanityCheck -= 1;
		}
	}

	if (sanityCheck < 0) {
		totalValue = Math.max(0, totalValue + sanityCheck);
	} else {
		totalValue += sanityCheck;
	}

	return {
		results: deduped,
		stats: {
			processed,
			failed,
			totalValue,
		},
	};
}
