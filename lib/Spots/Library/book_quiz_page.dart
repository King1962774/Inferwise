// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:math';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  DATA MODEL
// ─────────────────────────────────────────────

class BookQuizData {
  final String bookTitle;
  final String thinkAbout;
  final String question;
  final List<String> options; // A, B, C, D
  final int correctIndex; // 0-based
  final String explanation; // shown after 2 attempts
  final String wrongExplanation; // shown as feedback when wrong

  const BookQuizData({
    required this.bookTitle,
    required this.thinkAbout,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.wrongExplanation,
  });
}

// ─────────────────────────────────────────────
//  QUIZ DATA PER BOOK  (add yours here)
// ─────────────────────────────────────────────

// ── Const quiz data for entries 25–36 (multi-key lookup support) ──────────
const BookQuizData _q25 = BookQuizData(
  bookTitle: "Alexander Graham Bell And The Telephone",
  thinkAbout:
      "The text shows that Bell's invention of the telephone depended not only on his ideas, but also on support, competition, and public acceptance.",
  question:
      "Which option gives the best critical interpretation of the text?",
  options: [
    "New inventions need social and historical support to succeed.",
    "Bell succeeded only because he was a genius.",
    "People accepted the telephone immediately.",
    "Scientific discoveries happen by accident.",
  ],
  correctIndex: 0,
  explanation:
      "This option recognizes that Bell's success depended on more than talent. Public support, business organization, and historical circumstances also helped the telephone become successful.",
  wrongExplanation:
      "B, C, and D are incorrect:\n\nThey oversimplify the invention process and ignore the social and historical factors described in the text.",
);

const BookQuizData _q26 = BookQuizData(
  bookTitle: "Life and Times of Mandela",
  thinkAbout:
      "The text presents Mandela not only as an individual leader, but also as part of a broader struggle against apartheid and injustice.",
  question:
      "Which option gives the best critical interpretation of the text?",
  options: [
    "Mandela achieved freedom for South Africa completely alone.",
    "Political change depends only on strong individual leaders.",
    "Social transformation requires both personal sacrifice and collective action.",
    "Apartheid ended quickly once Mandela was released from prison.",
  ],
  correctIndex: 2,
  explanation:
      "This option recognizes that Mandela's role was important, but also connected to the collective struggle, sacrifices, and efforts of many people against apartheid.",
  wrongExplanation:
      "A, B, and D are incorrect:\n\nThey over-reduce the historical process and ignore the broader political and social movement described in the text.",
);

const BookQuizData _q27 = BookQuizData(
  bookTitle: "Girls Who Became Famous: Florence Nightingale",
  thinkAbout:
      "The text presents Florence Nightingale as someone who used her education, privilege, and determination to improve healthcare and help others.",
  question:
      "Which option gives the best critical interpretation of the text?",
  options: [
    "Florence became famous only because she came from a rich family.",
    "Nursing during the war was easy once Florence arrived.",
    "Social change can happen when people use their advantages to serve others.",
    "People immediately accepted women working in hospitals.",
  ],
  correctIndex: 2,
  explanation:
      "This option recognizes that Florence Nightingale used her education, social position, and dedication to improve hospitals and nursing care for many people.",
  wrongExplanation:
      "A, B, and D are incorrect:\n\nThey oversimplify her achievements and ignore the challenges, resistance, and hard work described in the text.",
);

const BookQuizData _q28 = BookQuizData(
  bookTitle: "AI Chatbot Deployed to Target Drug Resistance",
  thinkAbout:
      "The text explains that AI tools can help governments fight antimicrobial resistance by organizing global health information, but their effectiveness depends on the quality and diversity of the data they use.",
  question:
      "Why could AI chatbots be both valuable and challenging for Colombia in addressing antimicrobial resistance?",
  options: [
    "AI would completely solve Colombia's healthcare inequalities without human intervention.",
    "Colombia does not need AI because antimicrobial resistance only affects richer countries.",
    "AI can improve health decisions in Colombia, but it depends on accurate local data and healthcare access.",
    "Antimicrobial resistance in Colombia is caused only by technology problems.",
  ],
  correctIndex: 2,
  explanation:
      "This option critically recognizes that AI may strengthen healthcare planning and access to information in Colombia, but its success depends on reliable national data, public health systems, and equal access to healthcare resources.",
  wrongExplanation:
      "A, B, and D are incorrect:\n\nThey overgeneralize the healthcare challenges described in the text and ignore the importance of data quality and social conditions.",
);

const BookQuizData _q29 = BookQuizData(
  bookTitle: "Polio Survivors Face Biggest Fight of Their Lives",
  thinkAbout:
      "The text explains that although polio vaccination has succeeded globally, many survivors still face neglected long-term health issues — challenges that worsen in Colombia due to unequal access to rehabilitation and specialized care between urban and rural areas.",
  question:
      "Why would supporting polio survivors be an important public health issue in countries like Colombia?",
  options: [
    "Polio is no longer a problem because vaccines completely removed all its effects.",
    "Even after polio outbreaks decline, survivors often need ongoing support for lasting health and mobility challenges.",
    "Rehabilitation and long-term care are unnecessary once a person survives polio.",
    "The only solution for polio survivors is developing stronger vaccines.",
  ],
  correctIndex: 1,
  explanation:
      "This option critically recognizes that eliminating the disease does not eliminate its long-term consequences. Polio survivors may still need rehabilitation, accessibility, medical care, and social support for many years.",
  wrongExplanation:
      "A, C, and D are incorrect:\n\nThey oversimplify the issue and ignore the long-term physical and social challenges discussed in the text.",
);

const BookQuizData _q30 = BookQuizData(
  bookTitle: "In Venezuela, Theater is also Part of the Resistance",
  thinkAbout:
      "The text explains that, in Venezuela, theater continues despite political and economic crises. For many artists, theater is not only entertainment, but also a way to express emotions, reflect society, and resist difficult realities.",
  question:
      "Why can theater and artistic expression play an important role in Colombian society during times of conflict or crisis?",
  options: [
    "Art is only valuable when it produces economic benefits for the country.",
    "Theater has no real connection to social or political realities.",
    "Artists continue creating mainly because crises make audiences larger.",
    "Art can help Colombians reflect on social issues, preserve memories, and encourage critical dialogue.",
  ],
  correctIndex: 3,
  explanation:
      "This option critically recognizes that, in contexts like Colombia, art and theater can help people process social realities, express resistance, and promote awareness and reflection about conflict and inequality.",
  wrongExplanation:
      "A, B, and C are incorrect:\n\nThey over-reduce the purpose of art and ignore its social, emotional, and cultural importance during difficult historical moments.",
);

const BookQuizData _q31 = BookQuizData(
  bookTitle: "The Plutonian Drug",
  thinkAbout:
      "The story explores how scientific discoveries can offer great possibilities, but also create dangers that humans may not fully understand or control.",
  question:
      "Which option gives the best critical interpretation of the text?",
  options: [
    "Scientific discoveries are always beneficial for humanity.",
    "People should avoid all scientific experimentation.",
    "Knowledge and technology can become dangerous when their consequences are uncertain.",
    "Balcoth died only because he ignored Dr. Manners' advice.",
  ],
  correctIndex: 2,
  explanation:
      "This option recognizes that the story questions the risks of scientific discoveries that humans may use without fully understanding their effects or consequences.",
  wrongExplanation:
      "A, B, and D are incorrect:\n\nThey oversimplify the story and ignore its deeper reflection on science, knowledge, and human responsibility.",
);

const BookQuizData _q32 = BookQuizData(
  bookTitle: "Sweat",
  thinkAbout:
      "The story shows Delia's hard work and suffering in an abusive marriage, while also revealing issues of power, gender, and justice.",
  question:
      "Which option gives the best critical interpretation of the story?",
  options: [
    "Delia's problems exist only because she is poor.",
    "Abuse and oppression can eventually lead to resistance and justice.",
    "Sykes is portrayed as a completely misunderstood character.",
    "Hard work always guarantees happiness and respect.",
  ],
  correctIndex: 1,
  explanation:
      "This option recognizes that the story explores abuse, inequality, and the way Delia gradually gains strength against oppression.",
  wrongExplanation:
      "A, C, and D are incorrect:\n\nThey misrepresent the conflict and ignore the social and moral themes developed throughout the story.",
);

const BookQuizData _q33 = BookQuizData(
  bookTitle: "The Outsider",
  thinkAbout:
      "The story explores loneliness, identity, and the fear of discovering one's true self.",
  question:
      "Which option gives the best critical interpretation of the story?",
  options: [
    "The narrator's suffering comes only from living in a castle.",
    "The narrator becomes happy after discovering the truth immediately.",
    "The people at the party are evil because they reject the narrator.",
    "The story suggests that fear often comes from self-discovery and isolation.",
  ],
  correctIndex: 3,
  explanation:
      "This option recognizes that the story focuses on isolation, identity, and the horror of realizing the truth about oneself.",
  wrongExplanation:
      "A, B, and C are incorrect:\n\nThey oversimplify the story and ignore its psychological and symbolic themes.",
);

const BookQuizData _q34 = BookQuizData(
  bookTitle: "Advancements in 3D Bioprinting: A New Era in Tissue Engineering",
  thinkAbout:
      "The text explains that 3D bioprinting could revolutionize healthcare by creating tissues and organs. In Colombia, it offers hope to reduce unequal access to transplants, but also raises ethical and economic challenges.",
  question:
      "Why could 3D bioprinting represent both an opportunity and a challenge for Colombia's healthcare system?",
  options: [
    "3D bioprinting will immediately eliminate all medical problems and organ shortages.",
    "Colombia should avoid bioprinting because all new medical technologies are dangerous.",
    "Bioprinting could help, but costs, regulation, and unequal access remain major hurdles.",
    "The technology is useful only for scientists and has no impact on patients or hospitals.",
  ],
  correctIndex: 2,
  explanation:
      "This option critically recognizes that 3D bioprinting may improve healthcare and regenerative medicine in Colombia, but social, ethical, and economic barriers could limit equal access to these advances.",
  wrongExplanation:
      "A, B, and D are incorrect:\n\nThey overgeneralize the technology and ignore the medical, ethical, and accessibility issues discussed in the text.",
);

const BookQuizData _q35 = BookQuizData(
  bookTitle: "Communication Strategies for Dementia Care: A New Perspective on Caregiving",
  thinkAbout:
      "The text explains that dementia changes communication, but emotional connection remains possible through non-verbal cues, music, touch, and memories. In Colombia, these strategies can help family caregivers, though limited resources and caregiver stress are major challenges.",
  question:
      "Why are alternative communication strategies important in dementia care in Colombia?",
  options: [
    "People with dementia completely lose the ability to feel emotions.",
    "Only medication matters for dementia care — emotional interaction has no real effect.",
    "Non-verbal communication, sensory activities, and shared memories can improve emotional connection and quality of life for dementia patients.",
    "Colombian families should avoid caring for relatives with dementia because institutions are always better.",
  ],
  correctIndex: 2,
  explanation:
      "This option recognizes that emotional connection can still exist even when verbal communication declines.",
  wrongExplanation:
      "A, B, and D are incorrect:\n\nThey ignore the emotional and social aspects of dementia care discussed in the text.",
);

const BookQuizData _q36 = BookQuizData(
  bookTitle: "Bamboo as a Sustainable Building Material for Innovative, Low-Cost Housing Construction",
  thinkAbout:
      "The text explains that bamboo can provide affordable and sustainable housing, especially in countries like Colombia where it is widely available. However, challenges such as building regulations, durability, and professional training still affect its large-scale use.",
  question:
      "Why could bamboo construction be both beneficial and challenging for Colombia?",
  options: [
    "Bamboo solves all housing and environmental problems immediately.",
    "Bamboo can support affordable, sustainable housing, but there are still durability issues.",
    "Colombia should avoid bamboo because modern materials are always better.",
    "Bamboo is only useful for temporary rural houses.",
  ],
  correctIndex: 1,
  explanation:
      "This option recognizes both the environmental and economic advantages of bamboo, while also acknowledging the technical and regulatory challenges discussed in the text.",
  wrongExplanation:
      "A, C, and D are incorrect:\n\nThey ignore the complexity and potential of bamboo construction presented in the article.",
);


// ── Const quiz data for entries 37–48 (multi-key lookup support) ──────────

// 37 – Biography
const BookQuizData _q37 = BookQuizData(
  bookTitle: "The Wright Brothers' Aeroplane",
  thinkAbout:
      "The text presents the Wright brothers as persistent inventors who combined experimentation, technical observation, and scientific skepticism to achieve powered flight. It emphasizes how they questioned accepted scientific knowledge, learned from failure, and developed their own methods through repeated testing.",
  question:
      "Which option offers the most critical interpretation of the text?",
  options: [
    "Scientific progress depends mainly on natural talent and inspiration.",
    "Earlier scientists and inventors contributed very little to aviation development.",
    "The invention of the airplane happened quickly once people believed in flying.",
    "Technological innovation advances through experimentation and by challenging established knowledge.",
  ],
  correctIndex: 3,
  explanation:
      "This option critically recognizes that technological progress depends on experimentation and questioning accepted knowledge, not only on talent or inspiration.",
  wrongExplanation:
      "A, B, and C are incorrect:\n\nThey oversimplify scientific innovation and ignore the complex process of research, failure, and collaboration presented in the text.",
);

// 38 – Biography
const BookQuizData _q38 = BookQuizData(
  bookTitle: "Lives of Poor Boys Who Became Famous: Abraham Lincoln",
  thinkAbout:
      "The text presents Abraham Lincoln as a self-educated boy who rose from poverty to become President of the United States. However, beyond celebrating his personal determination, the biography also connects his life to larger historical conflicts such as slavery, war, inequality, and national division.",
  question:
      "Which option offers the most critical interpretation of the text?",
  options: [
    "Lincoln's success proves that anyone can easily overcome poverty through hard work alone.",
    "The text suggests that great leaders are naturally born superior to others.",
    "Lincoln's story reflects both individual perseverance and the influence of historical and social conditions.",
    "The biography mainly argues that suffering automatically creates moral greatness.",
  ],
  correctIndex: 2,
  explanation:
      "This option critically recognizes that the text presents Lincoln's success not simply as personal achievement, but as the result of perseverance, moral growth, historical circumstances, and social struggles.",
  wrongExplanation:
      "A, B, and D are incorrect:\n\nThey oversimplify Lincoln's life by ignoring the role of hardship, political conflict, and the historical realities surrounding slavery, war, and leadership.",
);

// 39 – Biography
const BookQuizData _q39 = BookQuizData(
  bookTitle: "Memoir of Jane Austen: Fragment",
  thinkAbout:
      "The text presents Jane Austen as a quiet and modest woman who lived mostly within her family circle and was not famous during her lifetime. However, the memoir also suggests that her literary success was shaped by her social environment, family relationships, and careful observation of everyday life.",
  question:
      "Which option offers the most critical interpretation of the text?",
  options: [
    "Literary genius develops completely independently from society and family.",
    "Austen's writing emerged from close observation of her social world and relationships.",
    "Fame is the most important goal for writers.",
    "Austen's novels are direct copies of her life without artistic transformation.",
  ],
  correctIndex: 1,
  explanation:
      "This option critically recognizes that the memoir connects Austen's writing to her family life, social environment, and careful observation of human behavior.",
  wrongExplanation:
      "A, C, and D are incorrect:\n\nThey oversimplify the memoir and ignore its emphasis on Austen's creativity, social context, and artistic interpretation of reality.",
);

// 40 – News
const BookQuizData _q40 = BookQuizData(
  bookTitle: "Indigenous People Raise Voices to Avert Amazon Tipping Point",
  thinkAbout:
      "The text explains that protecting the Amazon requires more than advanced technology. Indigenous communities argue that monitoring systems and environmental policies only work when local people have resources, participation, and decision-making power.",
  question:
      "Why is protecting the Colombian Amazon both a technological and social challenge?",
  options: [
    "Satellite technology alone can stop deforestation without Indigenous involvement.",
    "Amazon protection only needs stricter punishments for illegal logging.",
    "Indigenous communities should adapt to outside conservation plans even if excluded from decisions.",
    "Conservation tools help protect the Amazon only when local communities get support, resources, and political recognition.",
  ],
  correctIndex: 3,
  explanation:
      "This option critically recognizes that environmental protection depends not only on scientific innovation, but also on including Indigenous communities in decision-making, funding, and territorial protection.",
  wrongExplanation:
      "A, B, and C are incorrect:\n\nThey simplify the causes of deforestation and overlook the social inequalities, lack of infrastructure, and exclusion faced by Indigenous communities in the Amazon.",
);

// 41 – News
const BookQuizData _q41 = BookQuizData(
  bookTitle: "Syrians Turn War Missiles into Heaters as Winter Grips",
  thinkAbout:
      "The text shows how families affected by war and poverty adapt creatively to survive, even when those solutions are dangerous. Turning missiles into heaters reflects both human resilience and the severe consequences of conflict, inequality, and lack of humanitarian support.",
  question:
      "In vulnerable communities in Colombia affected by displacement, poverty, or armed conflict, what broader issue does this story help reveal?",
  options: [
    "People in crisis choose risky heating methods because they prefer cheaper options.",
    "Health and environmental problems in conflict zones come mainly from individual choices, not structural conditions.",
    "Humanitarian aid is unnecessary — local communities can always adapt alone.",
    "Extreme poverty leads to survival strategies that solve immediate needs but raise long-term health risks.",
  ],
  correctIndex: 3,
  explanation:
      "This option critically recognizes that communities under conditions of violence and poverty may develop creative forms of survival, but these often emerge from structural inequality and can create serious health consequences.",
  wrongExplanation:
      "A, B, and C are incorrect:\n\nThey oversimplify the social, economic, and humanitarian challenges presented in the text.",
);

// 42 – News
const BookQuizData _q42 = BookQuizData(
  bookTitle: "Brazilian Graffiti Artists and Young Syrians Are Painting Refugee Camp Walls Together",
  thinkAbout:
      "The text explains that graffiti and collaborative art projects in refugee camps are not only decorative. They can provide emotional support, strengthen identity, give young people a voice, and create spaces of hope in contexts marked by violence, displacement, and uncertainty.",
  question:
      "In the context of refugee and displaced communities in Colombia, why could community art projects become an important form of resistance and recovery?",
  options: [
    "Graffiti only briefly entertains children and has no deeper social impact.",
    "Art helps displaced communities express trauma, rebuild bonds, and gain visibility.",
    "Refugee camps should focus only on survival — art has little crisis value.",
    "Graffiti works only if it avoids politics, emotion, displacement, or violence.",
  ],
  correctIndex: 1,
  explanation:
      "This option critically recognizes that art in contexts of displacement can function as emotional healing, social visibility, and collective resistance, especially for communities affected by violence and exclusion.",
  wrongExplanation:
      "A, C, and D are incorrect:\n\nThey minimize the social, emotional, and political role of artistic expression described in the text.",
);

// 43 – Stories
const BookQuizData _q43 = BookQuizData(
  bookTitle: "2BR02B",
  thinkAbout:
      "The story describes a society with no poverty, disease, or war, but this 'perfect' system depends on strict population control and voluntary death. Through characters like Wehling and the painter, the text questions whether stability and efficiency can justify sacrificing individual freedom and human emotions.",
  question:
      "Which option offers the most critical interpretation of the story?",
  options: [
    "Social stability may come at the cost of human dignity and personal choice.",
    "Scientific progress guarantees moral progress and happiness for everyone.",
    "A perfect society can only exist when people completely obey the government.",
    "Population growth is the only problem modern societies should worry about.",
  ],
  correctIndex: 0,
  explanation:
      "This option critically recognizes that the story questions the ethical consequences of creating a 'perfect' society through control over life and death. It highlights the tension between collective stability and individual humanity.",
  wrongExplanation:
      "B, C, and D are incorrect:\n\nThey reduce the story to simplistic conclusions and ignore the moral, emotional, and ethical conflicts presented throughout the narrative.",
);

// 44 – Stories
const BookQuizData _q44 = BookQuizData(
  bookTitle: "The Pearl of Love",
  thinkAbout:
      "The story begins as a tale of deep love and devotion, but as the prince dedicates his life to creating the perfect monument, his artistic vision gradually becomes more important than the memory of the queen herself.",
  question:
      "Which option offers the most critical interpretation of the story?",
  options: [
    "True love can only be expressed through grand monuments and wealth.",
    "Artistic ambition may eventually replace the human emotions that inspired it.",
    "The prince stops loving the queen because he becomes interested in architecture.",
    "Beauty is always more valuable than memory or human relationships.",
  ],
  correctIndex: 1,
  explanation:
      "This option critically recognizes that the prince's obsession with perfection transforms the Pearl of Love from a symbol of devotion into an artistic project disconnected from the queen herself.",
  wrongExplanation:
      "A, C, and D are incorrect:\n\nThey oversimplify the prince's emotional transformation and ignore the story's critique of how artistic ambition can distance people from the original meaning of their emotions.",
);

// 45 – Stories
const BookQuizData _q45 = BookQuizData(
  bookTitle: "The Yellow Wall-Paper",
  thinkAbout:
      "The story shows a woman isolated in a room while her husband and doctors dismiss her thoughts and emotions as signs of illness. As her isolation increases, she becomes obsessed with the yellow wallpaper and gradually loses touch with reality.",
  question:
      "Which option offers the most critical interpretation of the story?",
  options: [
    "The story criticizes how women's voices and emotional experiences are controlled and ignored.",
    "Mental illness can be solved if patients simply obey medical authority.",
    "The narrator's condition only worsens because she spends too much time alone.",
    "The wallpaper itself is the direct cause of the narrator's madness.",
  ],
  correctIndex: 0,
  explanation:
      "This option critically recognizes that the story questions the patriarchal and medical systems that silence the narrator and deny her autonomy. Her psychological decline is connected not only to illness, but also to oppression and isolation.",
  wrongExplanation:
      "B, C, and D are incorrect:\n\nThey reduce the complexity of the narrator's experience and ignore the social and gender-based criticism developed throughout the story.",
);

// 46 – Articles
const BookQuizData _q46 = BookQuizData(
  bookTitle: "The Evolution of Mars Water-Ice Detection Research (1990–2024)",
  thinkAbout:
      "The text explains that decades of tech innovation — radar, spectrometers, rovers, and machine learning — have advanced the search for water ice on Mars. This matters for science and human exploration, since water ice could supply drinking water, oxygen, and fuel.",
  question:
      "Why could research on Martian water ice be especially valuable for a country like Colombia?",
  options: [
    "Colombia could use Mars ice immediately to solve water shortages on Earth.",
    "Space research only benefits countries that already have large space agencies like NASA.",
    "Planetary science advances can inspire Colombia's scientific growth, tech innovation, and international collaboration.",
    "The only purpose of studying Mars is to prove that humans can live there permanently.",
  ],
  correctIndex: 2,
  explanation:
      "This option critically recognizes that space exploration drives scientific knowledge, technological progress, and global cooperation, which can benefit emerging research communities like those in Colombia.",
  wrongExplanation:
      "A, B, and D are incorrect:\n\nThey misrepresent the broader scientific and technological importance of Mars research discussed in the text.",
);

// 47 – Articles
const BookQuizData _q47 = BookQuizData(
  bookTitle: "Burnout and Depression in College Students",
  thinkAbout:
      "The study explains that burnout and depression are related but different: burnout stems from academic stress and cynicism, while depression involves hopelessness and loss of interest. Universities should address both academic pressure and emotional well-being to support students.",
  question:
      "Why is addressing student mental health in Colombian universities both necessary and complex?",
  options: [
    "Burnout and depression are exactly the same condition, so one solution works for both.",
    "Academic stress only affects grades and has little impact on emotional well-being.",
    "Universities must reduce academic stress and recognize emotional symptoms that may require different forms of support.",
    "Student burnout can only be solved if students stop studying and avoid academic responsibilities.",
  ],
  correctIndex: 2,
  explanation:
      "This option critically recognizes that burnout and depression are connected, meaning universities need strategies that support both academic engagement and emotional health.",
  wrongExplanation:
      "A, B, and D are incorrect:\n\nThey reduce the complexity of student mental health and ignore the different causes and symptoms discussed in the study.",
);

// 48 – Articles
const BookQuizData _q48 = BookQuizData(
  bookTitle: "The Impact of Environmental Pollution on the Sustainability of Architectural Heritage: The Case of Cartagena de Indias",
  thinkAbout:
      "The text explains that pollution, humidity, and biological growth are damaging Cartagena's historic buildings, threatening both cultural heritage and tourism-based economies.",
  question:
      "Why would protecting architectural heritage in cities like Bogotá be important and challenging?",
  options: [
    "Historic buildings are not affected by pollution or urban growth.",
    "Heritage conservation only benefits tourists and private companies, not local communities.",
    "Old buildings should always be replaced with modern construction.",
    "Architectural heritage conservation protects culture and local economies, but needs investment and long-term planning.",
  ],
  correctIndex: 3,
  explanation:
      "This option recognizes that heritage preservation supports culture, tourism, and local communities, while also acknowledging the environmental and economic challenges involved.",
  wrongExplanation:
      "A, B, and C are incorrect:\n\nThey ignore the environmental, social, and economic impacts discussed in the text.",
);

// ── Const quiz data for entries 49–60 (multi-key lookup support) ──────────

// 49 – Biography
const BookQuizData _q49 = BookQuizData(
  bookTitle: "Giuseppina Cattani, the Unknown Co-Discoverer of the Antitetanus Serum",
  thinkAbout:
      "The text shows that Giuseppina Cattani made important scientific contributions, but she still struggled to receive recognition because she was a woman in the 19th century.",
  question:
      "Which option offers the most critical interpretation of the text?",
  options: [
    "Talent always guarantees recognition in science.",
    "Scientific progress depends only on intelligence.",
    "Social and gender barriers can affect scientific recognition.",
    "Women scientists in the 19th century had the same opportunities as men.",
  ],
  correctIndex: 2,
  explanation:
      "This option recognizes that scientific recognition is shaped not only by talent, but also by social and gender barriers.",
  wrongExplanation:
      "A, B, and D are incorrect:\n\nThey ignore the discrimination and unequal opportunities described in the text.",
);

// 50 – Biography
const BookQuizData _q50 = BookQuizData(
  bookTitle: "The Story of Joan of Arc: Chapters I - II",
  thinkAbout:
      "The text presents Joan of Arc as a brave and deeply religious young woman who became a symbol of hope for France during a time of war and suffering. It also shows how people interpreted her actions and visions as part of a divine mission.",
  question:
      "Which option offers the most critical interpretation of the text?",
  options: [
    "Joan's success was caused only by her supernatural visions.",
    "The text suggests that religion and national crisis influenced how Joan was viewed.",
    "Medieval societies always gave women equal opportunities to lead.",
    "France's problems were solved only because of military strength.",
  ],
  correctIndex: 1,
  explanation:
      "This option recognizes that Joan's image and influence were shaped by both religious beliefs and the political crisis in France.",
  wrongExplanation:
      "A, C, and D are incorrect:\n\nThey oversimplify the historical, social, and religious context presented in the text.",
);

// 51 – Biography
const BookQuizData _q51 = BookQuizData(
  bookTitle: "Famous Men of Ancient Times: Socrates",
  thinkAbout:
      "The text presents Socrates as a philosopher who valued truth, morality, and critical thinking, even when his ideas made powerful people uncomfortable. It also shows how society reacted to ideas that challenged traditional beliefs.",
  question:
      "Which option offers the most critical interpretation of the text?",
  options: [
    "The text suggests that societies may reject ideas that challenge established beliefs and authority.",
    "Socrates was condemned only because he disliked religion.",
    "Philosophers are always respected for their wisdom.",
    "Socrates believed avoiding death was more important than defending principles.",
  ],
  correctIndex: 0,
  explanation:
      "This option recognizes that Socrates's trial reflected social and political tensions caused by his questioning of traditional beliefs and authority.",
  wrongExplanation:
      "B, C, and D are incorrect:\n\nThey over-reduce the reasons for his condemnation and ignore the broader social and philosophical conflict described in the text.",
);

// 52 – News
const BookQuizData _q52 = BookQuizData(
  bookTitle: "Will the US Get to Mars Quicker if it Drops or Delays Plans to Visit the Moon",
  thinkAbout:
      "The text discusses the trade-off between prioritizing Moon exploration (Artemis and Lunar Gateway) and focusing directly on Mars missions. It highlights technical, logistical, and political factors that influence space exploration strategies.",
  question:
      "Which option offers the most critical interpretation of the text?",
  options: [
    "Mars missions are easy and can replace all lunar exploration immediately.",
    "Private companies always make safer and more reliable space decisions than governments.",
    "Space exploration decisions depend on balancing political influence, funding, and technical constraints.",
    "The Moon has no value for future space exploration compared to Mars.",
  ],
  correctIndex: 2,
  explanation:
      "This option recognizes that space exploration is shaped by a mix of political decisions, funding priorities, and engineering limitations, not just a single goal or actor.",
  wrongExplanation:
      "A, B, and D are incorrect:\n\nThey oversimplify the complex relationship between lunar and Martian exploration described in the text.",
);

// 53 – News
const BookQuizData _q53 = BookQuizData(
  bookTitle: "The Urgent Mental Health Needs of Young People",
  thinkAbout:
      "The text argues that youth mental health in Canada is worsening due to global megatrends like inequality, climate change, and colonial history, and that improving it requires both better services and broader social and political change.",
  question:
      "Which option offers the most critical interpretation of the text?",
  options: [
    "Youth mental health problems can be solved only by increasing hospital services.",
    "Mental health issues in young people are caused only by individual choices and behavior.",
    "Canada has already fully solved its youth mental health crisis through existing programs.",
    "Youth mental health is shaped by both healthcare systems and wider social, political, and economic conditions.",
  ],
  correctIndex: 3,
  explanation:
      "This option recognizes that youth mental health is influenced not only by access to services, but also by broader structural factors like inequality, climate change, and colonial history.",
  wrongExplanation:
      "A, B, and C are incorrect:\n\nThey ignore the broader systemic, social, and political factors emphasized in the text.",
);

// 54 – News
const BookQuizData _q54 = BookQuizData(
  bookTitle: "A Central African Designer is Transforming Sneakers into Portable Manga in Senegal",
  thinkAbout:
      "The text presents a young Central African designer who turns manga-inspired art into customized products, showing how global pop culture, social media, and local economic conditions combine to create new entrepreneurial opportunities.",
  question:
      "Which option offers the most critical interpretation of the text?",
  options: [
    "Success in creative industries depends only on artistic talent.",
    "Manga culture has replaced all traditional African art forms.",
    "Social media guarantees financial success for all artists.",
    "Global media, local economic conditions, and social networks shape new forms of entrepreneurship.",
  ],
  correctIndex: 3,
  explanation:
      "This option recognizes that the designer's work is shaped by a combination of global cultural influences, economic constraints, and digital platforms.",
  wrongExplanation:
      "A, B, and C are incorrect:\n\nThey overgeneralize how creative work and entrepreneurial success develop in real-world social and economic contexts.",
);

// 55 – Stories
const BookQuizData _q55 = BookQuizData(
  bookTitle: "A Sound of Thunder",
  thinkAbout:
      "The text presents A Sound of Thunder as a science fiction story that explores time travel and its consequences, especially how small actions in the past can have unexpected and large effects on the future.",
  question:
      "Which option offers the most critical interpretation of the text?",
  options: [
    "Time travel is completely safe and has no consequences for the present.",
    "The past cannot be changed under any circumstances.",
    "Small changes in the past can produce major and unpredictable consequences in the future.",
    "Science fiction stories are only meant to entertain and have no deeper meaning.",
  ],
  correctIndex: 2,
  explanation:
      "This option recognizes the story's central idea about the butterfly effect and how minor disruptions in time can lead to significant changes in history.",
  wrongExplanation:
      "A, B, and D are incorrect:\n\nThey ignore the story's exploration of cause, effect, and the fragility of historical outcomes.",
);

// 56 – Stories
const BookQuizData _q56 = BookQuizData(
  bookTitle: "The Nightingale and the Rose",
  thinkAbout:
      "The text presents The Nightingale and the Rose as a story in which love, sacrifice, and human values are contrasted with selfishness and materialism, leading to a tragic outcome shaped by misunderstanding and indifference.",
  question:
      "Which option offers the most critical interpretation of the text?",
  options: [
    "True love is always rewarded in life.",
    "Human relationships and values are often distorted by selfishness and material concerns.",
    "The story suggests that beauty and poetry are more important than human relationships.",
    "Sacrifice always guarantees happiness for everyone involved.",
  ],
  correctIndex: 1,
  explanation:
      "This option recognizes that the story critiques how selfishness and materialism can distort love and lead to tragic consequences.",
  wrongExplanation:
      "A, C, and D are incorrect:\n\nThey oversimplify the story's message and ignore its critique of emotional indifference and material priorities.",
);

// 57 – Stories
const BookQuizData _q57 = BookQuizData(
  bookTitle: "The Spider",
  thinkAbout:
      "The text presents The Spider as a psychological horror story in which repeated unexplained deaths suggest a mysterious, possibly supernatural influence that seems to manipulate human perception, fear, and behavior, blurring the line between reality and illusion.",
  question:
      "Which option offers the most critical interpretation of the text?",
  options: [
    "The suicides are caused only by a physically dangerous spider species.",
    "Human behavior is always rational and unaffected by suggestion or fear.",
    "Fear, suggestion, and psychological manipulation can shape perception and lead to destructive outcomes.",
    "The story shows that hotels in Paris are inherently dangerous places.",
  ],
  correctIndex: 2,
  explanation:
      "This option recognizes that the story explores how fear and psychological influence — rather than a simple physical cause — can distort perception and drive individuals toward tragic actions.",
  wrongExplanation:
      "A, B, and D are incorrect:\n\nThey reduce the story to a literal or overly simplistic explanation and ignore its focus on psychological tension and the power of suggestion.",
);

// 58 – Articles
const BookQuizData _q58 = BookQuizData(
  bookTitle: "Cybersecurity and Data Science: The Role of Machine Learning in Cyber Threat Protection",
  thinkAbout:
      "The text explains that machine learning improves cybersecurity by detecting and predicting threats, but it also depends on good data, strong computing systems, and raises privacy and ethical concerns.",
  question:
      "How could using machine learning for cybersecurity be both useful and difficult in countries like Colombia?",
  options: [
    "Cybersecurity in Colombia does not face real digital threats.",
    "Machine learning removes the need for internet infrastructure or trained specialists.",
    "It helps detect and predict attacks, but depends on data quality, infrastructure, and privacy protections that may be uneven in Colombia.",
    "Traditional security systems are enough, so AI is unnecessary.",
  ],
  correctIndex: 2,
  explanation:
      "This option recognizes that AI can strengthen cybersecurity in Colombia, but its effectiveness depends on real-world conditions like infrastructure, data availability, and ethical regulation.",
  wrongExplanation:
      "A, B, and D are incorrect:\n\nThey ignore either the presence of cyber threats or the practical limitations of applying AI systems in real national contexts like Colombia.",
);

// 59 – Articles
const BookQuizData _q59 = BookQuizData(
  bookTitle: "Media and Policy Making in the Digital Age: Challenges, Opportunities, and Transformations",
  thinkAbout:
      "The text explains that digital media has transformed policymaking by increasing access to information and public participation, but it also creates challenges such as misinformation, information overload, polarization, and the growing influence of tech platforms.",
  question:
      "How can digital media both strengthen and complicate policymaking in countries like Colombia?",
  options: [
    "Digital media eliminates misinformation and makes policymaking fully objective.",
    "Policymakers no longer need traditional institutions because social media replaces them.",
    "It increases participation and speed, but also spreads misinformation, overload, and polarization.",
    "Traditional media is always more reliable, so digital platforms should be avoided.",
  ],
  correctIndex: 2,
  explanation:
      "This option recognizes that digital media can improve democratic engagement in Colombia, but also creates challenges like misinformation, rapid reaction pressure, and uneven information quality.",
  wrongExplanation:
      "A, B, and D are incorrect:\n\nThey ignore either the benefits of digital media or the real risks and complexities described in the text.",
);

// 60 – Articles
const BookQuizData _q60 = BookQuizData(
  bookTitle: "The United Nations Sustainable Development Goals: A Comparative Analysis of Implementation",
  thinkAbout:
      "The text explains that the United Nations Sustainable Development Goals (SDGs) aim to improve poverty, education, health, and the environment, but their implementation is uneven. Progress depends on funding, strong institutions, reliable data, and cooperation, which vary across countries.",
  question:
      "How is implementing SDGs in countries like Colombia both an opportunity and a challenge?",
  options: [
    "Colombia already meets all SDG targets, so implementation is unnecessary.",
    "SDGs do not require funding, data, or government coordination.",
    "They guide development, but progress is limited by funding, data quality, and governance gaps.",
    "SDGs focus only on the environment, not social or economic issues.",
  ],
  correctIndex: 2,
  explanation:
      "This option recognizes that SDGs can support Colombia's development, but real progress depends on financial resources, institutional capacity, and reliable data systems.",
  wrongExplanation:
      "A, B, and D are incorrect:\n\nThey ignore the real implementation challenges and the broad, interconnected nature of the SDGs across social, economic, and environmental areas.",
);


final Map<String, BookQuizData> bookQuizMap = {
  // ── Biography ──────────────────────────────────────────────────────────────
  "From Spark to Genius Nikola Tesla's Early Life": const BookQuizData(
    bookTitle: "From Spark to Genius: Nikola Tesla's Early Life",
    thinkAbout:
        "The text presents Nikola Tesla as a brilliant inventor whose ideas about alternating current (AC) were initially doubted by many engineers. It highlights his perseverance, creativity, and eventual success in the United States.",
    question:
        "Which option offers the most critical interpretation of the text?",
    options: [
      "Tesla's success proves that talent alone is enough to overcome any obstacle.",
      "Technological progress happens naturally whenever a genius inventor appears.",
      "Scientific recognition depends on social and historical context.",
      "Engineers usually accept new ideas immediately.",
    ],
    correctIndex: 2,
    explanation:
        "This option recognizes that innovation is shaped not only by individual talent but also by social acceptance, institutions, and historical conditions.",
    wrongExplanation:
        "A, B, and D are incorrect: they oversimplify scientific progress and ignore the social and historical challenges Tesla faced.",
  ),

  "Cleopatra VIII": const BookQuizData(
    bookTitle: "Cleopatra VIII",
    thinkAbout:
        "The text presents Cleopatra VII as a politically skilled ruler who defended Egypt’s independence during the rise of the Roman Empire. It also questions how history has remembered her mainly through her relationships with powerful men.",
    question:
        "Which option offers the most critical interpretation of the text?",
    options: [
      "Cleopatra became powerful mainly because of Caesar and Antony.",
      "Historical narratives can reduce women leaders to stereotypes.",
      "Egypt’s fall was caused only by Cleopatra’s personal decisions.",
      "Political leadership depends more on charisma than strategy.",
    ],
    correctIndex: 1,
    explanation:
        "This option critically recognizes how gender and historical narratives can shape the way powerful women are remembered and represented.",
    wrongExplanation:
        "A, C, and D are incorrect:\n\nThey oversimplify Cleopatra’s leadership and ignore the political, historical, and gendered context presented in the text.",
  ),

  "Hellen Keller, The Story of my Life_ Chapters IV to VI": const BookQuizData(
    bookTitle: "Helen Keller: The Story of My Life",
    thinkAbout:
        "The text describes Helen Keller’s experience learning language and understanding the world as a deafblind child. It highlights the importance of communication, education, emotional connection, and Anne Sullivan’s teaching methods in helping Keller develop knowledge and independence.",
    question:
        "Which option offers the most critical interpretation of the text?",
    options: [
      "Access to language and support shapes learning and inclusion.",
      "Disability prevents meaningful communication.",
      "Learning depends only on individual effort.",
      "Helen Keller succeeded because she was naturally extraordinary.",
    ],
    correctIndex: 0,
    explanation:
        "This option critically recognizes that learning and participation depend not only on personal ability but also on access to communication, education, and supportive relationships.",
    wrongExplanation:
        "B, C, and D are incorrect:\n\nThey oversimplify disability and learning by ignoring the social, educational, and relational support that helped Helen Keller develop language and understanding.",
  ),

  // ── News ───────────────────────────────────────────────────────────────────
  "Houses Made of Waste Changing Lives in South America": const BookQuizData(
    bookTitle: "Houses Made of Waste",
    thinkAbout:
        "The text explains how communities in Latin America are transforming waste into construction materials to address environmental pollution and housing shortages. It highlights the role of recycling, community participation, and social innovation in creating sustainable housing projects.",
    question:
        "How could projects that transform waste into construction materials help communities in your country?",
    options: [
      "They can promote recycling, reduce pollution, and improve access to housing.",
      "They can eliminate all environmental and housing problems permanently.",
      "They are useful only in large cities with advanced technology.",
      "They mainly benefit companies rather than local communities.",
    ],
    correctIndex: 0,
    explanation:
        "This option recognizes how recycling projects can create environmental and social benefits by combining community participation, sustainability, and access to housing.",
    wrongExplanation:
        "B, C, and D are incorrect:\n\nThey exaggerate the impact of these projects or ignore the social and community-based aspects highlighted in the text.",
  ),

  "Uganda's Anti-Gay Law Sparks Global Concerns": const BookQuizData(
    bookTitle: "Uganda's Anti-Gay Law",
    thinkAbout:
        "The text explains how Uganda’s anti-homosexuality law has generated international concern because of its impact on human rights, healthcare access, and discrimination against LGBTQ communities.",
    question:
        "How could laws that discriminate against LGBTQ communities affect society and public health in your country?",
    options: [
      "They could increase discrimination and limit access to healthcare and support services.",
      "They could only affect personal relationships and have no social consequences.",
      "They could improve public health by reinforcing traditional social norms.",
      "They could mainly impact international politics rather than local communities.",
    ],
    correctIndex: 0,
    explanation:
        "This option critically recognizes that discriminatory laws can affect human rights, social inclusion, mental health, and access to healthcare for vulnerable communities",
    wrongExplanation:
        "B, C, and D are incorrect:\n\nThey ignore the broader social, health, and human rights consequences discussed in the text.",
  ),

  "A Recovery Center in Nigeria Takes a Musical Approach to Combating Drug Addiction":
      const BookQuizData(
    bookTitle: "Nigeria's Musical Recovery Center",
    thinkAbout:
        "The text describes how a recovery center in Nigeria uses music, community support, education, and faith-based programs to help people recover from drug addiction and rebuild their lives.",
    question:
        "How could community-based recovery programs help young people facing addiction problems in countries like Colombia?",
    options: [
      "Drug addiction mainly affects people who refuse to study or work.",
      "Addiction can only be solved through punishment and stricter laws.",
      "Recovery depends only on individual willpower.",
      "They can provide support, inclusion, and opportunities for personal growth.",
    ],
    correctIndex: 3,
    explanation:
        "This option critically recognizes that addiction is connected to social, emotional, and community factors, and that support networks can help people recover and rebuild their lives.",
    wrongExplanation:
        "A, B, and C are incorrect:\n\nThey oversimplify addiction and ignore the social, economic, and emotional conditions discussed in the text.",
  ),

  // ── Stories ────────────────────────────────────────────────────────────────
  "The Star Beast": const BookQuizData(
    bookTitle: "The Star Beast",
    thinkAbout:
        "The text presents a future where scientific discoveries, artificial intelligence, and alien life forms create ethical and security dilemmas. It also shows how fear, misunderstanding, and the desire for power can influence human decisions.",
    question:
        "Which option offers the most critical interpretation of the text?",
    options: [
      "Advanced technology is always dangerous for humanity.",
      "Scientific progress can create ethical conflicts and struggles for control.",
      "Alien life forms are naturally hostile to humans.",
      "Security problems happen only because people ignore science.",
    ],
    correctIndex: 1,
    explanation:
        "This option critically recognizes that scientific discoveries can transform society while also creating ethical, political, and security tensions about how knowledge and power are used.",
    wrongExplanation:
        "A, C, and D are incorrect:\n\nthey oversimplify the conflict by blaming only technology, aliens, or individuals instead of considering the broader ethical and social issues presented in the story.",
  ),

  "Désirée's Baby": const BookQuizData(
    bookTitle: "Désirée's Baby",
    thinkAbout:
        "The text presents a society deeply shaped by racism and slavery, where a person’s value and social acceptance depend on racial identity. It also shows how prejudice can destroy relationships, families, and lives.",
    question:
        "Which option offers the most critical interpretation of the text?",
    options: [
      "Family honor is more important than personal relationships.",
      "Social status depends mainly on wealth and family name.",
      "Armand’s actions are justified because he wanted to protect his reputation.",
      "Racism and social prejudice can lead people to act cruelly and unjustly",
    ],
    correctIndex: 3,
    explanation:
        "This option critically recognizes how racism and prejudice shape the characters’ actions and create injustice, suffering, and discrimination.",
    wrongExplanation:
        "A, B, and C are incorrect:\n\nThey normalize or oversimplify the racism and social inequality presented in the story.",
  ),

  "The Shadow": const BookQuizData(
    bookTitle: "The Shadow",
    thinkAbout:
        "The story presents fear not as something fully visible or explainable, but as a mysterious presence connected to guilt, repression, and emotional suffering. The “shadow” seems to affect the characters psychologically, especially those who hide painful emotions or unresolved conflicts.",
    question:
        "Which option offers the most critical interpretation of the text?",
    options: [
      "The story proves that ghosts are always real supernatural beings.",
      "The shadow symbolizes hidden emotional trauma and psychological fear.",
      "Miss Eastwich invents the story only to scare the younger girls.",
      "The text suggests that science can fully explain every strange experience.",
    ],
    correctIndex: 1,
    explanation:
        "This option offers the most critical interpretation because it understands the shadow as a symbol of hidden emotional trauma, fear, and unresolved suffering, not just a literal ghost.",
    wrongExplanation:
        "A, C, and D are incorrect:\n\nThey oversimplify the story’s psychological complexity and ignore its ambiguity about fear, guilt, and the supernatural.",
  ),

  // ── Articles ───────────────────────────────────────────────────────────────
  "The Role of Mobile Health (mHealth) in Primary Care: Opportunities and Challenges":
      const BookQuizData(
    bookTitle: "mHealth in Primary Care",
    thinkAbout:
        "The text explains how mobile health (mHealth) technologies, such as apps and wearable devices, can improve access to healthcare and help people manage their health. However, it also highlights challenges like digital inequality, privacy concerns, and limited access for some populations.",
    question:
        "How could mHealth technologies help improve healthcare access in countries like Colombia?",
    options: [
      "Healthcare problems can be solved only through technology.",
      "Digital health tools are useful only for young people.",
      "They can increase access to remote health care in underserved communities.",
      "Patients no longer need doctors if they use health apps.",
    ],
    correctIndex: 2,
    explanation:
        "This option critically recognizes that mHealth can support access to healthcare and patient engagement, especially in areas with limited medical services, while still requiring proper integration and support.",
    wrongExplanation:
        "A, B, and D are incorrect:\n\nThey oversimplify healthcare challenges and ignore the social, educational, and technological barriers discussed in the text.",
  ),

  "Gender Stereotypes in AI-Generated Images: Biases, Implications, and Solutions":
      const BookQuizData(
    bookTitle: "Gender Stereotypes in AI Images",
    thinkAbout:
        "The text explains how AI-generated images can reproduce gender stereotypes by associating men and women with traditional social roles and professions. It also discusses the social consequences of these biases and the importance of developing more inclusive AI systems.",
    question:
        "Why would it be important to reduce gender bias in AI-generated images in societies like Colombia?",
    options: [
      "Gender stereotypes in technology are harmless and natural.",
      "AI should reflect traditional social roles without questioning them.",
      "Less bias means fairer gender representation and opportunity.",
      "Technology automatically becomes fair without human intervention.",
    ],
    correctIndex: 2,
    explanation:
        "This option critically recognizes that AI influences social perceptions and opportunities, so reducing bias can help create more inclusive and equitable representation.",
    wrongExplanation:
        "A, B, and D are incorrect:\n\nThey normalize or oversimplify gender inequality and ignore the social impact of biased technology discussed in the text.",
  ),

  "Sustainable Development Through Eco-Innovation: The Role of Small and Medium Enterprises in Colombia":
      const BookQuizData(
    bookTitle: "Eco-Innovation in Colombian SMEs",
    thinkAbout:
        "The text explains how eco-innovation can help Colombian small and medium enterprises (SMEs) reduce environmental impact while improving economic and social development. It also highlights challenges such as limited funding, lack of technical knowledge, and weak policy support.",
    question:
        "Why could eco-innovation be important for the future of businesses in Colombia?",
    options: [
      "Environmental problems should be solved only by large companies.",
      "Small businesses do not influence environmental or social conditions. ",
      "Economic growth and environmental protection cannot exist together.",
      "Sustainability boosts competitiveness and protects the environment",
    ],
    correctIndex: 3,
    explanation:
        "This option critically recognizes that sustainability and economic development can work together through innovation, benefiting businesses, communities, and the environment.",
    wrongExplanation:
        "A, B, and C are incorrect:\n\nThey oversimplify environmental and economic challenges and ignore the role SMEs can play in sustainable development.",
  ),

  // ── Alias keys (alternate titles the app may pass) ─────────────────────────
  "Star Beast": const BookQuizData(
    bookTitle: "The Star Beast",
    thinkAbout:
        "The text presents a future where scientific discoveries, artificial intelligence, and alien life forms create ethical and security dilemmas. It also shows how fear, misunderstanding, and the desire for power can influence human decisions.",
    question:
        "Which option offers the most critical interpretation of the text?",
    options: [
      "Advanced technology is always dangerous for humanity.",
      "Scientific progress can create ethical conflicts and struggles for control.",
      "Alien life forms are naturally hostile to humans.",
      "Security problems happen only because people ignore science.",
    ],
    correctIndex: 1,
    explanation:
        "This option critically recognizes that scientific discoveries can transform society while also creating ethical, political, and security tensions about how knowledge and power are used.",
    wrongExplanation:
        "A, C, and D are incorrect:\n\nthey oversimplify the conflict by blaming only technology, aliens, or individuals instead of considering the broader ethical and social issues presented in the story.",
  ),
  "mHealth in Primary Care": const BookQuizData(
    bookTitle: "mHealth in Primary Care",
    thinkAbout:
        "The text explains how mobile health (mHealth) technologies, such as apps and wearable devices, can improve access to healthcare and help people manage their health. However, it also highlights challenges like digital inequality, privacy concerns, and limited access for some populations.",
    question:
        "How could mHealth technologies help improve healthcare access in countries like Colombia?",
    options: [
      "Healthcare problems can be solved only through technology.",
      "Digital health tools are useful only for young people.",
      "They can increase access to remote health care in underserved communities.",
      "Patients no longer need doctors if they use health apps.",
    ],
    correctIndex: 2,
    explanation:
        "This option critically recognizes that mHealth can support access to healthcare and patient engagement, especially in areas with limited medical services, while still requiring proper integration and support.",
    wrongExplanation:
        "A, B, and D are incorrect:\n\nThey oversimplify healthcare challenges and ignore the social, educational, and technological barriers discussed in the text.",
  ),
  "The Role of Mobile Health (mHealth) in Primary Care": const BookQuizData(
    bookTitle: "mHealth in Primary Care",
    thinkAbout:
        "The text explains how mobile health (mHealth) technologies, such as apps and wearable devices, can improve access to healthcare and help people manage their health. However, it also highlights challenges like digital inequality, privacy concerns, and limited access for some populations.",
    question:
        "How could mHealth technologies help improve healthcare access in countries like Colombia?",
    options: [
      "Healthcare problems can be solved only through technology.",
      "Digital health tools are useful only for young people.",
      "They can increase access to remote health care in underserved communities.",
      "Patients no longer need doctors if they use health apps.",
    ],
    correctIndex: 2,
    explanation:
        "This option critically recognizes that mHealth can support access to healthcare and patient engagement, especially in areas with limited medical services, while still requiring proper integration and support.",
    wrongExplanation:
        "A, B, and D are incorrect:\n\nThey oversimplify healthcare challenges and ignore the social, educational, and technological barriers discussed in the text.",
  ),

  // ── Entries 13–24 ──────────────────────────────────────────────────────────

  // 13 – Biography
  "Ynes E. J. Mexia, Where Love for Science Meets the Spirit of Adventure":
      const BookQuizData(
    bookTitle: "Ynes Mexia: Science Meets Adventure",
    thinkAbout:
        "The text highlights how Ynes Mexia defied rigid 20th-century gender norms, passport restrictions, and social stereotypes to become a successful, independent scientist later in life.",
    question:
        "Which option offers the most critical interpretation of the text?",
    options: [
      "Mexia succeeded because she loved nature and traveling alone.",
      "Mexia's career directly challenged the systemic gender barriers of her era.",
      "Early 20th-century women stayed home because travel was too difficult.",
      "Mexia failed to achieve full success because she never finished her degree.",
    ],
    correctIndex: 1,
    explanation:
        "This option critically recognizes how Mexia's career defied the institutional and cultural barriers placed upon women at the time.",
    wrongExplanation:
        "A, C, and D are incorrect:\n\nThey over-reduce her success as a hobby, falsely frame systemic confinement as a personal choice, or judge her by rigid institutional standards.",
  ),

  // 14 – Biography
  "The Story of Atahualpa, Last Inca Emperor": const BookQuizData(
    bookTitle: "Atahualpa: Last Inca Emperor",
    thinkAbout:
        "The text highlights how the Inca Empire's rapid collapse was driven by internal fractures like civil war, smallpox, and regional resentment, rather than just the arrival of the Spanish.",
    question:
        "Which option offers the most critical interpretation of the text?",
    options: [
      "The Inca Empire fell because Pizarro was a smarter military leader than Atahualpa.",
      "The Spanish successfully brought peace and order to a violent, war-torn region.",
      "Atahualpa was a foolish ruler who should have attacked the Spanish immediately.",
      "Internal fragility, disease, and structural weaknesses caused the empire's collapse.",
    ],
    correctIndex: 3,
    explanation:
        "This option critically recognizes that the empire's downfall was a complex result of systemic vulnerabilities, internal division, and biological devastation, rather than a simple military defeat.",
    wrongExplanation:
        "A, B, and C are incorrect:\n\nThey blame personal flaws, ignore Inca structural crises, and falsely frame Spanish conquest as peaceful.",
  ),

  // 15 – Biography
  "Nietzsche His Life and Works": const BookQuizData(
    bookTitle: "Nietzsche: His Life and Work",
    thinkAbout:
        "The text presents Nietzsche not merely as an eccentric writer, but as a deeply intentional thinker whose aggressive, poetic attacks on traditional morality, religion, and scientific theories were driven by a singular, constructive goal: to elevate human potential and create new values.",
    question:
        "Which option offers the most critical interpretation of the text?",
    options: [
      "Nietzsche was a poet rather than a true philosopher.",
      "Nietzsche's ideas are wrong because they oppose tradition.",
      "Nietzsche's philosophy was just a result of his poor health.",
      "Nietzsche's critiques purposefully aimed to redefine human excellence.",
    ],
    correctIndex: 3,
    explanation:
        "This option critically recognizes the constructive, philosophical purpose behind Nietzsche's radical style.",
    wrongExplanation:
        "A, B, and C are incorrect:\n\nThey dismiss his status using rigid definitions, reduce his ideas to personal illness, or reject him simply for challenging tradition.",
  ),

  // 16 – Biography (popular science biography style)
  "How Evolution Might Explain Impatience": const BookQuizData(
    bookTitle: "How Evolution Might Explain Impatience",
    thinkAbout:
        "The text suggests that modern impatience is not just irrationality, but an evolved, historically rational response to risk and uncertainty that sometimes misfires in today's secure world.",
    question:
        "Which option offers the most critical interpretation of the text?",
    options: [
      "Impatience is a negative modern trait caused by fast food and technology.",
      "Our preference for immediate rewards is deeply rooted in evolutionary survival strategies.",
      "People always make rational financial decisions when choosing between rewards.",
      "Evolutionary models perfectly explain all modern human behaviors regarding debt.",
    ],
    correctIndex: 1,
    explanation:
        "This option critically recognizes that impatience functions as an evolutionary adaptation designed to mitigate environmental risk and uncertainty.",
    wrongExplanation:
        "A, C, and D are incorrect:\n\nThey reduce impatience to a simple modern flaw, ignore the clear experimental evidence of human financial irrationality, or overstate the model's ability to explain complex behaviors.",
  ),

  // 17 – News
  "Q&A: 'Fear of Laughter' Keeps Girls Quiet at School": const BookQuizData(
    bookTitle: "Fear of Laughter: Girls Quiet at School",
    thinkAbout:
        "The text highlights how systemic cultural expectations, low self-esteem, and a fear of social judgment actively suppress girls' voices and limit their representation in science.",
    question:
        "Which option offers the most critical interpretation of the text?",
    options: [
      "Cultural norms and social policing create psychological and structural barriers to girls' education.",
      "Girls are naturally quiet in co-ed classes because boys are better at science.",
      "Child marriage in Malawi is a personal lifestyle choice by young girls.",
      "Role models are unnecessary if schools have local science materials.",
    ],
    correctIndex: 0,
    explanation:
        "This option critically recognizes that the low representation of women in science stems from deeply rooted cultural pressures and systemic barriers rather than individual preferences.",
    wrongExplanation:
        "B, C, and D are incorrect:\n\nThey normalize inequality with sexist assumptions, ignore pressures behind early marriage, or dismiss mentorship and structural support.",
  ),

  // 18 – News
  "Feminist Literature Under Fire: The 'Cometierra' Controversy in Argentina":
      const BookQuizData(
    bookTitle: "The 'Cometierra' Controversy in Argentina",
    thinkAbout:
        "The text connects the censorship of the novel Cometierra to a broader, systemic push by the Argentine government to defund gender protection programs and erase discussions around femicide and inequality.",
    question:
        "Which option offers the most critical interpretation of the text?",
    options: [
      "A simple dispute over age-appropriate school reading.",
      "Institutional suppression of gender-violence narratives amid a wider rollback of women's rights.",
      "Milei's government closing unnecessary ministries to focus on the economy.",
      "Cometierra's best-seller status due solely to its literary quality and psychic storyline.",
    ],
    correctIndex: 1,
    explanation:
        "This option critically recognizes that the book controversy is part of a larger political campaign to dismantle gender-equality policies.",
    wrongExplanation:
        "A, C, and D are incorrect:\n\nThey downplay the censorship as a minor age-rating debate, ignore the reality of reduced victim protections, or overlook the book's success as an act of political resistance.",
  ),

  // 19 – Stories
  "The Nothing Equation": const BookQuizData(
    bookTitle: "The Nothing Equation",
    thinkAbout:
        "The text shows how the psychological pressure of total isolation in space breaks rational minds, causing characters to mistake the terrors of loneliness and vulnerability for an external threat.",
    question:
        "Which option offers the most critical interpretation of the text?",
    options: [
      "The true threat was the psychological toll of isolation, which characters mistook for a monster.",
      "The attendants went insane due to poor engineering and structural defects in the bubble.",
      "Captain McDowell was right that only uneducated workers are mentally strong enough for space.",
      "The story proves an invisible alien entity was actively trying to destroy the bubble.",
    ],
    correctIndex: 0,
    explanation:
        "This option critically recognizes that the 'Nothing' was a psychological manifestation of extreme isolation and vulnerability rather than a physical threat.",
    wrongExplanation:
        "B, C, and D are incorrect:\n\nThey reduce a psychological horror to a mechanical failure, validate a character's elitist bias, or mistake internal hallucinations for an actual alien presence.",
  ),

  // 20 – Stories
  "A Dill Pickle": const BookQuizData(
    bookTitle: "A Dill Pickle",
    thinkAbout:
        "The text explores how the illusion of a romantic reunion shatters because of the man's persistent ego, his habit of interrupting her, and his ultimate focus on trivial financial costs, reminding Vera why she left him.",
    question:
        "Which option offers the most critical interpretation of the text?",
    options: [
      "Vera left because she suddenly remembered she hated the taste of dill pickles.",
      "The meeting reveals that despite his romantic words, the man remains fundamentally self-absorbed and controlling.",
      "The man has truly changed and genuinely wants to support Vera financially.",
      "Vera is an irrational character who threw away her only chance at true happiness.",
    ],
    correctIndex: 1,
    explanation:
        "This option critically recognizes that the man's nostalgic stories mask a continuous pattern of egoism, proved at the end when his concern shifts instantly from losing Vera to the cost of untouched cream.",
    wrongExplanation:
        "A, C, and D are incorrect:\n\nThey mistake a metaphorical story detail for a literal plot point, overlook the man's clear superficiality, or blame Vera while ignoring her ex-partner's self-centered behavior.",
  ),

  // 21 – Stories
  "The Tell-Tale Heart": const BookQuizData(
    bookTitle: "The Tell-Tale Heart",
    thinkAbout:
        "The text uses an unreliable narrator who fiercely denies his madness, yet his meticulous planning and eventual self-destruction reveal a deep psychological obsession and overwhelming guilt.",
    question:
        "Which option offers the most critical interpretation of the text?",
    options: [
      "The narrator is completely sane because he planned and executed the murder flawlessly.",
      "The old man's heart actually kept beating under the floorboards to expose the crime.",
      "The narrator's obsession with the eye and hallucinations reveals his total psychological collapse.",
      "The police knew about the murder immediately and intentionally mocked the narrator.",
    ],
    correctIndex: 2,
    explanation:
        "This option critically recognizes that the narrator's intense defense of his sanity is undermined by his erratic behavior, irrational motives, and guilt-driven hallucinations.",
    wrongExplanation:
        "A, B, and D are incorrect:\n\nThey mistake the narrator's self-proclaimed sanity for literal truth, misinterpret a psychological hallucination as a supernatural reality, or invent an awareness from the police that contradicts the text.",
  ),

  // 22 – Articles
  "The Global Transition to Electric Vehicles: Technological, Environmental, Organizational, and Policy Perspectives":
      const BookQuizData(
    bookTitle: "Global Transition to Electric Vehicles",
    thinkAbout:
        "The text explains that EVs' environmental benefits depend on clean grids and sustainable batteries. Colombia's highly renewable hydropower grid gives it a unique advantage—if it can manage battery recycling and infrastructure challenges.",
    question:
        "Why is the transition to electric vehicles highly advantageous yet complex for a country like Colombia?",
    options: [
      "EVs instantly solve all environmental problems by eliminating tailpipe emissions.",
      "The shift to electric mobility in Colombia is driven entirely by consumer choice without policy support.",
      "Colombia should avoid EVs because battery manufacturing makes them worse than gasoline cars.",
      "Colombia's clean energy grid maximizes EV benefits, but sustainable battery lifecycles must still be managed.",
    ],
    correctIndex: 3,
    explanation:
        "This option critically recognizes that Colombia's renewable energy grid gives EVs a significant environmental advantage, but long-term sustainability requires managing battery lifecycles and building charging infrastructure.",
    wrongExplanation:
        "A, B, and C are incorrect:\n\nThey oversimplify the transition and ignore the complex interplay of clean energy, battery sustainability, and policy support discussed in the text.",
  ),

  // 23 – Articles
  "The Actualization of Loneliness in Modern Philosophy: Historical Perspectives and Contemporary Reflection":
      const BookQuizData(
    bookTitle: "Loneliness in Modern Philosophy",
    thinkAbout:
        "The text distinguishes between positive solitude (growth) and negative loneliness (distress) caused by modern tech and cities. For students in rapidly urbanizing countries like Colombia, this distinction helps protect mental and spiritual well-being.",
    question:
        "Why is distinguishing between positive and negative loneliness crucial for young people navigating Colombia's rapidly urbanizing society?",
    options: [
      "Digital connectivity completely eliminates negative loneliness for Colombian youth.",
      "It transforms harmful isolation into constructive solitude, protecting mental well-being.",
      "Colombia must halt urban and economic growth to prevent existential loneliness.",
      "Loneliness is a purely negative emotional defect resolved only by constant online interaction.",
    ],
    correctIndex: 1,
    explanation:
        "This option critically recognizes that understanding these categories allows individuals to counteract modern systemic isolation by cultivating healthy, self-reflective solitude.",
    wrongExplanation:
        "A, C, and D are incorrect:\n\nThey falsely claim technology fixes isolation, offer an unrealistic rejection of urban development, or ignore the proven benefits of positive solitude.",
  ),

  // 24 – Articles
  "Pathways to a Net Zero Building Sector in Colombia: Challenges, Strategies, and Opportunities":
      const BookQuizData(
    bookTitle: "Net Zero Buildings in Colombia",
    thinkAbout:
        "The text outlines Colombia's roadmap to achieve net-zero building emissions by 2050. In Bogotá, a city facing rapid urban expansion and high energy demands, this transition is essential but restricted by high upfront costs for green materials and a shortage of specialized local labor.",
    question:
        "Why is implementing this decarbonization roadmap critically urgent yet challenging for the construction sector here in Bogotá?",
    options: [
      "High-altitude cities like Bogotá are immune to carbon emissions, making the roadmap unnecessary.",
      "It lowers urban emissions and saves energy, but local builders face high upfront costs and a lack of trained workers.",
      "Bogotá must completely halt all housing and infrastructure projects to meet its 2030 climate targets.",
      "Traditional construction materials like standard cement require no changes to reach net-zero goals in the capital.",
    ],
    correctIndex: 1,
    explanation:
        "This option critically recognizes that while the roadmap provides long-term environmental benefits for Bogotá, local firms must overcome financial barriers and workforce skill gaps to implement it.",
    wrongExplanation:
        "A, C, and D are incorrect:\n\nThey falsely claim Bogotá is unaffected by pollution, offer an unrealistic ban on city growth, or ignore the high carbon footprint of traditional concrete.",
  ),

  // ── Biography 25–27 ────────────────────────────────────────────────────────
  "Alexander Graham Bell And The Telephone": _q25,
  "Alexander Graham Bell": _q25,
  "Alexander Graham Bell And The Telephone_": _q25,

  "Life and Times of Mandela": _q26,
  "Life and Times of Mandela_": _q26,
  "Nelson Mandela": _q26,

  "Girls Who Became Famous Florence Nightingale": _q27,
  "Girls Who Became Famous_ Florence Nightingale": _q27,
  "Florence Nightingale": _q27,

  // ── News 28–30 ─────────────────────────────────────────────────────────────
  "AI Chatbot Deployed to Target Drug Resistance": _q28,
  "AI Chatbot Deployed to Target Drug Resistance_": _q28,
  "A Central AI Chatbot Drug Resistance": _q28,

  "Polio Survivors Face Biggest Fight of Their Lives": _q29,
  "Polio Survivors Face Biggest Fight of Their Lives_": _q29,
  "Polio Survivors": _q29,

  "In Venezuela Theater is also Part of the Resistance": _q30,
  "In Venezuela_ Theater is also Part of the Resistance": _q30,
  "Venezuela Theater Resistance": _q30,
  "Theater Resistance": _q30,
  "Resistance": _q30,

  // ── Stories 31–33 ──────────────────────────────────────────────────────────
  "The Plutonian Drug": _q31,
  "The Plutonian Drug_": _q31,
  "Plutonian Drug": _q31,

  "Sweat": _q32,
  "Sweat_": _q32,

  "The Outsider": _q33,
  "The Outsider_": _q33,
  "Outsider": _q33,

  // ── Articles 34–36 ─────────────────────────────────────────────────────────
  "Advancements in 3D Bioprinting A New Era in Tissue Engineering": _q34,
  "Advancements in 3D Bioprinting_ A New Era in Tissue Engineering": _q34,
  "Advancements in 3D Bioprinting": _q34,
  "3D Bioprinting A New Era in Tissue Engineering": _q34,

  "Communication Strategies for Dementia Care A New Perspective on Caregiving": _q35,
  "Communication Strategies for Dementia Care_ A New Perspective on Caregiving": _q35,
  "Communication Strategies for Dementia Care": _q35,

  "Bamboo as a Sustainable Building Material for Innovative Low Cost Housing Construction": _q36,
  "Bamboo as a Sustainable Building Material for Innovative_ Low-Cost Housing Construction": _q36,
  "Bamboo as a Sustainable Building Material": _q36,
  "Bamboo Sustainable Building Material for Innovative Low Cost Housing Construction": _q36,

  // ── Biography 37–39 ────────────────────────────────────────────────────────
  "The Wright Brothers' Aeroplane": _q37,
  "Wright Brothers Aeroplane": _q37,
  "The Wright Brothers_ Aeroplane": _q37,
  "Wright Brothers": _q37,
  "Aeroplane": _q37,
  "Brothers": _q37,

  "Lives of Poor Boys Who Became Famous Abraham Lincon": _q38,
  "Lives of Poor Boys Who Became Famous Abraham Lincoln": _q38,
  "Abraham Lincoln": _q38,
  "Abraham Lincon": _q38,
  "Abraham": _q38,
  "Lincon": _q38,
  "Lives of Poor Boys Who Became Famous_ Abraham Lincoln": _q38,

  "Memoir of Jane Austen Fragment": _q39,
  "Memoir of Jane Austen_ Fragment": _q39,
  "Jane Austen Fragment": _q39,
  "Jane Austen Memoir": _q39,

  // ── News 40–42 ─────────────────────────────────────────────────────────────
  "Indigenous People Raise Voices to Avert Amazon Tipping Point": _q40,
  "Indigenous People Raise Voices to Avert Amazon Tipping Point_": _q40,
  "Amazon Tipping Point": _q40,
  "Indigenous Amazon Tipping Point": _q40,

  "Syrians Turn War Missiles into Heaters as Winter Grips": _q41,
  "Syrians Turn War Missiles into Heaters as Winter Grips_": _q41,
  "Syrians Missiles Heaters": _q41,
  "War Missiles into Heaters": _q41,

  "Brazilian Graffiti Artists and Young Syrians Are Painting Refugee Camp Walls Together": _q42,
  "Brazilian Graffiti Artists and Young Syrians Are Painting Refugee Camp Walls Together_": _q42,
  "Brazilian Graffiti Artists": _q42,
  "Graffiti Refugee Camp Walls": _q42,

  // ── Stories 43–45 ──────────────────────────────────────────────────────────
  "2BR02B": _q43,
  "2BR02B_": _q43,
  "2 BR02B": _q43,

  "The Pearl of Love": _q44,
  "The Pearl of Love_": _q44,
  "Pearl of Love": _q44,

  "The Yellow Wall-Paper": _q45,
  "The Yellow Wallpaper": _q45,
  "Yellow Wall-Paper": _q45,
  "Yellow Wallpaper": _q45,

  // ── Articles 46–48 ─────────────────────────────────────────────────────────
  "The Evolution of Mars Water-Ice Detection Research (1990-2024)": _q46,
  "Mars Water-Ice Detection Research": _q46,
  "Evolution of Mars Water Ice Detection Research": _q46,
  "Mars Water Ice Detection": _q46,

  "Burnout and Depression in College Students": _q47,
  "Burnout and Depression in College Students_": _q47,
  "Burnout Depression College Students": _q47,

  "The Impact of Environmental Pollution on the Sustainability of Architectural Heritage The Case of Cartagena de Indias": _q48,
  "Environmental Pollution Architectural Heritage Cartagena": _q48,
  "Architectural Heritage Cartagena de Indias": _q48,
  "Impact of Environmental Pollution on the Sustainability of Architectural Heritage": _q48,
  "The Impact of Environmental Pollution on the Sustainability of Architectural Heritage_ The Case of Cartagena de Indias": _q48,


  // ── Biography 49–51 ────────────────────────────────────────────────────────
  "Giuseppina Cattani the Unknown Co Discoverer of the Antitetanus Serum": _q49,
  "Giuseppina Cattani": _q49,
  "Cattani Antitetanus Serum": _q49,
  "Unknown Co Discoverer of the Antitetanus Serum": _q49,

  "The Story of Joan of Arc Chapters I II": _q50,
  "Joan of Arc Chapters I II": _q50,
  "Joan of Arc": _q50,
  "Story of Joan of Arc": _q50,

  "Famous Men of Ancient Times Socrates": _q51,
  "Famous Men of Ancient Times_ Socrates": _q51,
  "Socrates Famous Men": _q51,
  "Socrates": _q51,

  // ── News 52–54 ─────────────────────────────────────────────────────────────
  "Will the US Get to Mars Quicker if it Drops or Delays Plans to Visit the Moon": _q52,
  "US Get to Mars Quicker Drops Delays Moon": _q52,
  "Mars Quicker Moon Plans": _q52,
  "Will the US Get to Mars": _q52,

  "The Urgent Mental Health Needs of Young People": _q53,
  "Urgent Mental Health Needs of Young People": _q53,
  "Mental Health Needs Young People": _q53,

  "A Central African Designer is Transforming Sneakers into Portable Manga in Senegal": _q54,
  "Central African Designer Transforming Sneakers Manga Senegal": _q54,
  "Central African Designer Sneakers Manga": _q54,
  "African Designer Manga Senegal": _q54,

  // ── Stories 55–57 ──────────────────────────────────────────────────────────
  "A Sound of Thunder": _q55,
  "Sound of Thunder": _q55,

  "The Nightingale and the Rose": _q56,
  "Nightingale and the Rose": _q56,

  "The Spider": _q57,
  "Spider": _q57,

  // ── Articles 58–60 ─────────────────────────────────────────────────────────
  "Cybersecurity and Data Science The Role of Machine Learning in Cyber Threat Protection": _q58,
  "Cybersecurity and Data Science Role of Machine Learning": _q58,
  "Cybersecurity Machine Learning Cyber Threat": _q58,
  "Cybersecurity Data Science Machine Learning": _q58,

  "Media and Policy Making in the Digital Age Challenges Opportunities and Transformations": _q59,
  "Media and Policy Making in the Digital Age": _q59,
  "Media Policy Making Digital Age": _q59,

  "The United Nations Sustainable Development Goals A Comparative Analysis of Implementation": _q60,
  "United Nations Sustainable Development Goals Comparative Analysis": _q60,
  "SDGs Comparative Analysis Implementation": _q60,
  "United Nations SDGs": _q60,


};

// ─────────────────────────────────────────────
//  CATEGORY THEME COLORS
// ─────────────────────────────────────────────

enum _BookCategory { biography, news, stories, articles, unknown }

_BookCategory _categoryForTitle(String title) {
  final t = title.toLowerCase();
  // Biography
  if (t.contains('tesla') ||
      t.contains('cleopatra') ||
      t.contains('keller') ||
      t.contains('mexia') ||
      t.contains('atahualpa') ||
      t.contains('inca emperor') ||
      t.contains('nietzsche') ||
      t.contains('alexander graham bell') ||
      t.contains('mandela') ||
      t.contains('florence nightingale') ||
      t.contains('wright brothers') ||
      t.contains('lincoln') ||
      t.contains('lincon') ||
      t.contains('jane austen') ||
      t.contains('cattani') ||
      t.contains('joan of arc') ||
      t.contains('socrates')) return _BookCategory.biography;
  // News
  if (t.contains('houses made') ||
      t.contains('uganda') ||
      t.contains('nigeria') ||
      t.contains('musical approach') ||
      t.contains('recovery center') ||
      t.contains('fear of laughter') ||
      t.contains('girls quiet') ||
      t.contains('evolution might explain') ||
      t.contains('cometierra') ||
      t.contains('impatience') ||
      t.contains('feminist literature') ||
      t.contains('ai chatbot') ||
      t.contains('drug resistance') ||
      t.contains('polio survivors') ||
      t.contains('venezuela') ||
      t.contains('theater') && t.contains('resistance') ||
      t.contains('amazon tipping') ||
      t.contains('indigenous') && t.contains('amazon') ||
      t.contains('syrians') ||
      t.contains('missiles') ||
      t.contains('graffiti') ||
      t.contains('refugee camp') ||
      t.contains('mars quicker') ||
      t.contains('urgent mental health') ||
      t.contains('central african designer') ||
      t.contains('manga') && t.contains('senegal')) return _BookCategory.news;
  // Stories
  if (t.contains('star beast') ||
      t.contains('slowly') ||
      t.contains('désirée') ||
      t.contains('desiree') ||
      t.contains('shadow') ||
      t.contains('nothing equation') ||
      t.contains('dill pickle') ||
      t.contains('tell-tale heart') ||
      t.contains('tell tale heart') ||
      t.contains('man who would be king') ||
      t.contains('yellow wallpaper') ||
      t.contains('black cat') ||
      t.contains('gift of the magi') ||
      t.contains('necklace') ||
      t.contains('story of an hour') ||
      t.contains('plutonian drug') ||
      t.contains('sweat') ||
      t.contains('outsider') ||
      t.contains('2br02b') ||
      t.contains('pearl of love') ||
      t.contains('yellow wall') ||
      t.contains('sound of thunder') ||
       t.contains('rose') && t.contains('nightingale') ||
      t.contains('the spider') ||
      t.contains('spider') && t.contains('hotel')) return _BookCategory.stories;
  // Articles
  if (t.contains('mhealth') ||
      t.contains('mobile health') ||
      t.contains('gender stereotype') ||
      t.contains('ai-generated') ||
      t.contains('eco-innovation') ||
      t.contains('sustainable development') ||
      t.contains('electric vehicle') ||
      t.contains('loneliness in modern') ||
      t.contains('actualization of loneliness') ||
      t.contains('net zero') ||
      t.contains('pathways to a net') ||
      t.contains('bioprinting') ||
      t.contains('dementia care') ||
      t.contains('bamboo') ||
      t.contains('mars water') ||
      t.contains('burnout') ||
      t.contains('cartagena') ||
      t.contains('architectural heritage') ||
      t.contains('cybersecurity') ||
      t.contains('machine learning') && t.contains('cyber') ||
      t.contains('media') && t.contains('policy') ||
      t.contains('sustainable development goals') ||
      t.contains('sdgs')) return _BookCategory.articles;
  return _BookCategory.unknown;
}

/// Returns the accent color for a given category.
/// Feedback always stays green — use [feedbackColor] for that.
Color _accentForCategory(_BookCategory cat) {
  switch (cat) {
    case _BookCategory.biography:
      return const Color(0xFFFFD700); // Yellow
    case _BookCategory.news:
      return const Color(0xFF39FF7A); // Green
    case _BookCategory.stories:
      return const Color(0xFF38B6FF); // Blue
    case _BookCategory.articles:
      return const Color(0xFFB06AFF); // Purple
    case _BookCategory.unknown:
      return const Color(0xFF39FF7A); // fallback green
  }
}

/// Background card color derived from accent (always dark)
Color _bgForCategory(_BookCategory cat) {
  switch (cat) {
    case _BookCategory.biography:
      return const Color(0xFF1A1500);
    case _BookCategory.news:
      return const Color(0xFF061A0E);
    case _BookCategory.stories:
      return const Color(0xFF021525);
    case _BookCategory.articles:
      return const Color(0xFF120A2A);
    case _BookCategory.unknown:
      return const Color(0xFF061A0E);
  }
}

/// Star gradient pair for the space background
List<Color> _starColorsForCategory(_BookCategory cat) {
  switch (cat) {
    case _BookCategory.biography:
      return [const Color(0xFFFFD700), const Color(0xFFFFA500)];
    case _BookCategory.news:
      return [const Color(0xFF39FF7A), const Color(0xFF00FF5E)];
    case _BookCategory.stories:
      return [const Color(0xFF38B6FF), const Color(0xFF0099FF)];
    case _BookCategory.articles:
      return [const Color(0xFFB06AFF), const Color(0xFF8833FF)];
    case _BookCategory.unknown:
      return [const Color(0xFF39FF7A), const Color(0xFF00FF5E)];
  }
}

// Always-green palette for feedback (never changes)
const Color _feedbackAccent = Color(0xFF39FF7A);
// ignore: unused_element
const Color _feedbackBg = Color(0xFF0D3D1A);
// ignore: unused_element
const Color _feedbackText = Color(0xFFCFFFE0);

// ─────────────────────────────────────────────
//  SPACE BACKGROUND (green stars)
// ─────────────────────────────────────────────

class _Star {
  final double x, y, radius, opacity;
  const _Star(this.x, this.y, this.radius, this.opacity);
}

class SpaceBackgroundPainter extends CustomPainter {
  final List<_Star> stars;
  final List<Color> starColors;
  SpaceBackgroundPainter(this.stars,
      {this.starColors = const [Color(0xFF39FF7A), Color(0xFF00FF5E)]});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF020B10),
          Color(0xFF041A14),
          Color(0xFF050D08),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bg);

    for (final s in stars) {
      final Paint p = Paint()
        ..color = Color.lerp(starColors[0], starColors[1], s.opacity)!
            .withOpacity(s.opacity * 0.9 + 0.1);
      canvas.drawCircle(
        Offset(s.x * size.width, s.y * size.height),
        s.radius,
        p,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SpaceBackground extends StatefulWidget {
  final Widget child;
  final List<Color> starColors;
  const SpaceBackground({
    super.key,
    required this.child,
    this.starColors = const [Color(0xFF39FF7A), Color(0xFF00FF5E)],
  });

  @override
  State<SpaceBackground> createState() => _SpaceBackgroundState();
}

class _SpaceBackgroundState extends State<SpaceBackground>
    with SingleTickerProviderStateMixin {
  late final List<_Star> _stars;
  late final AnimationController _twinkle;

  @override
  void initState() {
    super.initState();
    final rng = Random(42);
    _stars = List.generate(180, (_) {
      return _Star(
        rng.nextDouble(),
        rng.nextDouble(),
        rng.nextDouble() * 1.6 + 0.3,
        rng.nextDouble() * 0.7 + 0.3,
      );
    });
    _twinkle = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _twinkle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _twinkle,
      builder: (_, __) => Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
              painter: SpaceBackgroundPainter(_stars,
                  starColors: widget.starColors)),
          widget.child,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  MAIN ENTRY – BookQuizPage
// ─────────────────────────────────────────────

// ✅ Normaliza apóstrofos tipográficos (’ U+2019) a estándar (' U+0027)
// y convierte a minúsculas para un lookup robusto sin importar la fuente.
String _normalizeTitle(String title) => title
    .replaceAll(RegExp(r"[^\w\s]"), ' ')
    .replaceAll(RegExp(r'\s+'), ' ')
    .toLowerCase()
    .trim();

final Map<String, BookQuizData> _bookQuizMapNormalized = {
  for (final entry in bookQuizMap.entries)
    _normalizeTitle(entry.key): entry.value,
};

class BookQuizPage extends StatelessWidget {
  final String bookTitle;

  const BookQuizPage({super.key, required this.bookTitle});

  @override
  Widget build(BuildContext context) {
    final data = _bookQuizMapNormalized[_normalizeTitle(bookTitle)];
    if (data == null) {
      // No quiz found — go straight to the result/completion screen
      // ignore: avoid_print
      print('[BookQuizPage] No quiz found for title: "$bookTitle" (normalized: "${_normalizeTitle(bookTitle)}")');
      return _QuizFlow(
        data: BookQuizData(
          bookTitle: bookTitle,
          thinkAbout: '',
          question: '',
          options: ['', '', '', ''],
          correctIndex: 0,
          explanation: '',
          wrongExplanation: '',
        ),
        skipToResult: true,
      );
    }
    return _QuizFlow(data: data);
  }
}

// ─────────────────────────────────────────────
//  QUIZ FLOW CONTROLLER
// ─────────────────────────────────────────────

enum _QuizStep { thinkAbout, question, result }

class _QuizFlow extends StatefulWidget {
  final BookQuizData data;
  final bool skipToResult;
  const _QuizFlow({required this.data, this.skipToResult = false});

  @override
  State<_QuizFlow> createState() => _QuizFlowState();
}

class _QuizFlowState extends State<_QuizFlow> {
  late _QuizStep _step;
  int _attemptsLeft = 2;
  int? _lastChosen;
  bool _showCorrect = false;

  late final _BookCategory _category;
  late final Color _accent;
  late final Color _bgCard;
  late final List<Color> _starColors;

  @override
  void initState() {
    super.initState();
    _step = widget.skipToResult ? _QuizStep.result : _QuizStep.thinkAbout;
    _category = _categoryForTitle(widget.data.bookTitle);
    _accent = _accentForCategory(_category);
    _bgCard = _bgForCategory(_category);
    _starColors = _starColorsForCategory(_category);
  }

  void _onAnswerChosen(int idx) {
    setState(() {
      _lastChosen = idx;
      final correct = idx == widget.data.correctIndex;
      if (correct || _attemptsLeft == 1) {
        _attemptsLeft = 0;
        _showCorrect = true;
      } else {
        _attemptsLeft--;
        _showCorrect = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpaceBackground(
        starColors: _starColors,
        child: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, anim) =>
                FadeTransition(opacity: anim, child: child),
            child: switch (_step) {
              _QuizStep.thinkAbout => _ThinkAboutScreen(
                  key: const ValueKey('think'),
                  data: widget.data,
                  accent: _accent,
                  bgCard: _bgCard,
                  onContinue: () => setState(() => _step = _QuizStep.question),
                ),
              _QuizStep.question => _QuestionScreen(
                  key: const ValueKey('question'),
                  data: widget.data,
                  attemptsLeft: _attemptsLeft,
                  lastChosen: _lastChosen,
                  showCorrect: _showCorrect,
                  accent: _accent,
                  bgCard: _bgCard,
                  onAnswerChosen: _onAnswerChosen,
                  onFinish: () => setState(() => _step = _QuizStep.result),
                ),
              _QuizStep.result => _ResultScreen(
                  key: const ValueKey('result'),
                  bookTitle: widget.data.bookTitle,
                  accent: _accent,
                  bgCard: _bgCard,
                ),
            },
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  SCREEN 1 – Think About
// ─────────────────────────────────────────────

class _ThinkAboutScreen extends StatefulWidget {
  final BookQuizData data;
  final VoidCallback onContinue;
  final Color accent;
  final Color bgCard;
  const _ThinkAboutScreen({
    super.key,
    required this.data,
    required this.onContinue,
    required this.accent,
    required this.bgCard,
  });

  @override
  State<_ThinkAboutScreen> createState() => _ThinkAboutScreenState();
}

class _ThinkAboutScreenState extends State<_ThinkAboutScreen>
    with TickerProviderStateMixin {
  late final AnimationController _fadeCtrl;
  late final AnimationController _btnCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _btnAnim;
  late final Animation<Offset> _btnSlide;

  @override
  void initState() {
    super.initState();

    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _btnCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);

    _btnAnim = CurvedAnimation(parent: _btnCtrl, curve: Curves.elasticOut);
    _btnSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _btnCtrl, curve: Curves.easeOutCubic));

    _fadeCtrl.forward();
    Future.delayed(const Duration(milliseconds: 600), () => _btnCtrl.forward());
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _btnCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Scrollable content ──
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: FadeTransition(
              opacity: _fadeAnim,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: widget.bgCard,
                      borderRadius: BorderRadius.circular(30),
                      border:
                          Border.all(color: widget.accent.withOpacity(0.4)),
                    ),
                    child: Text(
                      widget.data.bookTitle,
                      style: TextStyle(
                        color: widget.accent,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Critical Lens',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.auto_awesome,
                          color: widget.accent.withOpacity(0.7), size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'Put Your Critical Glasses On',
                        style: TextStyle(
                          color: widget.accent.withOpacity(0.7),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.4,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: widget.bgCard.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                          color: widget.accent.withOpacity(0.25)),
                      boxShadow: [
                        BoxShadow(
                          color: widget.accent.withOpacity(0.05),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(
                      widget.data.thinkAbout,
                      style: TextStyle(
                        color: widget.accent.withOpacity(0.85),
                        fontSize: 16,
                        height: 1.7,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),

        // ── "Now Answer" Button – always visible at bottom ──
        SlideTransition(
          position: _btnSlide,
          child: FadeTransition(
            opacity: _btnAnim,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Center(
                child: _GlowButton(
                  label: 'Now Answer',
                  icon: Icons.arrow_forward_rounded,
                  accentColor: widget.accent,
                  onTap: widget.onContinue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  SCREEN 2 – Question & Options
// ─────────────────────────────────────────────

class _QuestionScreen extends StatelessWidget {
  final BookQuizData data;
  final int attemptsLeft;
  final int? lastChosen;
  final bool showCorrect;
  final void Function(int) onAnswerChosen;
  final VoidCallback onFinish;
  final Color accent;
  final Color bgCard;

  const _QuestionScreen({
    super.key,
    required this.data,
    required this.attemptsLeft,
    required this.lastChosen,
    required this.showCorrect,
    required this.onAnswerChosen,
    required this.onFinish,
    required this.accent,
    required this.bgCard,
  });

  Color _optionColor(int idx) {
    if (lastChosen == null) return bgCard;
    if (showCorrect && idx == data.correctIndex)
      return const Color(0xFF0D4A1E); // green – always green for correct
    if (lastChosen == idx && !showCorrect)
      return const Color(0xFF3A1A00); // orange – wrong, tries left
    if (showCorrect && lastChosen == idx && idx != data.correctIndex)
      return const Color(0xFF3A0A0A); // red – wrong, out of tries
    return bgCard;
  }

  Color _optionBorder(int idx) {
    if (lastChosen == null) return accent.withOpacity(0.2);
    if (showCorrect && idx == data.correctIndex)
      return _feedbackAccent; // green – correct is always green
    if (lastChosen == idx && !showCorrect) return const Color(0xFFFF8C00);
    if (showCorrect && lastChosen == idx && idx != data.correctIndex)
      return const Color(0xFFFF3B3B);
    return accent.withOpacity(0.2);
  }

  IconData? _optionIcon(int idx) {
    if (lastChosen == null) return null;
    if (showCorrect && idx == data.correctIndex) return Icons.check_circle;
    if (showCorrect && lastChosen == idx && idx != data.correctIndex)
      return Icons.cancel;
    if (lastChosen == idx && !showCorrect) return Icons.warning_amber_rounded;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final labels = ['A', 'B', 'C', 'D'];
    final bool answered = lastChosen != null;
    final bool canStillAnswer = !showCorrect && attemptsLeft > 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Attempts indicator ──
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: accent, size: 18),
              const SizedBox(width: 8),
              Text(
                showCorrect ? 'Quiz complete' : 'Attempts left: $attemptsLeft',
                style: TextStyle(
                  color: showCorrect ? accent : accent.withOpacity(0.85),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),

          // ── Question ──
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: bgCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: accent.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: accent.withOpacity(0.06),
                  blurRadius: 18,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Text(
              data.question,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ── Options ──
          ...List.generate(data.options.length, (i) {
            final icon = _optionIcon(i);
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: (canStillAnswer || !answered) && !showCorrect
                    ? () => onAnswerChosen(i)
                    : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: _optionColor(i),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: _optionBorder(i), width: 1.5),
                  ),
                  child: Row(
                    children: [
                      // Label badge
                      Container(
                        width: 34,
                        height: 34,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: accent.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: accent.withOpacity(0.3)),
                        ),
                        child: Text(
                          labels[i],
                          style: TextStyle(
                            color: accent,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          data.options[i],
                          style: const TextStyle(
                            color: Color(0xFFE8E8E8),
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ),
                      if (icon != null) ...[
                        const SizedBox(width: 10),
                        Icon(icon,
                            color: showCorrect && i == data.correctIndex
                                ? const Color(0xFF39FF7A)
                                : const Color(0xFFFF4444),
                            size: 22),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),

          // ── Feedback ──
          if (answered) ...[
            const SizedBox(height: 12),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: showCorrect
                    ? const Color(0xFF0D3D1A)
                    : const Color(0xFF2A1500),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: showCorrect
                      ? const Color(0xFF39FF7A).withOpacity(0.5)
                      : const Color(0xFFFF8C00).withOpacity(0.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        showCorrect
                            ? Icons.check_circle_outline
                            : Icons.replay_rounded,
                        color: showCorrect
                            ? const Color(0xFF39FF7A)
                            : const Color(0xFFFF8C00),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        showCorrect
                            ? (lastChosen == data.correctIndex
                                ? '✓ Correct!'
                                : 'Answer Revealed')
                            : 'Not quite — try again!',
                        style: TextStyle(
                          color: showCorrect
                              ? const Color(0xFF39FF7A)
                              : const Color(0xFFFF8C00),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  if (showCorrect) ...[
                    const SizedBox(height: 10),
                    Text(
                      '✓ Correct Answer: ${[
                        'A',
                        'B',
                        'C',
                        'D'
                      ][data.correctIndex]}',
                      style: const TextStyle(
                        color: Color(0xFF39FF7A),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data.explanation,
                      style: const TextStyle(
                        color: Color(0xFFCFFFE0),
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data.wrongExplanation,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.55),
                        fontSize: 13,
                        height: 1.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],

          // ── Finish button ──
          if (showCorrect) ...[
            const SizedBox(height: 28),
            Center(
              child: _GlowButton(
                label: 'Finish',
                icon: Icons.auto_awesome,
                accentColor: accent,
                onTap: onFinish,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  SCREEN 3 – Result / Book Finalized
// ─────────────────────────────────────────────

class _ResultScreen extends StatefulWidget {
  final String bookTitle;
  final Color accent;
  final Color bgCard;
  const _ResultScreen(
      {super.key,
      required this.bookTitle,
      required this.accent,
      required this.bgCard});

  @override
  State<_ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<_ResultScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pulse;
  late final AnimationController _fade;
  late final Animation<double> _scale;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200))
      ..repeat(reverse: true);
    _fade = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..forward();

    _scale = Tween<double>(begin: 0.94, end: 1.06).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );
    _fadeAnim = CurvedAnimation(parent: _fade, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _pulse.dispose();
    _fade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Glowing star icon
              ScaleTransition(
                scale: _scale,
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.bgCard,
                    boxShadow: [
                      BoxShadow(
                        color: widget.accent.withOpacity(0.45),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                    border: Border.all(
                      color: widget.accent.withOpacity(0.6),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color: widget.accent,
                    size: 52,
                  ),
                ),
              ),
              const SizedBox(height: 36),
              const Text(
                'Book Finalized.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                widget.bookTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.accent,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'You have completed the reading\nand the critical thinking challenge.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 48),
              _GlowButton(
                label: 'Back to Library',
                icon: Icons.library_books_outlined,
                accentColor: widget.accent,
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  REUSABLE GLOW BUTTON
// ─────────────────────────────────────────────

class _GlowButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color accentColor;

  const _GlowButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.accentColor = const Color(0xFF39FF7A),
  });

  @override
  Widget build(BuildContext context) {
    // Derive a dark gradient base from the accent
    final Color dark = Color.lerp(accentColor, Colors.black, 0.65)!;
    final Color darker = Color.lerp(accentColor, Colors.black, 0.80)!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [dark, darker],
          ),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.35),
              blurRadius: 22,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: accentColor.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 10),
            Icon(icon, color: accentColor, size: 20),
          ],
        ),
      ),
    );
  }
}