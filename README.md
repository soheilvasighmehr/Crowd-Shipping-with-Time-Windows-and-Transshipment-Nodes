# Crowd-Shipping with Time Windows and Transshipment Nodes
March 2024

## Summary
This project addresses the Collective Transportation Problem, focusing on optimizing delivery processes using a network with a central warehouse and multiple intermediate warehouses. The model integrates standard vehicle routing methods with the concept of crowd-sourced deliveries, where individuals deviate from their daily routes to deliver packages to others for a small payment. The objective is to minimize total costs, including conventional vehicle costs and driver incentives.

Key Features:
•	Central and Intermediate Warehouses: The system includes a central warehouse and several intermediate warehouses where drivers can pick up packages.
•	Crowd-Sourced Delivery: Drivers can choose to deliver packages from either the central warehouse or intermediate warehouses to customers, with the flexibility to serve multiple customers sequentially.
•	Time Windows: Strict delivery time windows are considered for all customers.
•	Vehicle and Driver Constraints: The model considers constraints such as vehicle capacities, driver availability, and storage capacities at intermediate warehouses.
•	Extension: The original model is extended to allow drivers to visit multiple customers sequentially, addressing potential sub-tour issues by incorporating new constraints.

## Implementation
The mathematical model is implemented and solved using OPL-CPLEX. The solution involves optimizing vehicle routes, determining package allocations, and scheduling deliveries. The results are demonstrated on a medium-sized network with a central warehouse, an intermediate warehouse, and multiple customers.

## Results
The extended model successfully incorporates the possibility of multiple customer visits for crowd-sourced drivers and continues to optimize conventional vehicle routes. The solution demonstrates the feasibility and effectiveness of integrating intermediate warehouses and crowd-sourced deliveries into transportation systems.
