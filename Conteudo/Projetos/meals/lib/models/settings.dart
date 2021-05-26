class Settings{
    bool isGlutenFree;
    bool isLactoseFree;
    bool isVegan;
    bool isVegetarian;
    bool useTopTab;

    Settings({
      this.isGlutenFree = false,
      this.isLactoseFree = false,
      this.isVegan = false,
      this.isVegetarian = false,
      this.useTopTab = false
    });
}