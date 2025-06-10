// Function to load tasks from the backend
async function loadTasks() {
  try {
    const response = await fetch("/tasks");
    const tasks = await response.json();
    const taskList = document.getElementById("taskList");
    taskList.innerHTML = "";

    tasks.forEach((task) => {
      const li = document.createElement("li");
      li.dataset.id = task.id;

      const taskText = document.createElement("span");
      taskText.textContent = task.task;

      const deleteBtn = document.createElement("button");
      deleteBtn.textContent = "Delete";
      deleteBtn.className = "delete-btn";
      deleteBtn.addEventListener("click", () => deleteTask(task.id));

      li.appendChild(taskText);
      li.appendChild(deleteBtn);
      taskList.appendChild(li);
    });
  } catch (error) {
    console.error("Error loading tasks:", error);
  }
}

// Function to add a new task
async function addTask() {
  const taskInput = document.getElementById("taskInput");
  const task = taskInput.value.trim();

  if (task) {
    try {
      const response = await fetch("/tasks", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ task }),
      });

      if (response.ok) {
        taskInput.value = "";
        loadTasks();
      }
    } catch (error) {
      console.error("Error adding task:", error);
    }
  }
}

// Function to delete a task
async function deleteTask(id) {
  try {
    const response = await fetch(`/tasks/${id}`, {
      method: "DELETE",
    });

    if (response.ok) {
      loadTasks();
    }
  } catch (error) {
    console.error("Error deleting task:", error);
  }
}

// Event listeners
document.addEventListener("DOMContentLoaded", () => {
  loadTasks();
  document.getElementById("addBtn").addEventListener("click", addTask);
  document.getElementById("taskInput").addEventListener("keypress", (e) => {
    if (e.key === "Enter") addTask();
  });
});