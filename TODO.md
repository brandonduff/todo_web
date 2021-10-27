Todo File
---

- [ ] Multi tenancy
    - [ ] Associate notes with session state
    - [ ] Store notes associated with separate notepads for different users, based on session
    - [ ] Allow creation of users. Passwords w/ BCrypt could be fun to figure out (or just start with something insecure)
- [ ] Call/Response (editing todos)


test list
- see about replacing TestCanvas with an intermediate representation with an HtmlRenderer and TestRenderer (or TestDriver)
  - a potential path forward: make HTMLCanvas two-pass instead of single-pass. see if we can use the intermediate representation
    instead of subclass for TestCanvas
- Persist SessionStore instead of root component. Sessions will have components
  - This will mean any write saves all other sessions. But we can change this later since it's simpler for now
  - Need a refresh on server reload without this (Continuation Object-IDs will change)
  

