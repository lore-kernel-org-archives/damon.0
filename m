Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815AA291C
	for <damon@lists.linux.dev>; Wed, 21 Dec 2022 18:09:59 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id gt4so16547767pjb.1
        for <damon@lists.linux.dev>; Wed, 21 Dec 2022 10:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PmJb6CIEqNY6rS2poozpptUa/GTiPJRR/qxOS9Vnc0=;
        b=nkDePdtCIPB0JT+k15LKJQpvT/NCX++WS8dNEXwSceLOrvzJbV5KnFSi/Q69IbR9m3
         pz0bbEASdkL5ZdY4gNIep4yTOxDqQn+6P2mNirIanQro8qY4+EtQs7/dTqDX5lFIhZ/n
         TAj3GOz59idRv9VjUz6+R5EikvGTM60+tFyZa7Efn6m94pwClx9r/IkHOqsvbxOBTehN
         2j8mpE/fJEO71UEk6LCm68MCU5C3Szk13jN/lj+xzg73aRLX4FQNK8M1K67QCFEsH8Ww
         rfmAhg4rTRNPdQSkZ0GXgSLs9nXLKoZKuvw6ULiCzpmc618r3bMtR9tPRASbUks1tuQx
         uUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PmJb6CIEqNY6rS2poozpptUa/GTiPJRR/qxOS9Vnc0=;
        b=0hJcuGPrombJXXD0RBQfmoRQ2aqlstrPQB2rdGNvAiAY8QSthnXlrzop8H4uUG89Rg
         TVmkkqfHTKJXqpYkBKRrrTDfJ6kfXMM0iToOdv48kP9+yexf/wTwiRFpAFGTOVprP4EF
         2qp5DmltJmDAQ5hO13QRjxj56A+lxaTwK8JZuLXajGcOxUwPvyZeMNZO3srM9LlIRwWa
         wF0gHS/7O9qZhsOHzBTd5MU+hXuzWqfllcCHezqlnc4JnzBskwgWAaOfRmpLuC9gRgUi
         a0w050NsZG4b9r9PaNnfHPk15Ky83gdJ6F2Z5rnRoKQchPnWIRpXdrX0CWkJW839HDNW
         /98Q==
X-Gm-Message-State: AFqh2kp5/LaLs6/KP5eXjZ3/J+R1+O6L4HW4fGpSpsonLYOFEPsmkpGc
	dcLfablIbAfCQFYzhigXClfRKmOpGDytJg==
X-Google-Smtp-Source: AMrXdXtca0fMprEg2pyoicfMqzT5In5Towl3radcXSD/IZnbSgXS2K9Z4XEmJtw7RR7DJxDDggCraQ==
X-Received: by 2002:a17:90a:fd09:b0:219:c40:e3c with SMTP id cv9-20020a17090afd0900b002190c400e3cmr2632387pjb.33.1671646198887;
        Wed, 21 Dec 2022 10:09:58 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id e26-20020a63745a000000b00477bfac06b7sm10110732pgn.34.2022.12.21.10.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 10:09:58 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	willy@infradead.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 1/4] mm/memory: Add vm_normal_folio()
Date: Wed, 21 Dec 2022 10:08:45 -0800
Message-Id: <20221221180848.20774-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221180848.20774-1-vishal.moola@gmail.com>
References: <20221221180848.20774-1-vishal.moola@gmail.com>
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
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ff46dcab2004..d29bfae4b71f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1968,6 +1968,8 @@ static inline bool can_do_mlock(void) { return false; }
 extern int user_shm_lock(size_t, struct ucounts *);
 extern void user_shm_unlock(size_t, struct ucounts *);
 
+struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
+			     pte_t pte);
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 37d1763c4d47..4000e9f017e0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -625,6 +625,16 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
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

