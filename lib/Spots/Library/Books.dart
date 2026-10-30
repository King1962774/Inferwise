// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:inferwise/Spots/Library/txt_reader_page.dart';
import 'package:inferwise/Spots/Library/book_quiz_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String normalizeCategory(String? raw) {
  switch (raw?.trim().toLowerCase()) {
    case 'biography':
      return 'Biography';
    case 'news':
      return 'News';
    case 'stories':
      return 'Stories';
    case 'articles':
      return 'Articles';
    default:
      return 'Biography';
  }
}

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> referenceBooks = [
      //Lvl1
      {
        "title": "From Spark to Genius Nikola Tesla’s Early Life",
        "author": "Martin, T. C. (2012).\n[Ebook released 2012]",
        "whyRead":
            "A captivating look into the life of Nikola Tesla—the genius inventor whose ideas shaped the modern world. This biography reveals his brilliance, struggles, and legacy.",
        "sourceLink":
            "https://www.gutenberg.org/cache/epub/39272/pg39272-images.html#Page_3",
        "cover": "assets/covers/Biography covers/Biography 1.png",
        "path":
            "assets/texts/Biblio/Lvl1/1. From Spark to Genius_ Nikola Tesla’s Early Life.txt",
        "color": "yellow",
        "banner": "assets/Banners/Biography/Biography 1.1.png",
        "category": "Biography",
        "stampKey": "achievements"
      },
      {
        "title": "Cleopatra VIII",
        "author": "Joshua J. Mark / 2018 ",
        "whyRead":
            "A powerful portrait of Cleopatra VII, the last queen of Egypt. This biography explores her intelligence, politics, and the drama that shaped an empire.",
        "sourceLink":
            "https://www.worldhistory.org/trans/es/1-866/cleopatra-vii/",
        "cover": "assets/covers/Biography covers/Biography 2.png",
        "path": "assets/texts/Biblio/Lvl1/2. Cleopatra VIII.txt",
        "color": "yellow",
        "banner": "assets/Banners/Biography/Biography 1.2.png",
        "category": "Biography",
        "stampKey": "serpent"
      },
      {
        "title": "Hellen Keller, The Story of my Life_ Chapters IV to VI",
        "author": "Helen Keller/ 1903 [Ebook Released, 2000]",
        "whyRead":
            "Fragments of an autobiography that reveal Helen's first breakthroughs in communication, capturing the wonder and struggle of learning to express herself beyond silence and darkness.",
        "sourceLink":
            "https://cbseacademic.nic.in/web_material/doc/The%20Story%20of%20My%20Life,%20by%20Helen%20Keller.pdf",
        "cover": "assets/covers/Biography covers/Biography 3.png",
        "path":
            "assets/texts/Biblio/Lvl1/3. Hellen Keller, The Story of my Life_ Chapters IV to VI.txt",
        "color": "yellow",
        "banner": "assets/Banners/Biography/Biography 1.3.png",
        "category": "Biography",
        "stampKey": "learned"
      },

      {
        "title": "Houses Made of Waste Changing Lives in South America",
        "author": "Aleida Rueda / 2024 ",
        "whyRead":
            "Discover how discarded plastic bottles, old tyres, and construction waste are being transformed into sustainable homes across Latin America, addressing both pollution and housing shortages.",
        "sourceLink":
            "https://www.scidev.net/global/features/houses-made-of-waste-changing-lives-in-south-america/",
        "path":
            "assets/texts/4. Houses made of waste changing lives in South America.txt",
        "cover": "assets/covers/News covers/News 1.png",
        "color": "green",
        "banner": "assets/Banners/News/News 1.1.png",
        "category": "News",
        "stampKey": "Colombian"
      },
      {
        "title": "Uganda’s Anti-Gay Law Sparks Global Concerns",
        "author": "Dann Okoth / 2023",
        "whyRead":
            "Get a view about how Uganda’s anti-gay law raises urgent global concerns as it threatens access to healthcare and human rights for LGBTQ+ communities.",
        "sourceLink":
            "https://www.scidev.net/global/news/ugandas-anti-gay-law-sparks-global-concerns-over-health-access/",
        "path":
            "assets/texts/5. Uganda’s anti-gay law sparks global concerns.txt",
        "cover": "assets/covers/News covers/News 2.png",
        "color": "green",
        "banner": "assets/Banners/News/News 1.2.png",
        "category": "News",
        "stampKey": "communities"
      },
      {
        "title":
            "A Recovery Center in Nigeria Takes a Musical Approach to Combating Drug Addiction",
        "author": "Pamela Ephraim / 2025",
        "whyRead":
            "Explore how Nigeria's Light Center harnesses music and faith to rehabilitate individuals battling drug addiction, fostering community and personal transformation.",
        "sourceLink":
            "https://globalvoices.org/2024/10/23/a-recovery-center-in-nigeria-takes-a-musical-approach-to-rehabilitating-drug-addicts/",
        "path":
            "assets/texts/6. A recovery center in Nigeria takes a musical approach to combating drug addiction.txt",
        "cover": "assets/covers/News covers/News 3.png",
        "color": "green",
        "banner": "assets/Banners/News/News 1.3.png",
        "category": "News",
        "stampKey": "genuine love"
      },
      {
        "title": "The Star Beast",
        "author": "Damon Knight / 1949 [Ebook Released, 2021]",
        "whyRead":
            "In this gripping sci-fi tale, a spaceship crew meets a strange alien named Oscar. This exciting story shows what can happen when humans and aliens try to understand each other.",
        "sourceLink":
            "https://www.gutenberg.org/cache/epub/64596/pg64596-images.html",
        "path": "assets/texts/7. The Star Beast.txt",
        "cover": "assets/covers/Story/Story 1.png",
        "color": "blue",
        "banner": "assets/Banners/Story/Story 1.1.png",
        "category": "Stories",
        "stampKey": "slowly"
      },
      {
        "title": "Désirée's Baby",
        "author": "Kate Chopin / 1899 [Ebook Released, 2006] ",
        "whyRead":
            "This powerful story tells how a woman's life changes after her baby is born. A surprising ending shows the deep injustice of racism in the past.",
        "sourceLink":
            "https://www.gutenberg.org/cache/epub/160/pg160-images.html#link2H_4_0048",
        "path": "assets/texts/8. Désirée’s Baby.txt",
        "cover": "assets/covers/Story/Story 2.png",
        "color": "blue",
        "banner": "assets/Banners/Story/Story 1.2.png",
        "category": "Stories",
        "stampKey": "never returned"
      },
      {
        "title": "The Shadow",
        "author": "Edith Nesbit / 1905 ",
        "whyRead":
            "A group of friends hear a strange story about a shadow that brings fear and mystery. A chilling tale that makes you wonder what’s real and what’s not.",
        "sourceLink":
            "https://www.oldstyletales.com/single-post/2019/06/26/the-shadow-by-e-nesbit-with-footnote-annotations",
        "path": "assets/texts/9. The Shadow.txt",
        "cover": "assets/covers/Story 3.png",
        "color": "blue",
        "banner": "assets/Banners/Story/Story 1.3.png",
        "category": "Stories",
        "stampKey": "inherited"
      },
      {
        "title":
            "The Role of Mobile Health (mHealth) in Primary Care: Opportunities and Challenges",
        "author":
            "Veronica Ramirez, Emily Johnson, Cesar Gonzalez, Vanessa Ramirez, Barbara Rubino, and  Gina Rossetti / 2016 ",
        "whyRead":
            "This study shows how people in low-income areas use mobile apps to manage their health, with strong interest in using technology for better care.",
        "sourceLink": "https://mhealth.jmir.org/2016/2/e41/ ",
        "path":
            "assets/texts/10. The Role of Mobile Health (mHealth) in Primary Care_ Opportunities and Challenges.txt",
        "cover": "assets/covers/Article covers/Article 1.png",
        "color": "purple",
        "banner": "assets/Banners/Article/Article 1.1.png",
        "category": "Articles",
        "stampKey": "mHealth",
        "format": "APA",
        "headings": [
          "Introduction",
          "How Patients Use mHealth Technology",
          "Challenges in mHealth Adoption",
          "The Future of mHealth in Primary Care",
          "Conclusion"
        ]
      },
      {
        "title":
            "Gender Stereotypes in AI-Generated Images: Biases, Implications, and Solutions",
        "author": "Fancisco-José García-Ull and Mónica Melero-Lázaro / 2023",
        "whyRead":
            "Artificial Intelligence (AI) image generators may reinforce gender stereotypes. This study highlights the need for awareness of biases in AI technologies.  ",
        "sourceLink":
            "https://revista.profesionaldelainformacion.com/index.php/EPI/article/view/87305/63470",
        "path":
            "assets/texts/11. Gender Stereotypes in AI-Generated Images_ Biases, Implications, and Solutions.txt",
        "cover": "assets/covers/Article covers/Article 2.png",
        "color": "purple",
        "banner": "assets/Banners/Article/Article 1.2.png",
        "category": "Articles",
        "stampKey": "Stereotypical",
        "format": "APA",
      },
      {
        "title":
            "Sustainable Development Through Eco-Innovation: The Role of Small and Medium Enterprises in Colombia",
        "author":
            "Thomas Tegethoff, Ricardo Santa, Juan Manuel Bucheli, Benjamin Cabrera, Annibal Scavarda / 2025",
        "format": "APA",
        "specialWord": "eco-innovation",
        "whyRead":
            "Going green pays off—this study shows how Colombian small businesses use eco-innovation to boost profits and protect the planet.",
        "sourceLink":
            "https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0316620#references",
        "path":
            "assets/texts/12. Sustainable Development Through Eco-Innovation_ The Role of Small and Medium Enterprises in Colombia.txt",
        "cover": "assets/covers/Article covers/Article 3.png",
        "color": "purple",
        "banner": "assets/Banners/Article/Article 1.3.png",
        "category": "Articles",
        "stampKey": "ecological",
        "format": "APA",
      }
    ];
    final List<Map<String, dynamic>> lexicalBooks = [
      //Lvl2
      {
        "title":
            "Ynes E. J. Mexia, Where Love for Science Meets the Spirit of Adventure",
        "author": "Carolina Martínez Pulido / 2022",
        "whyRead":
            "This inspiring biography tells the story of Ynes Mexía—a fearless woman who turned her love for science and adventure into a groundbreaking career in botany.",
        "sourceLink":
            "https://mujeresconciencia.com/2022/12/27/ynes-e-j-mexia-fructifera-combinacion-entre-amor-a-la-ciencia-y-a-la-aventura/",
        "cover": "assets/covers/Biography covers/Biography 4.png",
        "path":
            "assets/texts/Biblio/Lvl2/1. Ynes E. J. Mexia, Where Love for Science Meets the Spirit of Adventure.txt",
        "color": "yellow",
        "banner": "assets/Banners/Biography/Biography 2.1.png",
        "category": "Biography",
        "stampKey": "recognized"
      },
      {
        "title": "The Story of Atahualpa, Last Inca Emperor",
        "author": "Mark Cartwright /2016 ",
        "whyRead":
            "Atahualpa’s rise and fall. This biography tells the dramatic story of the last Inca emperor—his power, betrayal, and a tragic end that changed history.",
        "sourceLink":
            "https://www.worldhistory.org/trans/es/1-12512/atahualpa/",
        "cover": "assets/covers/Biography covers/Biography 5.png",
        "path":
            "assets/texts/Biblio/Lvl2/2. The Story of Atahualpa, Last Inca Emperor.txt",
        "color": "yellow",
        "banner": "assets/Banners/Biography/Biography 2.2.png",
        "category": "Biography",
        "stampKey": "feathers"
      },
      {
        "title": "Nietzsche His Life and Works",
        "author": "Anthony M. Ludovici / 1914 [Ebook Realeased, 2016] ",
        "whyRead":
            "Dive into the bold life of Nietzsche—the philosopher who challenged everything, from truth to morality, and shaped the way we think today.",
        "sourceLink":
            "https://www.gutenberg.org/cache/epub/53260/pg53260-images.html",
        "cover": "assets/covers/Biography covers/Biography 6.png",
        "path": "assets/texts/Biblio/Lvl2/3. Nietzsche_ His Life and Works.txt",
        "color": "yellow",
        "banner": "assets/Banners/Biography/Biography 2.3.png",
        "category": "Biography",
        "stampKey": "strong"
      },
      {
        "title": "How Evolution Might Explain Impatience",
        "author": "Daniel Read / 2025",
        "whyRead":
            "​Explore how evolution may have shaped our tendency for impatience, revealing its surprising role in human survival and decision-making.",
        "sourceLink":
            "https://theconversation.com/how-evolution-might-explain-impatience-249325",
        "path": "assets/texts/How Evolution Might Explain Impatience.txt",
        "cover": "assets/covers/News covers/News 4.png",
        "color": "green",
        "banner": "assets/Banners/News/News 2.1.png",
        "category": "News",
        "stampKey": "£"
      },
      {
        "title": "Q&A: ‘Fear of Laughter’ Keeps Girls Quiet at School",
        "author": "Charles Pensulo / 2023",
        "whyRead":
            "Discover how the fear of being laughed at silences schoolgirls, and why boosting their self-esteem is key to keeping them engaged in education. ​",
        "sourceLink":
            "https://www.scidev.net/global/role-models/fear-of-laughter-keeps-girls-quiet-at-school/",
        "path":
            "assets/texts/Q&A_ ‘Fear of Laughter’ Keeps Girls Quiet at School.txt",
        "cover": "assets/covers/News covers/News 5.png",
        "color": "green",
        "banner": "assets/Banners/News/News 2.2.png",
        "category": "News",
        "stampKey": "Malawi"
      },
      {
        "title":
            "Feminist Literature Under Fire: The ‘Cometierra’ Controversy in Argentina",
        "author": "Romina Navarro and Lucía Leszinsky / 2024",
        "whyRead":
            "A banned feminist novel in Argentina gains fame instead of silence—Cometierra turns controversy into power.",
        "sourceLink":
            "https://globalvoices.org/2024/12/07/feminist-literature-under-fire-the-cometierra-controversy-in-argentina/",
        "path":
            "assets/texts/Feminist Literature Under Fire_ The ‘Cometierra’ Controversy in Argentina.txt",
        "cover": "assets/covers/News covers/News 6.png",
        "color": "green",
        "banner": "assets/Banners/News/News 2.3.png",
        "category": "News",
        "stampKey": "Casa Rosada"
      },
      {
        "title": "The Nothing Equation",
        "author": "Tom Godwin / 1957 [Ebook Realeased, 2008]",
        "whyRead":
            "Alone in space, one man faces a mystery that drove others mad. The Nothing Equation is a chilling sci-fi tale of fear and survival.",
        "sourceLink":
            "https://www.gutenberg.org/cache/epub/25628/pg25628-images.html",
        "path": "assets/texts/The Nothing Equation.txt",
        "cover": "assets/covers/Story/Story 4.png",
        "color": "blue",
        "banner": "assets/Banners/Story/Story 2.1.png",
        "category": "Story",
        "stampKey": "Nothing"
      },
      {
        "title": "A Dill Pickle",
        "author": "Katherine Mansfield /1917",
        "whyRead":
            "Old lovers meet again—but time has changed them. A Dill Pickle quietly unpacks pride, memory, and what’s left unsaid.",
        "sourceLink":
            "https://americanliterature.com/author/katherine-mansfield/short-story/a-dill-pickle/#google_vignette",
        "path": "assets/texts/A Dill Pickle.txt",
        "cover": "assets/covers/Story/Story 5.png",
        "color": "blue",
        "banner": "assets/Banners/Story/Story 2.2.png",
        "category": "Story",
        "stampKey": "Vera"
      },
      {
        "title": "The Tell-Tale Heart",
        "author": "Edgar Allan Poe / 1843",
        "whyRead":
            "A guilty mind can’t stay silent. The Tell-Tale Heart is a chilling dive into madness, obsession, and a deadly secret.",
        "sourceLink": "https://poemuseum.org/the-tell-tale-heart/",
        "path": "assets/texts/The Tell-Tale Heart.txt",
        "cover": "assets/covers/Story/Story 6.png",
        "color": "blue",
        "banner": "assets/Banners/Story/Story 2.3.png",
        "category": "Story",
        "stampKey": "heart"
      },
      {
        "title":
            "The Global Transition to Electric Vehicles: Technological, Environmental, Organizational, and Policy Perspectives",
        "author":
            "Rami Zaino, Vian Ahmed, Ahmed Mohamed Alhammadi, and Mohamad Alghoush / 2024",
        "whyRead":
            "Electric vehicles are changing more than roads—this article explores their wide impact on tech, the planet, and policy.",
        "sourceLink": "https://www.mdpi.com/2032-6653/15/8/375",
        "path":
            "assets/texts/The Global Transition to Electric Vehicles_ Technological, Environmental, Organizational, and Policy Perspectives.txt",
        "cover": "assets/covers/Article covers/Article 4.png",
        "color": "purple",
        "banner": "assets/Banners/Article/Article 2.1.png",
        "category": "Article",
        "stampKey": "solar",
        "format": "APA",
      },
      {
        "title":
            "The Actualization of Loneliness in Modern Philosophy: Historical Perspectives and Contemporary Reflection",
        "author":
            " Beken Balapashev, Aigul Tursynbayeva, and Ainur Zhangaliyeva / 2023",
        "whyRead":
            "​Explore how modern philosophy interprets loneliness, revealing its impact on our spiritual and social lives.",
        "sourceLink":
            "https://www.scielo.br/j/trans/a/QWpyLMrtXRTrqyntjLkJwYQ/?lang=en",
        "path":
            "assets/texts/The Actualization of Loneliness in Modern Philosophy_ Historical Perspectives and Contemporary Reflections.txt",
        "cover": "assets/covers/Article covers/Article 5.png",
        "color": "purple",
        "banner": "assets/Banners/Article/Article 2.2.png",
        "category": "Article",
        "stampKey": "isolation",
        "format": "APA",
      },
      {
        "title":
            "Pathways to a Net Zero Building Sector in Colombia: Challenges, Strategies, and Opportunities",
        "author": "Johan Andrés Vélez-Henao and Stefan Pauliuk /2025 ",
        "whyRead":
            "Colombia's fast-growing cities are pushing the residential sector's energy use sky-high. This study explores how to steer these buildings toward a net-zero future.",
        "sourceLink":
            "https://www.sciencedirect.com/science/article/pii/S0921344924005627",
        "path":
            "assets/texts/Pathways to a Net Zero Building Sector in Colombia_ Challenges, Strategies, and Opportunities.txt",
        "cover": "assets/covers/Article covers/Article 6.png",
        "color": "purple",
        "banner": "assets/Banners/Article/Article 2.3.png",
        "category": "Article",
        "stampKey": "materials",
        "format": "APA",
      },
    ];

    final List<Map<String, dynamic>> explanationBooks = [
      //Lvl3
      {
        "title": "Alexander Graham Bell And The Telephone",
        "author": "Rupert Sargent Holland / 1911 [Ebook Released, 2013] ",
        "whyRead":
            "From curiosity to connection—this biography reveals how Alexander Graham Bell turned sound into history with the invention of the telephone.",
        "sourceLink":
            "https://www.gutenberg.org/cache/epub/42517/pg42517-images.html#XIII",
        "cover": "assets/covers/Biography covers/Biography 7.png",
        "path":
            "assets/texts/Biblio/Lvl3/1. Alexander Graham Bell And The Telephone.txt",
        "color": "yellow",
        "banner": "assets/Banners/Biography/Biography 3.2.png",
        "category": "Biography",
        "stampKey": "speak"
      },
      {
        "title": "Life and Times of Mandela",
        "author": "South Africa Goverment ",
        "whyRead":
            "​Nelson Mandela's journey—from rural villager to global symbol of freedom—embodies resilience and the enduring fight for justice.",
        "sourceLink": "https://www.gov.za/mandela100/biography",
        "cover": "assets/covers/Biography covers/Biography 8.png",
        "path": "assets/texts/Biblio/Lvl3/2. Life and Times of Mandela.txt",
        "color": "yellow",
        "banner": "assets/Banners/Biography/Biography 3.1.png",
        "category": "Biography",
        "stampKey": "South Africa"
      },
      {
        "title": "Girls Who Became Famous Florence Nightingale",
        "author": "Sarah Knowles Bolton / 1914 [Ebook Released, 2004]",
        "whyRead":
            "Known as the Lady with the Lamp, Florence Nightingale revolutionized nursing and proved how one woman’s care could change the world.",
        "sourceLink":
            "https://www.gutenberg.org/cache/epub/12081/pg12081-images.html#c16",
        "cover": "assets/covers/Biography covers/Biography 9.png",
        "path":
            "assets/texts/Biblio/Lvl3/3. Girls Who Became Famous_ Florence Nightingale.txt",
        "color": "yellow",
        "banner": "assets/Banners/Biography/Biography 3.3.png",
        "category": "Biography",
        "stampKey": "Angel"
      },
      {
        "title": "AI Chatbot Deployed to Target Drug Resistance",
        "author": " Dann Okoth / 2025",
        "whyRead":
            "This news shows how scientists have developed an AI chatbot similar to ChatGPT to help governments devise effective policies for battling drug resistance. ",
        "sourceLink":
            "https://www.scidev.net/global/news/ai-chatbot-deployed-to-target-drug-resistance/",
        "path":
            "assets/texts/Ai Chatbot Deployed to Target Drug Resistance.txt",
        "cover": "assets/covers/News covers/News 7.png",
        "color": "green",
        "banner": "assets/Banners/News/News 3.1.png",
        "category": "News",
        "stampKey": "Chinese"
      },
      {
        "title": "Polio Survivors Face Biggest Fight of Their Lives",
        "author": "Neena Bhandari / 2024",
        "whyRead":
            "Polio survivors face new battles long after the virus—calling for stronger support and care.",
        "sourceLink":
            "https://www.scidev.net/global/opinions/polio-survivors-face-biggest-fight-of-their-lives/",
        "path":
            "assets/texts/Polio Survivors Face Biggest Fight of Their Lives.txt",
        "cover": "assets/covers/News covers/News 8.png",
        "color": "green",
        "banner": "assets/Banners/News/News 3.2.png",
        "category": "News",
        "stampKey": "India"
      },
      {
        "title": "In Venezuela, Theater is also Part of the Resistance",
        "author": "Natali Herrera Pacheco / 2017",
        "whyRead":
            "​In Venezuela, theater artists are turning the stage into a platform for resistance, using performances to reflect and challenge the nation's deepening crisis.",
        "sourceLink":
            "https://globalvoices.org/2017/08/05/in-venezuela-theater-is-also-part-of-the-resistance/",
        "path":
            "assets/texts/In Venezuela, Theater is also Part of the Resistance.txt",
        "cover": "assets/covers/News covers/News 9.png",
        "color": "green",
        "banner": "assets/Banners/News/News 3.3.png",
        "category": "News",
        "stampKey": "resistance"
      },
      {
        "title": "The Plutonian Drug",
        "author": "Clark Ashton Smith / 1934",
        "whyRead":
            "A sculptor experiments with a rare substance from Pluto that grants visions across time, leading to unforeseen consequences. ​",
        "sourceLink":
            "https://www.libraryofshortstories.com/onlinereader/the-plutonian-drug",
        "path": "assets/texts/The Plutonian Drug.txt",
        "cover": "assets/covers/Story/Story 7.png",
        "color": "blue",
        "banner": "assets/Banners/Story/Story 3.1.png",
        "category": "Stories",
        "stampKey": "Dr. Manners"
      },
      {
        "title": "Sweat",
        "author": "Zora Neale Hurston / 1926",
        "whyRead":
            "Delia endures years of abuse from her husband, Sykes, but when he brings a rattlesnake into their home to terrorize her, events take a dark turn.",
        "sourceLink":
            "https://biblioklept.org/2013/01/21/sweat-zora-neale-hurston/",
        "path": "assets/texts/Sweat.txt",
        "cover": "assets/covers/Story/Story 8.png",
        "color": "blue",
        "banner": "assets/Banners/Story/Story 3.2.png",
        "category": "Stories",
        "stampKey": "Delia"
      },
      {
        "title": "The Outsider",
        "author": "H. P. Lovecraft / 1926",
        "whyRead":
            "A lonely soul escapes the darkness—only to face a chilling truth. The Outsider is a haunting tale of identity, horror, and self-discovery.",
        "sourceLink":
            "https://arkhamarchivist.com/ebook/The%20Complete%20Works%20of%20H.P.%20Lovecraft.pdf",
        "path": "assets/texts/The Outsider.txt",
        "cover": "assets/covers/Story/Story 9.png",
        "color": "blue",
        "banner": "assets/Banners/Story/Story 3.3.png",
        "category": "Stories",
        "stampKey": "monster"
      },
      {
        "title":
            "Advancements in 3D Bioprinting: A New Era in Tissue Engineering",
        "author":
            " Giovanna Ricci, Filippo Gibelli, and Ascanio Sirignano / 2023",
        "whyRead":
            "This article delves into the bioethical and legal challenges of 3D bioprinting human organs, highlighting the need for updated policies in this rapidly advancing field. ",
        "sourceLink": "https://www.mdpi.com/2306-5354/10/9/1052",
        "path":
            "assets/texts/Advancements in 3D Bioprinting_ A New Era in Tissue Engineering.txt",
        "cover": "assets/covers/Article covers/Article 7.png",
        "color": "purple",
        "banner": "assets/Banners/Article/Article 3.1.png",
        "category": "Articles",
        "stampKey": "3D",
        "format": "APA",
      },
      {
        "title":
            "Communication Strategies for Dementia Care: A New Perspective on Caregiving",
        "author":
            "Christopher Johnson, Jordan Kelch, and Roxanna Johnson / 2017",
        "whyRead":
            "An ancestral alternative for sustainable building. Bamboo is reshaping low-cost housing with strength, sustainability, and quake resistance. ",
        "sourceLink": "https://www.mdpi.com/2076-328X/7/3/42",
        "path":
            "assets/texts/Communication Strategies for Dementia Care_ A New Perspective on Caregiving.txt",
        "cover": "assets/covers/Article covers/Article 8.png",
        "color": "purple",
        "banner": "assets/Banners/Article/Article 3.2.png",
        "category": "Articles",
        "stampKey": "symbolic",
        "format": "APA",
      },
      {
        "title":
            "Bamboo as a Sustainable Building Material for Innovative, Low-Cost Housing Construction",
        "author": "Jan Bredenoord / 2025",
        "whyRead":
            "​This article explores how symbolic interactionism can enhance communication between family members and individuals with dementia at the end of life.",
        "sourceLink": "https://www.mdpi.com/2071-1050/16/6/2347",
        "path":
            "assets/texts/Bamboo as a Sustainable Building Material for Innovative, Low-Cost Housing Construction.txt",
        "cover": "assets/covers/Article covers/Article 9.png",
        "color": "purple",
        "banner": "assets/Banners/Article/Article 3.3.png",
        "category": "Articles",
        "stampKey": "bamboo",
        "format": "APA",
      },
    ];

    final List<Map<String, dynamic>> associationBooks = [
      //Lvl4
      {
        "title": "The Wright Brothers’ Aeroplane",
        "author":
            "Orville Wright and Wilbur Wright / 1922 [Ebook Released , 2008]",
        "whyRead":
            "​In the first chapter of The Early History of the Airplane, the Wright brothers recount their childhood fascination with flight, sparked by a toy helicopter from their father. This early interest laid the foundation for their groundbreaking work in aviation. ",
        "sourceLink":
            "https://www.gutenberg.org/cache/epub/25420/pg25420-images.html",
        "cover": "assets/covers/Biography covers/Biography 10.png",
        "path":
            "assets/texts/Biblio/Lvl4/1. The Wright Brothers’ Aeroplane.txt",
        "color": "yellow",
        "banner": "assets/Banners/Biography/Biography 4.1.png",
        "category": "Biography",
        "stampKey": "wings"
      },
      {
        "title": "Lives of Poor Boys Who Became Famous Abraham Lincon",
        "author": "Sarah Knowles Bolton / 1885 [Ebook Released, 2011]",
        "whyRead":
            "​Born in a humble Kentucky log cabin, Abraham Lincoln rose through self-education and determination to become the 16th U.S. president, leading the nation through the Civil War and abolishing slavery. ",
        "sourceLink":
            "https://www.gutenberg.org/cache/epub/35950/pg35950-images.html#Page_342",
        "cover": "assets/covers/Biography covers/Biography 11.png",
        "path":
            "assets/texts/Biblio/Lvl4/2. Lives of Poor Boys Who Became Famous_ Abraham Lincon.txt",
        "color": "yellow",
        "banner": "assets/Banners/Biography/Biography 4.2.png",
        "category": "Biography",
        "stampKey": "Lincoln"
      },
      {
        "title": "Memoir of Jane Austen Fragment",
        "author": "James Edward Austen-Leigh / 1871 [Ebook Released, 2006] ",
        "whyRead":
            "​In the opening chapter of A Memoir of Jane Austen, James Edward Austen-Leigh reflects on his aunt's uneventful life, highlighting her modesty and the posthumous rise of her literary fame. ​",
        "sourceLink":
            "https://www.gutenberg.org/cache/epub/17797/pg17797-images.html",
        "cover": "assets/covers/Biography covers/Biography 12.png",
        "path":
            "assets/texts/Biblio/Lvl4/3. Memoir of Jane Austen_ Fragment.txt",
        "color": "yellow",
        "banner": "assets/Banners/Biography/Biography 4.3.png",
        "category": "Biography",
        "stampKey": "Jane"
      },
      {
        "title": "Indigenous People Raise Voices to Avert Amazon Tipping Point",
        "author": "Aleida Rueda / 2021",
        "whyRead":
            "​A journal article that shows how Indigenous communities are raising their voices to prevent the Amazon from reaching a critical tipping point, emphasizing the need for inclusive conservation efforts. ​",
        "sourceLink":
            "https://www.scidev.net/global/supported-content/indigenous-people-raise-voices-to-avert-amazon-tipping-point/ ",
        "path":
            "assets/texts/Indigenous People Raise Voices to Avert Amazon Tipping Point.txt",
        "cover": "assets/covers/News covers/News 10.png",
        "color": "green",
        "banner": "assets/Banners/News/News 4.1.png",
        "category": "News",
        "stampKey": "Peru"
      },
      {
        "title": "Syrians Turn War Missiles into Heaters as Winter Grips",
        "author": "Sonia el-Ali / 2022",
        "whyRead":
            "​Amidst poverty and harsh winter conditions, Syrians are repurposing war missiles into makeshift heaters, a practice that, while innovative, poses significant health risks. ",
        "sourceLink":
            "https://www.scidev.net/global/syrians-turn-war-missiles-into-heaters-as-winter-grips/ ",
        "path":
            "assets/texts/Syrians Turn War Missiles into Heaters as Winter Grips.txt",
        "cover": "assets/covers/News covers/News 11.png",
        "color": "green",
        "banner": "assets/Banners/News/News 4.2.png",
        "category": "News",
        "stampKey": "Syrians"
      },
      {
        "title":
            "Brazilian Graffiti Artists and Young Syrians Are Painting Refugee Camp Walls Together",
        "author": "Rami Alhames / 2017",
        "whyRead":
            "In Lebanon's Beqaa Valley, Brazilian graffiti artists and young Syrians collaborated to transform refugee camp walls into vibrant murals, bringing color and hope to the community.  ",
        "sourceLink":
            "https://globalvoices.org/2017/04/29/brazilian-graffiti-artists-and-young-syrians-are-painting-refugee-camp-walls-together/",
        "path":
            "assets/texts/Brazilian Graffiti Artists and Young Syrians Are Painting Refugee Camp Walls Together.txt",
        "cover": "assets/covers/News covers/News 12.png",
        "color": "green",
        "banner": "assets/Banners/News/News 4.3.png",
        "category": "News",
        "stampKey": "Brazilian"
      },
      {
        "title": "2BR02B",
        "author": " Kurt Vonnegut / 1962",
        "whyRead":
            "In a world where death makes room for life, one father faces a haunting choice before his children are born.",
        "sourceLink":
            "https://www.libraryofshortstories.com/onlinereader/2br02b",
        "path": "assets/texts/2BR02B.txt",
        "cover": "assets/covers/Story/Story 10.png",
        "color": "blue",
        "banner": "assets/Banners/Story/Story 4.1.png",
        "category": "Stories",
        "stampKey": "Mr. Wehling,"
      },
      {
        "title": "The Pearl of Love",
        "author": " H. G. Wells / 1925",
        "whyRead": "​In H.G. Wells' "
            "The Pearl of Love,"
            "a grieving Indian prince dedicates his life to building a magnificent monument for his late wife, only to confront the impermanence of his creation. ",
        "sourceLink":
            "libraryofshortstories.com/onlinereader/the-pearl-of-love",
        "path": "assets/texts/The Pearl of Love.txt",
        "cover": "assets/covers/Story/Story 11.png",
        "color": "blue",
        "banner": "assets/Banners/Story/Story 4.2.png",
        "category": "Stories",
        "stampKey": "he"
      },
      {
        "title": "The Yellow Wall-Paper",
        "author": "Charlotte Perkins Gilman / 1892  [Ebook Released, 1999] ",
        "whyRead":
            "Trapped in a room with eerie wallpaper, a woman’s descent into madness reveals the haunting effects of isolation and repression in this gripping short story.",
        "sourceLink":
            "https://www.gutenberg.org/cache/epub/1952/pg1952-images.html",
        "path": "assets/texts/The Yellow Wallpaper.txt",
        "cover": "assets/covers/Story/Story 12.png",
        "color": "blue",
        "banner": "assets/Banners/Story/Story 4.3.png",
        "category": "Stories",
        "stampKey": "John"
      },
      {
        "title":
            "The Evolution of Mars Water-Ice Detection Research (1990–2024)",
        "author": " Aijie Yu, Hubiao Wang, Delong An, and Hongling Shi / 2025",
        "whyRead":
            "​This study reviews Mars water-ice detection research from 1990 to 2024, highlighting technological advancements and ongoing challenges. ​",
        "sourceLink": "https://www.mdpi.com/2072-4292/17/6/1023",
        "path":
            "assets/texts/The Evolution of Mars Water-Ice Detection Research (1990-2024).txt",
        "cover": "assets/covers/Article covers/Article 10.png",
        "color": "purple",
        "banner": "assets/Banners/Article/Article 4.1.png",
        "category": "Articles",
        "stampKey": "Mars",
        "format": "APA",
      },
      {
        "title": "Burnout and Depression in College Students",
        "author":
            "Xianyang Wang, Mengyuan Yang, Lei Ren, Qingyi Wang, ... / 2024",
        "whyRead":
            "This study examines the distinct yet interconnected roles of cynicism and depression in college student burnout, highlighting the need for targeted intervention",
        "sourceLink":
            "https://www.sciencedirect.com/science/article/pii/S0165178124001136",
        "cover": "assets/covers/Article covers/Article 11.png",
        "path": "assets/texts/Burnout and Depression in College Students.txt",
        "color": "purple",
        "banner": "assets/Banners/Article/Article 4.2.png",
        "category": "Articles",
        "stampKey": "Exhaustion",
        "format": "APA",
      },
      {
        "title":
            "The Impact of Environmental Pollution on the Sustainability of Architectural Heritage: The Case of Cartagena de Indias",
        "author":
            "Cano, Ríos-Rojas, Hernández-Fernández, Bernal Herrera, Bautista Betancur, De La Hoz Vélez, Agámez González. / 2022",
        "whyRead":
            "​Environmental pollution poses a significant threat to Cartagena's architectural heritage, necessitating sustainable conservation strategies. ",
        "sourceLink": "https://www.mdpi.com/2071-1050/14/1/189",
        "path":
            "assets/texts/The Impact of Environmental Pollution on the Sustainability of Architectural Heritage_ The Case of Cartagena de Indias.txt",
        "cover": "assets/covers/Article covers/Article 12.png",
        "color": "purple",
        "banner": "assets/Banners/Article/Article 4.3.png",
        "category": "Articles",
        "stampKey": "historical",
        "format": "APA",
      },
    ];

    final List<Map<String, dynamic>> predictionBooks = [
      //Lvl5
      {
        "title":
            "Giuseppina Cattani, the Unknown Co-Discoverer of the Antitetanus Serum",
        "author": "Marta Macho Stadler / 2025",
        "whyRead":
            "Giuseppina Cattani, a trailblazing Italian scientist, helped discover the tetanus antitoxin—but history almost forgot her name. Discover the woman behind the breakthrough.",
        "sourceLink":
            "https://mujeresconciencia.com/2025/04/02/giuseppina-cattani-la-desconocida-codescubridora-del-suero-antitetanico/",
        "cover": "assets/covers/Biography covers/Biography 13.png",
        "path":
            "assets/texts/Biblio/Lvl5/1. Giuseppina Cattani, the Unknown Co-Discoverer of the Antitetanus Serum.txt",
        "color": "yellow",
        "banner": "assets/Banners/Biography/Biography 5.1.png",
        "category": "Biography",
        "stampKey": "Giuseppina"
      },
      {
        "title": "The Story of Joan of Arc: Chapters I - II",
        "author": "Andrew Lang / 1906 [Ebook Released, 2015] ",
        "whyRead":
            "From humble beginnings to divine visions—Joan of Arc’s journey to save France begins with courage and faith in these powerful first chapters.",
        "sourceLink":
            "https://www.gutenberg.org/cache/epub/48470/pg48470-images.html#link2HCH0001",
        "cover": "assets/covers/Biography covers/Biography 14.png",
        "path":
            "assets/texts/Biblio/Lvl5/2. The Story of Joan of Arc_ Fragments.txt",
        "color": "yellow",
        "banner": "assets/Banners/Biography/Biography 5.2.png",
        "category": "Biography",
        "stampKey": "battle"
      },
      {
        "title": "Famous Men of Ancient Times Socrates",
        "author": "Samuel G. Goodrich / 1843 [Ebook Released, 2016]",
        "whyRead":
            "Wise, bold, and endlessly curious—Socrates challenged Athens with questions that still echo today. Discover how one man’s ideas reshaped philosophy forever.",
        "sourceLink":
            "https://www.gutenberg.org/cache/epub/52400/pg52400-images.html#Page_229",
        "cover": "assets/covers/Biography covers/Biography 15.png",
        "banner": "assets/Banners/Biography/Biography 5.3.png",
        "path":
            "assets/texts/Biblio/Lvl5/3. Famous Men of Ancient Times_ Socrates.txt",
        "color": "yellow",
        "category": "Biography",
        "stampKey": "poison"
      },
      {
        "title":
            "Will the US Get to Mars Quicker if it Drops or Delays Plans to Visit the Moon",
        "author": "Ian Whittaker / 2025",
        "whyRead":
            "Could skipping the Moon speed up a U.S. mission to Mars? This article dives into NASA’s tough choice between ambition and strategy.",
        "sourceLink":
            "https://theconversation.com/will-the-us-get-to-mars-quicker-if-it-drops-or-delays-plans-to-visit-the-moon-248046",
        "path":
            "assets/texts/Will the US Get to Mars Quicker if it Drops or Delays Plans to Visit the Moon.txt",
        "cover": "assets/covers/News covers/News 13.png",
        "color": "green",
        "banner": "assets/Banners/News/News 5.1.png",
        "category": "News",
        "stampKey": "White House"
      },
      {
        "title": "The Urgent Mental Health Needs of Young People",
        "author":
            " Tovah Cowan, Camila Velez, Nora Morrison, Rubén Valle, and Srividya Narayanan Iyer / 2025",
        "whyRead":
            "Canada faces a youth mental health crisis—this article shares global lessons to help turn the tide.",
        "sourceLink":
            "https://theconversation.com/the-urgent-mental-health-needs-of-young-people-lessons-for-canada-from-a-global-commission-245039 ",
        "path":
            "assets/texts/The Urgent Mental Health Needs of Young People.txt",
        "cover": "assets/covers/News covers/News 14.png",
        "color": "green",
        "banner": "assets/Banners/News/News 5.2.png",
        "category": "News",
        "stampKey": "Canada"
      },
      {
        "title":
            "A Central African Designer is Transforming Sneakers into Portable Manga in Senegal",
        "author": "Jean Sovon / 2023",
        "whyRead":
            "​In Senegal, Central African designer Gabriel Gabs Abens customizes sneakers with manga art, merging Japanese pop culture with African fashion.",
        "sourceLink":
            "https://globalvoices.org/2023/09/19/a-central-african-designer-is-transforming-sneakers-into-portable-manga-in-senegal/",
        "path":
            "assets/texts/A Central African Designer is Transforming Sneakers into Portable Manga in Senegal.txt",
        "cover": "assets/covers/News covers/News 15.png",
        "color": "green",
        "banner": "assets/Banners/News/News 5.3.png",
        "category": "News",
        "stampKey": "Africa"
      },
      {
        "title": "A Sound of Thunder",
        "author": "Ray Bradbury / 1952",
        "whyRead":
            "One small step in the past, one giant disaster in the future—Ray Bradbury’s A Sound of Thunder is a thrilling tale of time travel and its chilling consequences.",
        "sourceLink":
            "https://www.astro.sunysb.edu/fwalter/AST389/ASoundofThunder.pdf",
        "path": "assets/texts/A Sound of Thunder.txt",
        "cover": "assets/covers/Story/Story 13.png",
        "color": "blue",
        "banner": "assets/Banners/Story/Story 5.1.png",
        "category": "Stories",
        "stampKey": "butterfly"
      },
      {
        "title": "The nightingale and the rose",
        "author": "Oscar Wilde / 1888 [Ebook Released, 1997]",
        "whyRead":
            "A selfless bird, a red rose, and a heart that breaks—Oscar Wilde’s The Nightingale and the Rose weaves beauty and sorrow into a timeless tale of love and sacrifice.",
        "sourceLink":
            "https://www.gutenberg.org/cache/epub/902/pg902-images.html ",
        "path": "assets/texts/The Nightingale and the Rose.txt",
        "cover": "assets/covers/Story/Story 14.png",
        "color": "blue",
        "banner": "assets/Banners/Story/Story 5.2.png",
        "category": "Stories",
        "stampKey": "rose"
      },
      {
        "title": "The Spider",
        "author": "Hanns Heinz Ewers / 1915 [Ebook Released, 2006] ",
        "whyRead":
            "A mysterious room, sudden deaths, and a hypnotic woman—The Spider by Hanns Heinz Ewers lures you into a chilling web of suspense and obsession.",
        "sourceLink": "https://gutenberg.net.au/ebooks06/0605651.txt",
        "path": "assets/texts/The Spider.txt",
        "cover": "assets/covers/Story/Story 15.png",
        "color": "blue",
        "banner": "assets/Banners/Story/Story 5.3.png",
        "category": "Stories",
        "stampKey": "room #7"
      },
      {
        "title":
            "Cybersecurity and Data Science: The Role of Machine Learning in Cyber Threat Protection",
        "author":
            "Iqbal H. Sarker, A. S. M. Kayes, Shahriar Badsha, Hamed Alqahtani, Paul Watters, and Alex Ng / 2020",
        "whyRead":
            "This article provides an overview of how data science and machine learning are transforming cybersecurity, offering insights into developing intelligent, automated security systems.",
        "sourceLink":
            "https://link.springer.com/article/10.1186/s40537-020-00318-5 ",
        "path":
            "assets/texts/Cybersecurity and Data Science_ The Role of Machine Learning in Cyber Threat Protection.txt",
        "cover": "assets/covers/Article covers/Article 13.png",
        "color": "purple",
        "banner": "assets/Banners/Article/Article 5.1.png",
        "category": "Articles",
        "stampKey": "cybersecurity",
        "format": "APA",
      },
      {
        "title":
            "Media and Policy Making in the Digital Age: Challenges, Opportunities, and Transformations",
        "author": "Emiliano Grossman / 2022",
        "whyRead": "​In "
            "Media and Policy Making in the Digital Age,"
            "Emiliano Grossman examines how traditional and new media shape policy conflicts, highlighting the evolving media landscape's impact on governance. ",
        "sourceLink":
            "https://www.annualreviews.org/content/journals/10.1146/annurev-polisci-051120-103422",
        "path":
            "assets/texts/Media and Policy Making in the Digital Age_ Challenges, Opportunities, and Transformations.txt",
        "cover": "assets/covers/Article covers/Article 14.png",
        "color": "purple",
        "banner": "assets/Banners/Article/Article 5.2.png",
        "category": "Articles",
        "stampKey": "citizens",
        "format": "APA",
      },
      {
        "title":
            "The United Nations Sustainable Development Goals: A Comparative Analysis of Implementation",
        "author": "Shahryar Sorooshian / 2024",
        "whyRead":
            "This study evaluates the United Nations' Sustainable Development Goals (SDGs) by assessing their research-friendly characteristics, aiming to enhance their effectiveness in guiding global sustainability efforts. ​",
        "sourceLink":
            "https://www.sciencedirect.com/science/article/pii/S0959652624017207 ",
        "path":
            "assets/texts/The United Nations Sustainable Development Goals_ A Comparative Analysis of Implementation, Challenges, and Opportunities.txt",
        "cover": "assets/covers/Article covers/Article 15.png",
        "color": "purple",
        "banner": "assets/Banners/Article/Article 5.3.png",
        "category": "Articles",
        "stampKey": "International Cooperation",
        "format": "APA",
      },
    ];

    final String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      //aca va una appbar personalizada
      body: Stack(
        children: [
          // 1. Tu fondo original
          Positioned.fill(
            child: Image.asset(
              'assets/Wallpapers/Wallpaper  Library.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(255, 30, 79, 89).withOpacity(0.3),
            ),
          ),

          // 2. Contenido principal con StreamBuilder para el bloqueo
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('userProgress')
                .doc(uid)
                .snapshots(),
            builder: (context, snapshot) {
              final progressData =
                  snapshot.data?.data() as Map<String, dynamic>? ?? {};

              // Lógica de desbloqueo basada en tus campos de Firebase
              final bool isReferenceUnlocked = true;
              final bool isLexicalUnlocked =
                  progressData['completedCheckpoint1'] == true;
              final bool isExplanationUnlocked =
                  progressData['completedCheckpoint2'] == true;
              final bool isAssociationUnlocked =
                  progressData['completedCheckpoint3'] == true;
              final bool isPredictionUnlocked =
                  progressData['completedCheckpoint4'] == true;

              return ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  const SizedBox(height: 40),
                  // 4. Tus secciones de libros con la lógica de bloqueo aplicada
                  buildCollectionSection(
                      context,
                      'Reference Ranger Collection',
                      referenceBooks,
                      isReferenceUnlocked,
                      "Completa el inicio para desbloquear"),
                  buildCollectionSection(
                      context,
                      'Lexical Linker Collection',
                      lexicalBooks,
                      isLexicalUnlocked,
                      "You need to complete the first Checkpoint "),
                  buildCollectionSection(
                      context,
                      'Explanation Expert Collection',
                      explanationBooks,
                      isExplanationUnlocked,
                      "You need to complete the second Checkpoint"),
                  buildCollectionSection(
                      context,
                      'Association Architect Collection',
                      associationBooks,
                      isAssociationUnlocked,
                      "You need to complete the third Checkpoint"),
                  buildCollectionSection(
                      context,
                      'Prediction Pioner Collection',
                      predictionBooks,
                      isPredictionUnlocked,
                      "You need to complete the fourth Checkpoint"),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

// Función buildCollectionSection actualizada para manejar el bloqueo
  Widget buildCollectionSection(BuildContext context, String title,
      List<Map<String, dynamic>> books, bool isUnlocked, String lockMessage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 47, 61, 69).withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // Icono de candado si está bloqueado
            if (!isUnlocked) ...[
              const SizedBox(width: 10),
              const Icon(Icons.lock,
                  color: Color.fromARGB(255, 30, 74, 89), size: 22),
            ]
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: isUnlocked
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookDetailPage(book: book),
                            ),
                          );
                        }
                      : () {
                          // Mensaje si intenta entrar a algo bloqueado
                          showLockCard(context, "🔒 $lockMessage");
                        },
                  child: Opacity(
                    opacity: isUnlocked
                        ? 1.0
                        : 0.5, // Opacidad reducida si está bloqueado
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: isUnlocked ? 5 : 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AspectRatio(
                          aspectRatio: 0.92,
                          child: ColorFiltered(
                            colorFilter: isUnlocked
                                ? const ColorFilter.mode(
                                    Colors.transparent, BlendMode.multiply)
                                : const ColorFilter.mode(
                                    Colors.grey,
                                    BlendMode
                                        .saturation), // Blanco y negro si está bloqueado
                            child: Image.asset(
                              book["cover"]!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class BookDetailPage extends StatelessWidget {
  final Map<String, dynamic> book;

  const BookDetailPage({super.key, required this.book});

  Color getBookColor(String? colorName) {
    switch (colorName?.toLowerCase()) {
      case 'green':
        return const Color.fromARGB(255, 21, 147, 23); // Ocurecer los colores
      case 'purple':
        return Colors.purple; // Menos el morado
      case 'yellow':
        return const Color.fromARGB(255, 243, 196, 42);
      case 'blue':
        return const Color.fromARGB(255, 12, 136, 193);
      default:
        return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = getBookColor(book["color"]);

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Banner con X encima
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                            child: Image.asset(
                              book["banner"] ?? book["cover"]!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 190,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book["title"] ?? '',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              book["author"] ?? '',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "  ${book["year"] ?? ''}",
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              "Adapted by",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                            const Text(
                              "Kevin Atencia • 2025",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Why read it?",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              book["whyRead"] ?? '',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Source:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                final url = book["sourceLink"];
                                if (url != null) {
                                  launchUrl(Uri.parse(url));
                                }
                              },
                              child: Text(
                                book["sourceLink"] ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 12,
                                  ),
                                  elevation: 5,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => TxtReaderPage(
                                        bookTitle: book["title"] ?? '',
                                        txtPath: book["path"] ?? '',
                                        category:
                                            normalizeCategory(book["category"]),
                                        stampKey: book["stampKey"] ?? '',
                                        format: book["format"],
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "READ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showLockCard(BuildContext context, String lockMessage) {
  final overlay = Overlay.of(context);
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (context) => Positioned(
      top: 70,
      left: 20,
      right: 20,
      child: _LockOverlayCard(
        message: lockMessage,
        onFinish: () => entry.remove(),
      ),
    ),
  );

  overlay.insert(entry);
}

class _LockOverlayCard extends StatefulWidget {
  final String message;
  final VoidCallback onFinish;

  const _LockOverlayCard({
    required this.message,
    required this.onFinish,
  });

  @override
  State<_LockOverlayCard> createState() => _LockOverlayCardState();
}

class _LockOverlayCardState extends State<_LockOverlayCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, -0.10),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      _controller.reverse();
      Future.delayed(const Duration(milliseconds: 260), widget.onFinish);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 30, 79, 89),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.lock_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}