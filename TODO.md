Todo File
---

- [ ] Multi tenancy
    - [ ] Associate notes with session state
    - [ ] Store notes associated with separate notepads for different users, based on session
    - [ ] Allow creation of users. Passwords w/ BCrypt could be fun to figure out (or just start with something insecure)
- [ ] Call/Response (editing todos)
- [ ] persistence
  - Ripped this out of the framework because it was buggy and maybe not even a concern for it.
  - Try to implement this outside the web framework as a first pass
    - Observe changes to the agenda's current day and task list
    - Write out task list for current day when the task list is modified
      - I suppose we'll also have to observe individual tasks since their done-ness can change
        without going through the list
    - Load the Agenda from disc instead of a new one each time
