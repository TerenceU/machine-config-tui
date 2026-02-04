#!/bin/bash

# Script to notify pending todos from walker/elephant at login
# Uses swaync for notifications

TODO_FILE="$HOME/.cache/elephant/todo.csv"

# Wait a bit for the system to fully load
sleep 3

# Check if todo file exists
if [ ! -f "$TODO_FILE" ]; then
    notify-send -u low -a "Walker Todo" "📝 Todo List" "No todo file found"
    exit 0
fi

# Read pending todos (skip header line)
pending_todos=$(awk -F';' 'NR>1 && $3=="pending" {print "• " $2}' "$TODO_FILE")

# Count pending todos
todo_count=$(echo "$pending_todos" | grep -c "^•" 2>/dev/null)

if [ "$todo_count" -eq 0 ]; then
    notify-send -u low -a "Walker Todo" "✅ Todo List" "No pending todos! Great job! 🎉"
else
    # Build notification message
    if [ "$todo_count" -eq 1 ]; then
        title="📝 $todo_count Todo Pending"
    else
        title="📝 $todo_count Todos Pending"
    fi
    
    # Send notification with pending todos
    notify-send -u normal -a "Walker Todo" "$title" "$pending_todos"
fi
