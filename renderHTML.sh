#!/bin/bash

# Créer le fichier HTML partiel
output_file="render_HTML.html"

# Démarrer le contenu du body
echo "<link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css' rel='stylesheet'>
<div class='container mt-5'>
    <h1 class='text-center mb-4'>Projets KiCad</h1>" > $output_file
echo "<p style='font-size:1.2em;'>Cette page contralise des projets réalisées sous Kicad lors des ateliers de Conception Electronique.</p>" >> $output_file    

# Parcourir tous les dossiers du répertoire courant
for dir in */
do
    dir=${dir%/}
    readme_file="$dir/readme.md"
    zip_file="${dir}.zip"
    github_url="https://github.com/CREPP-PLOEMEUR/Projets_Kicad/tree/main/$dir"
    download_url="https://github.com/CREPP-PLOEMEUR/Projets_Kicad/raw/main/${dir}.zip"
    img_file="$dir/img/img.png"
    img_github_url="https://github.com/CREPP-PLOEMEUR/Projets_Kicad/raw/main/$dir/img/img.png"
    
    author_line=$(grep "<!-- AUTEUR" "$readme_file")
    author_name=$(echo "$author_line" | cut -d ':' -f2 | cut -d '-' -f1 )

    date_line=$(grep "<!--- DATE" "$readme_file")
    date_value=$(echo "$date_line" | sed -e 's/<!--- DATE : //' -e 's/ -->//')

    
    # Vérifier si le fichier README.md existe
    if [ -f "$readme_file" ]; then
        # Lire le contenu du fichier README.md
        readme_text=$(cat "$readme_file")
        
        echo "<div class='card mb-4'>
            <div class='card-header water'>
                <h3>$dir</3h>
            </div>
            <div class='card-body'>
                <p style='font-size:1.2em;'<b>$readme_text</b></p>
                <p><strong>Auteur :</strong> $author_name</p>
                <img src='$img_github_url' class='img-fluid mb-3' alt='Image de $dir'>
                <a href='$github_url' class='button button-secondary' target='_blank'><i class='fa-solid fa-eye'></i> Voir sur GitHub</a> <a href='$download_url' class='button button-primary' download><i class='fa-solid fa-download'></i> Télécharger</a>
            </div>
        </div> </br>" >> $output_file
    fi
done

# Fin du contenu du body
echo "</div>" >> $output_file

echo "Le fichier HTML partiel a été généré : $output_file"
