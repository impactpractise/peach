class Challenge {
  final String id;
  final String name;
  final String location;
  final String difficulty;
  final String duration;
  final String description;
  final String image;

  const Challenge(
      {this.id,
      this.name,
      this.location,
      this.difficulty,
      this.duration,
      this.description,
      this.image});
}

List<Challenge> challenges = [
  const Challenge(
      id: '1',
      name: 'Safe 30% of your income',
      location: 'Online',
      difficulty: 'Medium',
      duration: '12 Weeks',
      description:
          'A challenge to save 30% of your income in the next 3 months',
      image:
          'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
  const Challenge(
      id: '2',
      name: 'Daily yoga session',
      location: 'Berlin',
      difficulty: 'Medium',
      description: 'Have a 20 minute yoga session every day',
      duration: '4 weeks',
      image:
          'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
];
