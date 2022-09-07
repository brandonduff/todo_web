Todo File
---

### Stories
- [ ] Multi tenancy
    - [ ] Associate notes with session state
    - [ ] Store notes associated with separate notepads for different users, based on session
    - [ ] Allow creation of users. Passwords w/ BCrypt could be fun to figure out (or just start with something insecure)
- [ ] Call/Response (editing todos)
- [-] persistence

### Programming Tasks
- Start with a manual save button
  - [x] Extract Agenda creation out of view initialization. Pass it into the Application
  - [ ] Write Agendas state to file instead of class ivar
  - [ ] Allow UI for saving (adding Agenda objects to Agendas)
  - [ ] Make sure we can handle updating Agenda objects
- Then we can see if we want automatic saving
- And then we can look at multi-tenancy
