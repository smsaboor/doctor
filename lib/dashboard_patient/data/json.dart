var doctors = [
  {
    "image": "https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80", 
    "name": "Dr. Haylie Siphron", 
    "skill": "Dermatologists",
    "digree": "MBBS,MD",
    "review": 540,
    "hospital": "K.K Hospital",
    "fees":2000,
    "speak":"English, Hindi"
  },
  {
    "image": "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80", 
    "name": "Dr. Corey Aminoff", 
    "skill": "Neurologists",
    "digree": "MBBS,MD",
    "review": 310,
    "hospital": "K.G.M.U Hospital",
    "fees":2000,
    "speak":"English, Hindi"
  },
  {
    "image": "https://images.unsplash.com/photo-1625498542602-6bfb30f39b3f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80", 
    "name": "Dr. Terry Jew", 
    "skill": "Dentist",
    "digree": "MBBS,MD",
    "review": 310,
    "hospital": "Lucknow Hospital",
    "fees":2000,
    "speak":"English, Hindi"
  },
  {
    "image": "https://images.unsplash.com/photo-1618498082410-b4aa22193b38?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80", 
    "name": "Dr. Joseph Brew", 
    "skill": "Dentist",
    "digree": "MBBS,MD",
    "review": 310,
    "hospital": "Max Hospital",
    "fees":2000,
    "speak":"English, Hindi"
  },
  {
    "image": "https://images.unsplash.com/photo-1622253692010-333f2da6031d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80",  
    "name": "Dr. Corey Aminoff", 
    "skill": "Neurologists",
    "digree": "MBBS,MD",
    "review": 310,
    "hospital": "Sradhajan Hospital",
    "fees":2000,
    "speak":"English, Hindi"
  },
  {
    "image": "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80", 
    "name": "Dr. Conney Joe", 
    "skill": "Neurologists",
    "digree": "MBBS,MD",
    "review": 310,
    "hospital": "PGI Hospital",
    "fees":2000,
    "speak":"English, Hindi"
  },
  {
    "image": "https://images.unsplash.com/photo-1594824476967-48c8b964273f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80", 
    "name": "Dr. Ramirez Rain", 
    "skill": "Neurologists",
    "digree": "MBBS,MD",
    "review": 310,
    "hospital": "Apolo Hospital",
    "fees":2000,
    "speak":"English, Hindi"
  },
  {
    "image": "https://images.unsplash.com/photo-1591604021695-0c69b7c05981?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80", 
    "name": "Dr. Corey Aminoff", 
    "skill": "Neurologists",
    "digree": "MBBS,MD",
    "review": 310,
    "hospital": "Sahara Hospital",
    "fees":2000,
    "speak":"English, Hindi"
  },
  
];

var chatsData = [
    {
    "image": "https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80", 
    "name": "Dr. Haylie Siphron", 
    "skill": "Dermatologists", 
    "last_text": "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "date": "1 min ago",
  },
  {
    "image": "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80", 
    "name": "Dr. Corey Aminoff", 
    "skill": "Neurologists", 
    "last_text": "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "date": "1 min ago",
  },
  {
    "image": "https://images.unsplash.com/photo-1591604021695-0c69b7c05981?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80", 
    "name": "Dr. Corey Aminoff", 
    "skill": "Neurologists", 
    "last_text": "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "date": "1 min ago",
  },
  {
    "image": "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80", 
    "name": "Dr. Conney Joe", 
    "skill": "Neurologists", 
    "last_text": "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "date": "1 min ago",
  },
  {
    "image": "https://images.unsplash.com/photo-1625498542602-6bfb30f39b3f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80", 
    "name": "Dr. DentTerry Jew", 
    "skill": "Dentist", 
    "last_text": "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "date": "1 min ago",
  },
  {
    "image": "https://images.unsplash.com/photo-1622253692010-333f2da6031d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80", 
    "name": "Dr. Corey Aminoff", 
    "skill": "Neurologists", 
    "last_text": "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "date": "1 min ago",
  },
  
];