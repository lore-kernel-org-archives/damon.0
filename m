Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC12512C7
	for <damon@lists.linux.dev>; Mon, 10 Feb 2025 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216352; cv=none; b=hStzw8yeuxctlzMhkfyPf6qv4YtXCn3MG+njBAIJzULxRKraGieF2h8yvjadgHzEzYlVtbTE80XcU2aDAGUpHwksdcI+cgf5dCtu45D3zEmwarF5K+2iMjjFhwuZWq2vLYoQGP620EHRrIZPFXoqcwacG/TLgCM0wHQTR4vgoIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216352; c=relaxed/simple;
	bh=zopD3ByQcw+T0PaGnkSFpwWr8v6nq8ox8511K+fI4zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RivYEsdEL9twU+x/63jb98MVPoAEGN4hN50tMz2UGZOiz/rQsDCdQFQb5o0ftG/JKCGYCkm/bHDGbjG14bcgA1iqYxVpXF04eBitrzMrq5m8ed4kDzri0/+ZyTCXeCU6iBSi0bg6newbxytFUwM4fM84f+pfKXZ0Mh7SQ0hEWIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/K882O+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/K882O+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5kPSWbMiVGXXHUJW6xa869lKm+zAgfCoOcPS4ARFgc=;
	b=Z/K882O+uYje65vEJ+OeuO8Gv7S/mXvQ0zNY1LDVg/6JNLYMPRPctnM6/xnRbvE9fK1Nka
	TZteW6UAIiFGmw3j/ISdKREW6mz3pweaYl7IA7IaWM/IPUao/vB6ckgWahsCpHpQwc3p84
	5yrlr/IOjfxN3a6cl5+9z6YbTcLwhC0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-oj82iChJPku-6354nY0rtg-1; Mon, 10 Feb 2025 14:39:07 -0500
X-MC-Unique: oj82iChJPku-6354nY0rtg-1
X-Mimecast-MFC-AGG-ID: oj82iChJPku-6354nY0rtg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43933eb7f7eso13412565e9.3
        for <damon@lists.linux.dev>; Mon, 10 Feb 2025 11:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216346; x=1739821146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5kPSWbMiVGXXHUJW6xa869lKm+zAgfCoOcPS4ARFgc=;
        b=pP/hkedjcnpgx3rvwVUZQ7FeimbFEciWaDXH33smTsg4fpG6RQJVKai/+F8cEc/rUj
         sdf++rvbB3BtKtSmGMb9y2OnlHL4l3C8Hs3e31RFpOm56+O2ZdxKbYJylkPFm9BSRVQw
         3BUEVm78rUYI9enHVkZOsm9yYJZvJjsUqBZOEv3ygwXHW4z36DJRbhepzQ2+UW9BU7kb
         QPrE3FQmchqfe+H5IRiktL5boQi6b7W43hxbt5mp1vrsQm7+vkXryDoEZopUEpAHTG3l
         oanZLLsz07FkkAAbyhNB8uk+3Y1LfbpGYa4xhnKsWesSwFY1lc3iG+LnKVoNwFi01CsK
         hQjg==
X-Forwarded-Encrypted: i=1; AJvYcCU7zntnnNbhIB512Fwg1XlD7T5IWfp39NvCYIR9l2J2tZA7pGz0vXgt62gfLjBcdo6CVJzrLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYKk9L+D+VAV5PmXlM23tuyXWHbRR2NVP3gAktYMnfymEhHJOE
	8fT3nEhJGSGiuZOIZUTcHtIQaOsKd5ivQG4bNV+g12wDRJqe8uKtSRu+vF90h062J71SPCv9y4i
	6r5TKGDPnu35LVEJ8VQOWkn4gze3mue60QFqq15+FR/Br5K0cKB7K
X-Gm-Gg: ASbGncvh71QJLhA5Cw5go5fILBy3NZ+kvgfZSnDx24rxTJ4mbipr67k11MwHsrOOVaW
	xLWK0ATY2HUlmyVrWUyN4SH2WUKXpqHmQ8ICrBh/hjP9WpRvIDk0YHxL1sS9F2I8dU9d8yER2l4
	GC0ubRuAUjHOEmcDkdTdJSCqxIBwaEHrkL3TWFJNbRIhIeLmEpHFsHNalYdQwiLgvjYrJGY6eL8
	TyjmIe0fzUiAX4KGGtz5q4vAuW3WmrU4gNOgnHNgh/e0kO9Ya5o7gGAFAbUiW7VUvq28hJxUsjb
	xd8MlM8M3rtHwWmgOldMkflEKivlEM/yQlRNB1a5LUB136o4uodSIJvPKj1iUONWFQ==
X-Received: by 2002:a05:600c:1913:b0:434:faa9:5266 with SMTP id 5b1f17b1804b1-43924991f73mr122648825e9.13.1739216345778;
        Mon, 10 Feb 2025 11:39:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0N2Q/3/pgsBEDUurQcQIsnMqE2C8UdYDG2bl1ZHVr+k7cZL7qtDol6R4B+8CggSnILo8JzA==
X-Received: by 2002:a05:600c:1913:b0:434:faa9:5266 with SMTP id 5b1f17b1804b1-43924991f73mr122648595e9.13.1739216345384;
        Mon, 10 Feb 2025 11:39:05 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dd9c48173sm5308677f8f.37.2025.02.10.11.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:39:04 -0800 (PST)
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
Subject: [PATCH v2 16/17] mm/rmap: keep mapcount untouched for device-exclusive entries
Date: Mon, 10 Feb 2025 20:37:58 +0100
Message-ID: <20250210193801.781278-17-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: S-v8GkVxMGt5WENbCL61hGBwtwTkxjnWwXMkmw9UXKM_1739216346
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now that conversion to device-exclusive does no longer perform an
rmap walk and all page_vma_mapped_walk() users were taught to
properly handle device-exclusive entries, let's treat device-exclusive
entries just as if they would be present, similar to how we handle
device-private entries already.

This fixes swapout/migration/split/hwpoison of folios with
device-exclusive entries.

We only had to take care of page_vma_mapped_walk() users, because these
traditionally assume pte_present(). Other page table walkers already
have to handle !pte_present(), and some of them might simply skip them
(e.g., MADV_PAGEOUT) if they are not specialized on them. This change
doesn't modify the latter.

Note that while folios with device-exclusive PTEs can now get migrated,
khugepaged will not collapse a THP if there is device-exclusive PTE.
Doing so might also not be desired if the device frequently performs
atomics to the same page. Similarly, KSM will never merge order-0 folios
that are device-exclusive.

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 17 +----------------
 mm/rmap.c   |  7 -------
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ba33ba3b7ea17..e9f54065b117f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -741,20 +741,6 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 
 	VM_BUG_ON_FOLIO(pte_write(pte) && (!folio_test_anon(folio) &&
 					   PageAnonExclusive(page)), folio);
-
-	/*
-	 * No need to take a page reference as one was already
-	 * created when the swap entry was made.
-	 */
-	if (folio_test_anon(folio))
-		folio_add_anon_rmap_pte(folio, page, vma, address, RMAP_NONE);
-	else
-		/*
-		 * Currently device exclusive access only supports anonymous
-		 * memory so the entry shouldn't point to a filebacked page.
-		 */
-		WARN_ON_ONCE(1);
-
 	set_pte_at(vma->vm_mm, address, ptep, pte);
 
 	/*
@@ -1626,8 +1612,7 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		 */
 		WARN_ON_ONCE(!vma_is_anonymous(vma));
 		rss[mm_counter(folio)]--;
-		if (is_device_private_entry(entry))
-			folio_remove_rmap_pte(folio, page, vma);
+		folio_remove_rmap_pte(folio, page, vma);
 		folio_put(folio);
 	} else if (!non_swap_entry(entry)) {
 		/* Genuine swap entries, hence a private anon pages */
diff --git a/mm/rmap.c b/mm/rmap.c
index 7b737f0f68fb5..e2a543f639ce3 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2511,13 +2511,6 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
 	/* The pte is writable, uffd-wp does not apply. */
 	set_pte_at(mm, addr, fw.ptep, swp_pte);
 
-	/*
-	 * TODO: The device-exclusive PFN swap PTE holds a folio reference but
-	 * does not count as a mapping (mapcount), which is wrong and must be
-	 * fixed, otherwise RMAP walks don't behave as expected.
-	 */
-	folio_remove_rmap_pte(folio, page, vma);
-
 	folio_walk_end(&fw, vma);
 	mmu_notifier_invalidate_range_end(&range);
 	*foliop = folio;
-- 
2.48.1

