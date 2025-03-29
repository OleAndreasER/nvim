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
	return { name, age, employeeId}
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

interface Task {
    title: string;
    status: TaskStatus;
    assignTo(employee: Employee): void;
    completeTask(): void;
}

class ProjectTask implements Task {
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

