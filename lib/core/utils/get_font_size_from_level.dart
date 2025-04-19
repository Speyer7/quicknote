double getFontSizeFromLevel(int level, String type) {
  switch (type) {
    case "normal":
      switch (level) {
        case 0:
          return 12.0;
        case 1:
          return 15.0;
        case 2:
          return 18.0;
        case 3:
          return 21.0;
        case 4:
          return 24.0;
      }
    case "big":
      switch (level) {
        case 0:
          return 18.0;
        case 1:
          return 21.0;
        case 2:
          return 24.0;
        case 3:
          return 27.0;
        case 4:
          return 30.0;
      }
    default:
      return 18.0;
  }
  return 18.0;
}
