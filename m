Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCB124C687
	for <damon@lists.linux.dev>; Mon, 10 Feb 2025 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216328; cv=none; b=WOH8/5ubZ8zNBu1MC6mCUa58rlv3sF8WAznh8TVj9uPPSjuipi7K7NmOan5cDzeg2xk/w4AowGDCd8Rfs25IoH40bsHhcY/W24n7fP0zI/CE1NLXR/x2COH6RoYSZcbshd1q+QoUQJHLjYj4CAL1mjqJkGSX4/Wv24fh1uhrQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216328; c=relaxed/simple;
	bh=76d5pEBVKf4Yijczbwj7KuBibjsq0aAlESoqsTf2wbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=V0PWfybowd0dyXEiP/mSpjlc4J/aKRQEU/TPimU4M7u1VI9gEBb6cYUQclFaJo4KyJATmHKP2ih7wSNik2VnHWpBCm8vt1fPT6eASA90OS3qNXxKkFuyAYQPwT/cTNEV4wIrbos2maosbKRG0WLFo8dd9be4ijbunwQfREoeM/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkoRYmqQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkoRYmqQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sC+CKPivo9nJ2nwAVN+E4SAgEKJPEiCVQrD/mzwcqM=;
	b=dkoRYmqQIaCeuPU5KI/T3cOu7MBo0jNYaVvYCC/kER4W+pYIikQ9EPTkcwTmzux0Bi7zK1
	bAyiz7zFL/HEJNwkcl4e4yo2cisf2ysywMN76TY6si/fOqM5vnL/ARKjg8hkFxt5i1GbUW
	rS/2X1Z6ejRJhE1Zm2OB0dQHbpvjgxE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-ENZYDNQWPU2-aB-VWY6NNg-1; Mon, 10 Feb 2025 14:38:37 -0500
X-MC-Unique: ENZYDNQWPU2-aB-VWY6NNg-1
X-Mimecast-MFC-AGG-ID: ENZYDNQWPU2-aB-VWY6NNg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394c489babso2566095e9.1
        for <damon@lists.linux.dev>; Mon, 10 Feb 2025 11:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216315; x=1739821115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sC+CKPivo9nJ2nwAVN+E4SAgEKJPEiCVQrD/mzwcqM=;
        b=iKGCkQpk57dMAGR+BWxL78KbeX/lkYL7NQWhah79JNYzVLH4BK4X5MNKHoHReVYQ12
         0URZzZ6hr+UIu8uj85SctjJzzVOn5ItRPThlQawm38BJ+r0O/ipiCc5lkn5Aj5MmMCZk
         CFwDXkQ3jS7a2zLwnfyBRvCqyLukcR+XqlOH78tPfNMcTtSRjdTQOXzwoBEQ2LBqaUAO
         POehJdDLW8AIWR9+Ha4L+jhWESe5MQwCoSFasKpUmCll3ngpksL7NlLQLm1RcwSofOlY
         5t6TfV2DiqDrYullXbzxqX4UIWHObGxZmqdSQQBjHoqKOpE2WSFRWo8mXPR/tPNxspzP
         kRNw==
X-Forwarded-Encrypted: i=1; AJvYcCUn0PQDelZtywQRl+s2rjfWw7Q1ciTHgLZRV0rVksVOZA9TPRLOL2vnK5mO0eCmsmL3UfleQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLsb2Y2hlaTWHq/J9IDhIErcEhYJpxeEIWWvdd4Xl9zz25GDaL
	YzewypVl0/ZZ9Q9eaE6+TPreL18K5HaGr7COkzKj6F6giIrtb96z3WPu7ijP6SfsqDFai1Um4T5
	ArHy+usrVc63w+qXTClCI3uUch1WWKNA/XEFv021geL+5eZ7KYiAv
X-Gm-Gg: ASbGncv/2uGWR0Ng7EoC8Zyie7vo3DaMwH1TivDguaQfJx8DpTvwZDXnLBaVZIaTHOG
	tWrnLvCE3/3+f9HuQ41+BQlSLMPXIryS720BgNxVbyiSIQKrMYwy8YQT6fyRTbvs/sMeElwstzo
	P3DaxQFs6mV4NnFE6btvc0ZSDQ71OVXbTmDl485IlXdf2QHAcFC2To8MdN3+3ruXtRryCYXlkpO
	yRcgLBGSrnSiR6l/ziCwCLOOhRmDOrJGZNsd9kdsM9jMwD95IQqZ/OFtQ+4BBj6TonEVN5RwkR0
	6adPWq1zji5Qzm8YXAQV+7M70rRvhKk0xgB16UCQriLMg2jjwVe7qte/hxSEJUKKPA==
X-Received: by 2002:a05:600c:4e91:b0:439:4637:9d9 with SMTP id 5b1f17b1804b1-43946370d97mr43287615e9.12.1739216315630;
        Mon, 10 Feb 2025 11:38:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6B7q2dhfsb9dj8LY+8M1CJU6DFUQTZK7m2VERaPDmly8AB+qIiZRItOcPeyw5uy4LKosd2g==
X-Received: by 2002:a05:600c:4e91:b0:439:4637:9d9 with SMTP id 5b1f17b1804b1-43946370d97mr43287075e9.12.1739216315147;
        Mon, 10 Feb 2025 11:38:35 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4390d94d802sm195260345e9.12.2025.02.10.11.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:33 -0800 (PST)
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
Subject: [PATCH v2 08/17] kernel/events/uprobes: handle device-exclusive entries correctly in __replace_page()
Date: Mon, 10 Feb 2025 20:37:50 +0100
Message-ID: <20250210193801.781278-9-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: DT3sIiEQvgCxipVMXffYVumnhvrE0Tsu0kWB9SGHZHE_1739216316
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Ever since commit b756a3b5e7ea ("mm: device exclusive memory access")
we can return with a device-exclusive entry from page_vma_mapped_walk().

__replace_page() is not prepared for that, so teach it about these
PFN swap PTEs. Note that device-private entries are so far not
applicable on that path, because GUP would never have returned such
folios (conversion to device-private happens by page migration, not
in-place conversion of the PTE).

There is a race between GUP and us locking the folio to look it up
using page_vma_mapped_walk(), so this is likely a fix (unless something
else could prevent that race, but it doesn't look like). pte_pfn() on
something that is not a present pte could give use garbage, and we'd
wrongly mess up the mapcount because it was already adjusted by calling
folio_remove_rmap_pte() when making the entry device-exclusive.

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/events/uprobes.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2ca797cbe465f..cd6105b100325 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -173,6 +173,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	DEFINE_FOLIO_VMA_WALK(pvmw, old_folio, vma, addr, 0);
 	int err;
 	struct mmu_notifier_range range;
+	pte_t pte;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, addr,
 				addr + PAGE_SIZE);
@@ -192,6 +193,16 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	if (!page_vma_mapped_walk(&pvmw))
 		goto unlock;
 	VM_BUG_ON_PAGE(addr != pvmw.address, old_page);
+	pte = ptep_get(pvmw.pte);
+
+	/*
+	 * Handle PFN swap PTES, such as device-exclusive ones, that actually
+	 * map pages: simply trigger GUP again to fix it up.
+	 */
+	if (unlikely(!pte_present(pte))) {
+		page_vma_mapped_walk_done(&pvmw);
+		goto unlock;
+	}
 
 	if (new_page) {
 		folio_get(new_folio);
@@ -206,7 +217,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 		inc_mm_counter(mm, MM_ANONPAGES);
 	}
 
-	flush_cache_page(vma, addr, pte_pfn(ptep_get(pvmw.pte)));
+	flush_cache_page(vma, addr, pte_pfn(pte));
 	ptep_clear_flush(vma, addr, pvmw.pte);
 	if (new_page)
 		set_pte_at(mm, addr, pvmw.pte,
-- 
2.48.1

