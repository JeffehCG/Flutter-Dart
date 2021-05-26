// - List
// - Set
// - Map

main(List<String> args) {
    // List
    var aprovados = ['Ana', 'Carlos', 'Daniel', 'Rafael'];
    print(aprovados is List);
    print(aprovados);
    print(aprovados.elementAt(2));
    print(aprovados[0]);
    print(aprovados.length);

    //Map
    var telefone = {
      'João': '+55 (11) 98765-4321',
      'Maria': '+55 (11) 98765-4321',
      'Pedro': '+55 (11) 98765-4321',
    };

    print(telefone is Map);
    print(telefone);
    print(telefone["João"]);
    print(telefone.length);
    print(telefone.values);
    print(telefone.keys);
    print(telefone.entries);

    // Set - Diferente do List, o Set não aceita repetições e não tem indice
    var times = {'Vasco', 'Flamengo', 'Fortaleza', 'São Paulo'};
    print(times is Set);
    times.add("Palmeiras");
    print(times.length);
    print(times.contains('Vasco'));
    print(times.first);
    print(times.last);
}