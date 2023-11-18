String getIcon(String icon) {
  switch (icon) {
    case '01d':
      return 'assets/weather/01d.png';

    case '01n':
      return 'assets/weather/01n.png';

    case '02d':
    case '03d':
    case '04d':
      return 'assets/weather/03d.png';

    case '02n':
    case '03n':
    case '04n':
      return 'assets/weather/03n.png';

    case '09d':
    case '10d':
      return 'assets/weather/09d.png';

    case '09n':
    case '10n':
      return 'assets/weather/09n.png';

    case '11d':
      return 'assets/weather/11d.png';

    case '11n':
      return 'assets/weather/11d.png';

    case '13d':
      return 'assets/weather/13d.png';

    case '13n':
      return 'assets/weather/13d.png';

    case '50d':
      return 'assets/weather/50d.png';

    case '50n':
      return 'assets/weather/50d.png';

    default:
      return 'assets/weather/01n.png';
  }
}
