Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DBEA460
	for <damon@lists.linux.dev>; Thu,  8 Dec 2022 20:35:08 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so5859882pje.5
        for <damon@lists.linux.dev>; Thu, 08 Dec 2022 12:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YC6lmTEI2DddOWPjuQmefmlclj4ZLY2oiewxsoGP1Vs=;
        b=fvvYF98hTiJGOMFMCMtIoAJFjddR3ZNFHwcDPozFhzpj20s5sT2JGxRa4/JsoWeSxR
         27O4Hyx3dB8flhxlRct4WhUwoyuhQ4DZa0fBQViceKnlJwnt1M4STuay8S1ELwivT4W5
         JnFuebtJ/6heRA7futibraynFvgPzx5EmJuSPiVNpscBAw1y+0HX2KpqZedNdKX+q9A2
         G7EH4P2kHgqJ2MivIeUQpAIzYMbDFn5k7YjhM+D7xCoV9xRpKYOEzznz3w9NL3P1rsBw
         zHlmiEQdjCjKY6pWfRpw9uokV7ZAai9Fv9pxWmVWIiS+vtmSBZa5JyP1KGX34V0TBLnw
         9lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YC6lmTEI2DddOWPjuQmefmlclj4ZLY2oiewxsoGP1Vs=;
        b=kqAVHFlR3ubQWNvR7f6yOc3OYXrHYsPyeV/49yNOe5AKdPpE9Q6Lddlw1xD1zsv7pU
         3rFptWILmCJFqKuHb/W60cJ6zuim1t2aR9t7ka0vjlU7PGT93HXPBNP6c+RtygJJwaWF
         OilMS2CEIfL3NRhw3Hg4sOg+0Xe6ozztnVYsDA/sxHAfASWLV3lmUJbeohvsvxgus0l9
         ldD3aIaHgDGZ82UTO6A7cFjn802GJnBm3ZOIeUXNlFhzdYWzEqrToKhq8/Ak6xSG8fuB
         ochpS0NO91Zc1mb2RyXGonyMBMQaCQbHCnI0j0aniaMM7aT5D9y6w2HQhhL+PIUS9sFk
         dHgg==
X-Gm-Message-State: ANoB5pkKMsNNn6X02ggdOs1FO7VDWkr/VrbTiKREA4WH0O7kInfDj1cm
	InynCQeAZzxdzULIiMpaFV8=
X-Google-Smtp-Source: AA0mqf5DoA93piz5CVF9XnFBz7DCsU5iv2lttlOp9VDYowFUmIgZu7ivcuR8M/O6WoSa+05bardiCQ==
X-Received: by 2002:a17:902:6a8b:b0:186:fb8d:f4d3 with SMTP id n11-20020a1709026a8b00b00186fb8df4d3mr3201464plk.5.1670531707818;
        Thu, 08 Dec 2022 12:35:07 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id f5-20020a170902860500b00189951514c4sm16954349plo.206.2022.12.08.12.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:35:07 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 1/4] mm/memory: Add vm_normal_folio()
Date: Thu,  8 Dec 2022 12:35:00 -0800
Message-Id: <20221208203503.20665-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208203503.20665-1-vishal.moola@gmail.com>
References: <20221208203503.20665-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a wrapper function called vm_normal_folio(). This function
calls vm_normal_page() and returns the folio of the page found, or null
if no page is found.

This function allows callers to get a folio from a pte, which will
eventually allow them to completely replace their struct page variables
with struct folio instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc5565..626ae0757bd3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1860,6 +1860,8 @@ static inline bool can_do_mlock(void) { return false; }
 extern int user_shm_lock(size_t, struct ucounts *);
 extern void user_shm_unlock(size_t, struct ucounts *);
 
+struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
+			     pte_t pte);
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index f88c351aecd4..1247c19c516c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -672,6 +672,16 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 	return pfn_to_page(pfn);
 }
 
+struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
+			    pte_t pte)
+{
+	struct page *page = vm_normal_page(vma, addr, pte);
+
+	if (page)
+		return page_folio(page);
+	return NULL;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 				pmd_t pmd)
-- 
2.38.1

