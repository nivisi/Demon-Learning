# simple_todo

A simple TODO app that stores the data in [Shared Preferences](https://pub.dev/packages/shared_preferences).

## Definition of done

- [ ] I can open the app and see the list of previously created todos. If the list is empty, I'll see the corresponding message;
- [ ] I can tap on the checkmark to complete/uncomplete a TODO record;
- [ ] I can tap on the record to view the details of a TODO record;
- [ ] I can add a todo;
- [ ] I can work with records: view their details, edit and remove them;
- [ ] When I edit a todo, the list on the main page is also updated;
- [ ] I cannot create a todo with an empty title, I also cannot edit a todo to have an empty title.

## Requirements

### Data

A todo item must contain:
- `title` — so a user can quickly understand what's this record about;
- `description` (optional) — if a todo needs some details;
- `completed` — whether a todo is completed or not;
- `createdAt` — a `DateTime` field to know when a todo item was created.

### Screens

#### List

When a user opens the app, the first thing they see is the todo list. If the list is empty, a string `No TODOs here yet!` and a button `Add your first TODO` is displayed.

The list contains all the todo items displayed as checkbox (checkmark + title).

Whenever the user taps on the checkmark, the item is counted as completed/uncompleted and is stored.

Completed items are displayed with a strikethrough style.

#### TODO details

If the user taps on the item, the TODO details screen must be opened. This screen renders the title and the description. Both are editable. The text field must contain the labels, e.g. `Title` and `Description` so the user understands what they are editing.

In the app bar we display `TODO details` and a button (three vertical dots) to open a menu with such options:

- `Complete` / `Uncomplete` depending on the `completed` status of a todo item;
- `Save` that saves the todo item and closes the screen;
- A separator
- `Delete` (with red color) to delete the existing record.

For now, if you close the screen w/o saving, let the data be lost. We will handle this later on. 

#### Adding a todo

A TODO can be added by tapping a `+` icon in the app bar on the list screen.

This screen looks almost the same as the todo details screen. Only one thing that is different is the menu. It has such options:
- `Save` — saves a new todo and closes the screen.

### Persistence

The data that the user inputs must be restored when a user reopens the app and must be saved whenever the `Save` button is pressed.

For now, use [Shared Preferences](https://pub.dev/packages/shared_preferences)
