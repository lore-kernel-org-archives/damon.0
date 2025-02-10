Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C7824C66F
	for <damon@lists.linux.dev>; Mon, 10 Feb 2025 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216327; cv=none; b=GL1bI3CS6bP7u80vkUsrZQf4Atidxrj4kCQE5A0l1AUmOWrT0igDHVZcPrO09Lj5AX8Cp7bsfbs9/PURXUiummFnNLwDXf28XncqyU8ZDSnc4YXgHf/r/Q84hWijXP7Pqg52+2RqBfUccezixYfvBW28Bd8vfoIo5szIH+/+BCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216327; c=relaxed/simple;
	bh=wTEfnlnRBIWds4A4VWjgD0zaJLq1iJwNdx86V2VqPGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=BKPLS4UNq3/CLPJHTzi/07OAGkV9LgcC/7ZQFml2w2GOwqb8yTjg1du0HRyY0GSC/ethsJ3p7E52aS4h/Xlh2UqHSqP+V4KPc6u/Ex/KB4bMNKRD4Cr7jpmxkQoPCmg2BlMGYpsE8KOup47c0J2xvPxGXkdVnsZaa0pqmgP1/QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7+Hv9qA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7+Hv9qA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvU1uLGkpTPZRA0QaV3EggyJAUMnys9Fj6An1hzKeYY=;
	b=S7+Hv9qATbgD7eU6BGWJHQtjFg/XvWB5bxFfUvSqvsOhtRdcEE4IeNgiClOMF31rNHIsEG
	P3IclXPcm/3yAy8TpJcR7uPWWc8jYMJuSkC+S2LCDxm01ykS8d4CFcyeFxTJ9lDHvH/Ymv
	F1F/6HsUs6VtGKyFIiYYc8ITAqq2JEU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-EevRUv1mMtGoI-DdzYzkWw-1; Mon, 10 Feb 2025 14:38:43 -0500
X-MC-Unique: EevRUv1mMtGoI-DdzYzkWw-1
X-Mimecast-MFC-AGG-ID: EevRUv1mMtGoI-DdzYzkWw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43933b8d9b1so12562045e9.3
        for <damon@lists.linux.dev>; Mon, 10 Feb 2025 11:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216322; x=1739821122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvU1uLGkpTPZRA0QaV3EggyJAUMnys9Fj6An1hzKeYY=;
        b=IFCXkMIsyKXA8Q+sMWPm9gXXEGa16Z3czea0yQMRAZwLp5/surOPnpOCieSkaHcqM9
         /KNToSeUvAGJA8H13l+0J1nxH3m3n2fliLTVp1zTUGsTFXnitqrmY96xbESRGeL3qLr6
         1sXCcHZ6CpDXwdbDRyeYElF94a5t567RPzvSX4vno+BgP4b3fYR5X5V1JGMOH8HNxrEv
         fTmHUnhuJTh8Qwxz7rKJnbGFV7vSzdlGftHl0ZxVpqBExqNwoifNyJ/3op2m+QSsjmDW
         56SmhFCAkwXIkVoTmPAp+5PQmo3OOA0414ptI2jYBQwuc29Yfu/zpNe7hW4zjJbZ2zFb
         oeew==
X-Forwarded-Encrypted: i=1; AJvYcCVidocfZIDjWbXduB4+I/EzQJyiTpTVEgc4IbJAQhcqAbDvvguKUbNE7AbrJN5Q0l4rrt52jw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPyKz/wypW7P45PNXZuL5TaVBO/kQ/FHx0KTEKiQuCQfMHAjNZ
	K8oe4QKo+ZUXUxm+WtMGkhWByePyRh41rTv7jKjLmwCvOeomfkdHQn+PNPeoYi7rPavzUgI8yQ7
	ixFlA14xF/w+hejm3+ShrQEaPfo5QxrlD2Iwl5iBUOVZAbMDm5LRP
X-Gm-Gg: ASbGncv1SXjfF+u+TssY1PN2EBoMaKQMRv6H0VkzP3I3BPuNRhnwojHtli2LI879JBx
	Shsrz1Svv3bkubn45RENJF57Q07xC1T9SiJIAY9kdmZvDx9+I1FydQq4366mAYZ/sfrmT1ZkAVh
	KLi2KR3CPqaWJ3mSJ219noV6Ao6fCzd23lFcHVpsSZhANdUADj9Ri6K0sskvmS3tmee0VnYHLn/
	kSJCm0p8xEjHXSfv8oftdZ5wKI3SOPiV9GW35tugpbDwPwTKhuvt6mZVxlYz3bG4bRUIK++ph9s
	EqiF6aFY++E69DmkrgI9Zk5rCGmXJiJT3CoenNysepPrjt787GXxQf1FJipeyuNeVQ==
X-Received: by 2002:a05:600c:1e0e:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-439249889a8mr117196015e9.8.1739216322483;
        Mon, 10 Feb 2025 11:38:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjSKW3zWL6vzVGiNBIPirrt7XpGCC7ElTlo8fIz4HKSkBODD3ovt81FL+SvLTQ6DCkqg1UrQ==
X-Received: by 2002:a05:600c:1e0e:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-439249889a8mr117195855e9.8.1739216321998;
        Mon, 10 Feb 2025 11:38:41 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38ddaf333c5sm5084761f8f.36.2025.02.10.11.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:40 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	nouveau@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	damon@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Xu <peterx@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 10/17] mm/rmap: handle device-exclusive entries correctly in try_to_unmap_one()
Date: Mon, 10 Feb 2025 20:37:52 +0100
Message-ID: <20250210193801.781278-11-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210193801.781278-1-david@redhat.com>
References: <20250210193801.781278-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1Zvt5660FNMNQbojnCjXtRULvex5ZGg9lUZRzSpjTXk_1739216322
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Ever since commit b756a3b5e7ea ("mm: device exclusive memory access")
we can return with a device-exclusive entry from page_vma_mapped_walk().

try_to_unmap_one() is not prepared for that, so teach it about these
PFN swap PTEs. Note that device-private entries are so far not
applicable on that path, as we expect ZONE_DEVICE pages so far only in
migration code when it comes to the RMAP.

Note that we could currently only run into this case with
device-exclusive entries on THPs. We still adjust the mapcount on
conversion to device-exclusive; this makes the rmap walk
abort early for small folios, because we'll always have
!folio_mapped() with a single device-exclusive entry. We'll adjust the
mapcount logic once all page_vma_mapped_walk() users can properly
handle device-exclusive entries.

Further note that try_to_unmap() calls MMU notifiers and holds the
folio lock, so any device-exclusive users should be properly prepared
for a device-exclusive PTE to "vanish".

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 52 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 1129ed132af94..47142a656ae51 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1648,9 +1648,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	bool anon_exclusive, ret = true;
 	pte_t pteval;
 	struct page *subpage;
-	bool anon_exclusive, ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 	unsigned long pfn;
@@ -1722,7 +1722,18 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
 
-		pfn = pte_pfn(ptep_get(pvmw.pte));
+		/*
+		 * Handle PFN swap PTEs, such as device-exclusive ones, that
+		 * actually map pages.
+		 */
+		pteval = ptep_get(pvmw.pte);
+		if (likely(pte_present(pteval))) {
+			pfn = pte_pfn(pteval);
+		} else {
+			pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
+			VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+		}
+
 		subpage = folio_page(folio, pfn - folio_pfn(folio));
 		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
@@ -1778,7 +1789,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				hugetlb_vma_unlock_write(vma);
 			}
 			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
-		} else {
+			if (pte_dirty(pteval))
+				folio_mark_dirty(folio);
+		} else if (likely(pte_present(pteval))) {
 			flush_cache_page(vma, address, pfn);
 			/* Nuke the page table entry. */
 			if (should_defer_flush(mm, flags)) {
@@ -1796,6 +1809,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
+			if (pte_dirty(pteval))
+				folio_mark_dirty(folio);
+		} else {
+			pte_clear(mm, address, pvmw.pte);
 		}
 
 		/*
@@ -1805,10 +1822,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		 */
 		pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);
 
-		/* Set the dirty flag on the folio now the pte is gone. */
-		if (pte_dirty(pteval))
-			folio_mark_dirty(folio);
-
 		/* Update high watermark before we lower rss */
 		update_hiwater_rss(mm);
 
@@ -1822,8 +1835,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				dec_mm_counter(mm, mm_counter(folio));
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
-
-		} else if (pte_unused(pteval) && !userfaultfd_armed(vma)) {
+		} else if (likely(pte_present(pteval)) && pte_unused(pteval) &&
+			   !userfaultfd_armed(vma)) {
 			/*
 			 * The guest indicated that the page content is of no
 			 * interest anymore. Simply discard the pte, vmscan
@@ -1902,6 +1915,12 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				goto walk_abort;
 			}
+
+			/*
+			 * arch_unmap_one() is expected to be a NOP on
+			 * architectures where we could have PFN swap PTEs,
+			 * so we'll not check/care.
+			 */
 			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
 				swap_free(entry);
 				set_pte_at(mm, address, pvmw.pte, pteval);
@@ -1926,10 +1945,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			swp_pte = swp_entry_to_pte(entry);
 			if (anon_exclusive)
 				swp_pte = pte_swp_mkexclusive(swp_pte);
-			if (pte_soft_dirty(pteval))
-				swp_pte = pte_swp_mksoft_dirty(swp_pte);
-			if (pte_uffd_wp(pteval))
-				swp_pte = pte_swp_mkuffd_wp(swp_pte);
+			if (likely(pte_present(pteval))) {
+				if (pte_soft_dirty(pteval))
+					swp_pte = pte_swp_mksoft_dirty(swp_pte);
+				if (pte_uffd_wp(pteval))
+					swp_pte = pte_swp_mkuffd_wp(swp_pte);
+			} else {
+				if (pte_swp_soft_dirty(pteval))
+					swp_pte = pte_swp_mksoft_dirty(swp_pte);
+				if (pte_swp_uffd_wp(pteval))
+					swp_pte = pte_swp_mkuffd_wp(swp_pte);
+			}
 			set_pte_at(mm, address, pvmw.pte, swp_pte);
 		} else {
 			/*
-- 
2.48.1

