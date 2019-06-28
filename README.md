# Utilisation du site

## Structure du site

Le code sources du site est décomposé en plusieurs dossiers importants : 
   - `_includes` qui regroupe le début de page et fin de page de chaque page HTML.
   - `fr` qui regroupe les contenus des pages en français
   - `en` qui regroupe les contenus des pages en anglais
   - `_correctionsfr` qui regroupe les corrections des exercices en français
   - `_correctionsen` qui regroupe les corrections des exercices en anglais
   - `img` qui regroupe toutes les images du site
   - `files` qui regroupe tout les fichiers téléchargeable du site
   - `js` qui regroupe les script JS
   - `css` qui regroupe toutes les feuilles de style
   - `notebooks` qui regroupe les notebooks sources des corrections et le script de conversion
   
## Ajout / Modification de contenu

Chaque page se décompose comme l'exemple suivant :
~~~~
<section id="global-header">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="block">
          <h1 class="animated fadeInUp">PACKAGES</h1>
          <p></p>
        </div>
      </div>
    </div>
  </div>
</section>
<div class="post">
  <!-- Wrapper Start -->
  <section id="intro" style="border: 1px dotted #ddd;">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="block">
            <h2>ECRIRE UN SOUS TITRE</h2>
			      <p> CONTENU DU PREMIER PARAGRAPHE
            </p>
            
            <h2 class="expand">ECRIRE UN DEUXIEME SOUS TITRE</h2>
			      <p> CONTENU DU PARAGRAPHE RETRACTABLE
            </p>
          </div>
        </div><!-- .col-md-7 close -->
      </div>
    </div>
  </section>
</div>
~~~~
L'ensemble du contenu de la page doit être écrit dans `<div class="block"> ... </div>`.     

La balise de titre `<h2>` est déja stylisé pour être en cohérence avec le thème du site.          
De plus un script JS permet de créer des paragraphes rétractables, pour l'utiliser il suffit de rajouter la classe "expand" à une balise `<h2>`.
  
Ex : `<h2 class="expand">MON TITRE</h2>`
 
Tous les éléments qui sont au même niveau hiérarchiques jusqu'à la prochaine balise `<h2></h2>` sont alors englobés.
 
## Ajout / Modification des notebooks de corrections

Pour ajouter ou modifier les corrections des exercices, vous devez deposer ou modifier un notebooks dans le dossier `notebooks`. Le nom du notebooks doit contenir : 
	- `Chapter` pour être considéré comme anglais
	- `Chapitre` pour être considéré comme français
 
Verifiez que vous avez `jupyter` et `nbconvert` installé puis executez le fichier `script.bat` ou `script.sh` selon votre OS (Windows/Linux).

Une fois l'execution terminé, les fichiers markdowns convertis sont directement déplacés dans les dossiers `_correctionsen` et `_correctionsfr`. SI vous avez choisis d'actualiser le dépot automatiquement à la fin du script le site est alors automatiquement à jour, sinon pensez à l'actualiser.

## Modification du menu

L'essentiel de la barre de navigation se trouve ici : _includes/header.html      

Pour modifier le footer : _includes/footer.html 
La partie délimité par `{% if page.lang == "en" %}` concerne la version anglaise.

De même la partie délimité par `{% if page.lang == "fr" %}` concerne la version française.


