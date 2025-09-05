
## Key Concepts

### React Flow

[React Flow](https://reactflow.dev/) is a React library for building node-based graphs and flowcharts. It provides a set of components and hooks for creating interactive diagrams.

-   **Nodes:** Represent individual elements in the flowchart (e.g., states, actions).
-   **Edges:** Represent connections between nodes (e.g., transitions between states).
-   **Layout:** React Flow provides automatic layouting, but we use custom positioning for more control.
-   **Custom Nodes:**  The `SwitchNode` is a custom node type, demonstrating how to extend React Flow's basic functionality.

### Data Transformation

The `transformAstToFlow` function is a core part of the application. It transforms the structured data received from the backend (the AST) into the format required by React Flow. This involves:

-   Creating nodes and edges based on the AIVA script's structure.
-   Setting node positions and styles.
-   Adding labels and tooltips for better understanding.
-   Handling different types of actions and states.
-   Interpreting the data to meet specific graph layout requirements.

### API Communication

The application uses `axios` to communicate with the backend API. The `parseScript` function in `src/http/api.js` sends the AIVA script to the `/api/parse` endpoint and receives the structured data in response.

## Backend Integration

This frontend is designed to work with a Java Spring Boot backend that parses AIVA scripts.

-   **API Endpoint:** The frontend sends POST requests to the `/api/parse` endpoint with the script in the request body.
-   **CORS:** The backend must enable Cross-Origin Resource Sharing (CORS) to allow requests from `http://localhost:5173`.
-   **Data Format:** The backend should return a JSON array of `TrackNode` objects, representing the parsed AIVA script.

## Customization

-   **Node Styles:** Customize the appearance of nodes by modifying the `style` property in the `transformAstToFlow` function.
-   **Edge Styles:** Customize the appearance of edges by modifying the `style` property in the `transformAstToFlow` function.
-   **Layout:** Adjust the `position` property of nodes in the `transformAstToFlow` function to change the layout of the flowchart.
-   **Node Types:** Create custom node types to represent different elements in the AIVA script (see the `SwitchNode` example).

## Troubleshooting

-   **Graph Not Displaying:**
    -   Check if the backend server is running and accessible.
    -   Verify that the `/api/parse` endpoint is functioning correctly.
    -   Inspect the browser console for error messages.
-   **Incorrect Layout:**
    -   Review the `transformAstToFlow` function for issues in node positioning.
    -   Ensure that the backend is returning the correct data structure.
-   **CORS Errors:**
    -   Make sure the backend has CORS enabled for `http://localhost:3000`.

## Contributing

Contributions are welcome! To contribute to this project, please follow these steps:

1.  Fork the repository.
2.  Create a new branch for your feature or bug fix.
3.  Make your changes and commit them with descriptive messages.
4.  Push your changes to your forked repository.
5.  Submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
