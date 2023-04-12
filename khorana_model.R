
khorana_score <- function(cancer_type, platelet_ge_350, hemoglobin_l_10, leukocyte_ge_11, bmi_ge_35) {
  score <- 0
  if(cancer_type %in% c("Stomach", "Pancreas")) {
    score <- score + 2
  } else if(cancer_type %in% c("Lung", "Lymphoma", "Gynecology", "Bladder", "Testicular")) {
    score <- score + 1
  }
  score <- score + platelet_ge_350 + hemoglobin_l_10 + leukocyte_ge_11 + bmi_ge_35
  return(score)
}

khorana_rate <- function(cancer_type, platelet_ge_350, hemoglobin_l_10, leukocyte_ge_11, bmi_ge_35) {
  sc <- khorana_score(cancer_type, platelet_ge_350, hemoglobin_l_10, leukocyte_ge_11, bmi_ge_35)
  if(is.na(sc)) {
    return(NA)
  }
  if(sc == 0) {
    return("0.3 - 0.8%")
  } else if((sc >= 1) && (sc <= 2)) {
    return("1.8 - 2.0%")
  } else {
    return("6.7 - 7.1%")
  }
}

khorana_risk_group <- function(cancer_type, platelet_ge_350, hemoglobin_l_10, leukocyte_ge_11, bmi_ge_35) {
  sc <- khorana_score(cancer_type, platelet_ge_350, hemoglobin_l_10, leukocyte_ge_11, bmi_ge_35)
  if(is.na(sc)) {
    return(NA)
  }
  if(sc == 0) {
    return("Low")
  } else if((sc >= 1) && (sc <= 2)) {
    return("Intermediate")
  } else {
    return("High")
  }
}
