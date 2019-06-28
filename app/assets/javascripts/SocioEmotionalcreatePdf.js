    function geraPdf(nomeUsuario,nivel_text_cons_emoc,nivel_text_reg_emoc,nivel_text_cons_soc,nivel_text_aut_emoc,nivel_text_cria_emoc,sol_text_cons_emoc,sol_text_reg_emoc ) {
        var specialElementHandlers = {
        '#editor': function(element, renderer){
            return true;
        }
        }

        var doc = new jsPDF('p', 'pt' ,'letter');
        var elem = document.getElementById('tabela_resultados');
        var data = doc.autoTableHtmlToJson(elem);
        
        var ancora1text = "Você apresenta uma "+" "+ nivel_text_cons_emoc +" " + "capacidade de reconhecer e compreender os sentimentos e as emoções de si próprio e dos outros, além de manter uma atitude compassiva, de confiança mútua. Procure  " + sol_text_reg_emoc  + " a sua capacidade de agir com empatia nos relacionamentos e na tomada de decisão.";
        var text1 = doc.splitTextToSize(ancora1text,900);
         
         /*
        var ancora2text = "Você apresenta uma"+" "+ nivel_reg_emoc +" "+ " capacidade de manejar as emoções de forma adequada para manter um desempenho satisfatório em situações de estresse. Procure (desenvolver, melhorar, potencializar) a sua capacidade de se adaptar a situações de mudança com flexibilidade e lidar com as situações de pressão. ";
        var text2 = doc.splitTextToSize(ancora2text, 900);
        */

        var opts = {
            beforePageContent: function (data) {
                var text = "Competências Socioemocionais: " + nomeUsuario,
                xOffset = (doc.internal.pageSize.width / 2) - (doc.getStringUnitWidth(text) * doc.internal.getFontSize() / 2);
                doc.setFont("times");
                doc.setFontType("bold");
                doc.setFontSize(14);
                doc.text(text, xOffset, 20);
            },
            afterPageContent: function (data) {
                var competencia1 = "Competência Emocional", xOffset = (doc.internal.pageSize.width / 2) - (doc.getStringUnitWidth(ancora1Nome) * doc.internal.getFontSize() / 2);
                doc.setFontType("bold");
                doc.setFontSize(12);
                doc.text(competencia1, xOffset, doc.autoTableEndPosY() + 50);
                doc.setFontType("normal");
                doc.setFontSize(10);
                doc.text(20, doc.autoTableEndPosY() + 100, text1);
                doc.addPage();     
                           
                /*           
                var competencia2 = "Regulação Emocional", xOffset = (doc.internal.pageSize.width / 2) - (doc.getStringUnitWidth(ancora2Nome) * doc.internal.getFontSize() / 2);
                doc.setFontType("bold");
                doc.setFontSize(12);
                doc.text(competencia2, xOffset, 40);
                doc.setFontType("normal");
                doc.setFontSize(10);
                doc.text(20, 80, text2);

              
                var competencia3 = "Consciência Social", xOffset = (doc.internal.pageSize.width / 2) - (doc.getStringUnitWidth(ancora2Nome) * doc.internal.getFontSize() / 2);
                doc.setFontType("bold");
                doc.setFontSize(12);
                doc.text(competencia3, xOffset, 40);
                doc.setFontType("normal");
                doc.setFontSize(10);
                doc.text(20, 80, text3);

                var competencia4 = "Autocontrole Emocional", xOffset = (doc.internal.pageSize.width / 2) - (doc.getStringUnitWidth(ancora2Nome) * doc.internal.getFontSize() / 2);
                doc.setFontType("bold");
                doc.setFontSize(12);
                doc.text(competencia4, xOffset, 40);
                doc.setFontType("normal");
                doc.setFontSize(10);
                doc.text(20, 80, text4);

                var competencia5 = "Criatividade Emocional", xOffset = (doc.internal.pageSize.width / 2) - (doc.getStringUnitWidth(ancora2Nome) * doc.internal.getFontSize() / 2);
                doc.setFontType("bold");
                doc.setFontSize(12);
                doc.text(competencia5, xOffset, 40);
                doc.setFontType("normal");
                doc.setFontSize(10);
                doc.text(20, 80, text5); */


            }
        }

        doc.autoTable(data.columns, data.rows, opts);
        doc.save("table.pdf");

        }
