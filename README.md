# Flutter Take-Home: Mini CourtBook
A small sports facility application.

## Clone and Run

1. Clone the repository:
    ```bash
   git clone https://github.com/sawssen-gharbi/mini_court_book.git
2. Get dependencies:
   ```bash
   flutter pub get
   
4. Run the app:
   ```bash
   flutter run
   
## Architecture Overview

I have used a layered architecture `Clean Architecture` because it separates concerns clearly and makes the codebase easier to maintain and test.

- **Presentation Layer**: Handles UI and state.

- **Domain Layer**: Entities and use cases encapsulate business logic (e.g., filtering facilities, creating bookings).

- **Data Layer**: Repositories and local data sources.

- **Dependency Injection**: Managed with `GetIt` for decoupling and easier testing.

- **Testing**: Unit tests cover key features such as booking overlap and time slot generation.



![Architecture Diagram](assets/clean_architecture.png)

## State management choice
I chose `BLoC` for state management because its event-driven approach fits well with the Clean Architecture I implemented.

BLoC provides a clear separation between the UI and business logic, making the app easier to maintain and test.

It also improves performance by reducing unnecessary widget rebuilds.

## Persistance Choice

I used `SharedPreferences` for simple key-value storage, enabling offline access to bookings and cached facility data.

## Booking Logic
At first, I implemented a simple approach that scanned all bookings for a court/day to check for overlaps `(O(n))`. Later, having more time and after doing some research, I decided to try using a `sorted list` with a `binary search`  `(O(log n))`.

## Time Spent & Compromises

**Time Spent:**
- Friday: Afternoon spent reviewing the assignment and planning.
- Saturday: 8:00 AM – 7:00 PM, 1h break → 10 hours
- Sunday: 8:00 AM – 7:00 PM, 1h break → 10 hours
- Monday: 2:00 PM – 7:00 PM → 5 hours
- Tuesday: Submitting & Improvements
  

**Compromises:**  
- Implementing `Clean Architecture` was a bit heavy for this small project.  
- Limited UI polish to focus on core features

  
## Testing:
- Added a court with `90-minute slotMinutes` to verify booking and time slot logic.

## Future Improvements:
- Prevent booking for past time slots on the current day.

## Demo:
[Video Link] (https://drive.google.com/file/d/1Q74wWdrcL3r_6D00JX5BCW5J0sbQXi7J/view?usp=sharing)
