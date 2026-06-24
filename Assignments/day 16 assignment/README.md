# PySpark Employee Data Processing (RDD)

A small PySpark project that processes employee records using the RDD API and runs inside a Docker container.

The application reads employee data from a CSV file and performs the following operations:

* Sorts employees by salary in descending order
* Calculates total salary paid in each department
* Finds the top 3 highest-paid employees
* Exports the top 3 employees to a CSV file

## Project Structure

```text
.
├── Dockerfile
├── employees.csv
├── queries.py
├── requirements.txt
├── README.md
└── output/
    └── top3emp.csv
```

## Running with Docker

Build the image:

```bash
docker build -t employee-rdd-app .
```

Run the container:

```bash
docker run employee-rdd-app
```

The application starts automatically and prints the results to the console.

## Sample Output

```text
employees sorted by salary:

(4, 'Priya', 'Finance', 70000)
(3, 'Neha', 'IT', 65000)
(7, 'Rohit', 'Finance', 60000)

dept-wise salary

('IT', 170000)
('HR', 85000)
('Finance', 130000)
```

## Output File

The top 3 highest-paid employees are saved to:

```text
output/top3emp.csv
```

## Notes

This project was implemented using PySpark RDD transformations and actions instead of the DataFrame API, as required. The Docker container includes all dependencies required to run the application and executes the PySpark script automatically when started.
