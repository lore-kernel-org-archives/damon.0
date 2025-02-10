Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF0624E4A3
	for <damon@lists.linux.dev>; Mon, 10 Feb 2025 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216350; cv=none; b=Uz/IJSjuHDWRopHXgE3/NFjisamjY11GY03zud2NnfV7xvJn+ElPH7gKvV/1XFySZPCKADTEvK2gY14SwvlQP5ZLt1q1bL6ER2eNX8boMzeuhOuG2ZXmSYim1RKIzwk6+Ihr6R9kLdYEHigAZMm7vWFvJmw8WUefrXBPP7FSYig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216350; c=relaxed/simple;
	bh=eeTQic3U3Pz3ShuuvH4rmh3qdHr2tcndU+mn29E8LNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Vik9vT6SVOhibCMJvIZxdUHcsvPRLiw+lFypkBYGckhABgrA1IutpLCqzdfzpradICWd3UXlx3zENB1jVAc65Tgj0/ZxT4Sk1LM2k10Z56ji/a9N9lpYBlnvmuw81WJIapjIuN9w0KoSAcV6H6/MkSvSuwVuEIt42kGEUV/x2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0C6cHo9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0C6cHo9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNpxFEEEyxoH6lwF3K+DQE9+aA/s7jzY02gjXCRiBPg=;
	b=R0C6cHo9xiELOwib0BSdYZWHPWP/+CawS6tLrr0OZLe1xuFjpTtgCAlMV+Efv+ONa+6F7e
	JaHvaDxTGY77rbOOQuys5u6epH0tDzvGIMphU8F4U4V6y/M4Jp0I/beiP/oY4U1GSBJn81
	XOnrKo7vJUFYdPHi5wLXtcN10A//vAM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-n8XEeVOwOCuEcE00jbFJ1A-1; Mon, 10 Feb 2025 14:39:03 -0500
X-MC-Unique: n8XEeVOwOCuEcE00jbFJ1A-1
X-Mimecast-MFC-AGG-ID: n8XEeVOwOCuEcE00jbFJ1A
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dcc9653caso862366f8f.2
        for <damon@lists.linux.dev>; Mon, 10 Feb 2025 11:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216342; x=1739821142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNpxFEEEyxoH6lwF3K+DQE9+aA/s7jzY02gjXCRiBPg=;
        b=jnm/Iw5zyTv8pgBtCisRqFMrblaJRjiYCKNLbrJQ5AK97iwdZaNvJFVj52f7v/xUr6
         4edwaBUvYVuGO8oy+TpbfM0wbUrV3lm++anFC4JsBCI0jxffO6RoRE6qmMTp9hiMgSWv
         cgoY0CBFfPI0bVdKe/HXomXIR35B+eLDjAjyUIJ2xrUFHGHnlS0t2PjnSHkNIelzVU5o
         9dqjEFfcRuroRVB5B1LYT7PpGtIb4V7PGfyk5zO9Y4vmBvCCn2OVgaAxwWXOML8/2gWz
         kPJ1etUUYFAeMyrPWBVtV7WjjYZXAgkDTgumXWw5n+emIru7FZmrhLJHwfhdasOMVlSx
         YwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNyuRRf8AGqPkIl5Ea0nKDpoBBe87cRh0UWmv3r29VD4tqXQ/CvlYudnkoUcN6Aq4lrLHGJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSkwxEB6i7qP5fvf9KFDYjjLQnnHEJtVyxUie+Uk9HDnPx7cQI
	68haQSrP3IsEv/RfU+HXCYYngmqXnd94uLhS9RH8R1u6nYn5dc8yulUroARe7GtISDi4U7vhyzJ
	M2MBkHp0dLhHzVqnu88mnhexenLaNF0t+WZRHvh9/dFvPxqxRiTow
X-Gm-Gg: ASbGncs1kaRm9litWOHaLHTpgIBp89frOEmPUUsj8xTpNOk+UXtWbggv0muO2VwuUCM
	nJGKgEji6yrl2p5oMipM5epHtnQs5JEtKScFBONjurBeYHJFszgt1iGQS/L8UYZ17hwkBs6/cIS
	Wiylj02GbJMkmsxZgkKQJfEeu2KkicF2oSqQyCmaub/Pw12ol4jk5s8Vb4sPwJlQLy02/pXu1pT
	vjX3cqENcP7Wua9y8AiVPU4VPaG2KiJVl+PduOPZ34/XuzfVmipS+eKJhA+ealAtxSfRy0fWbJw
	2qPVrSlEN82HPMB3ajyYRS+R2eKhGJ93tOa83wqVJgHdiPhYCg133eJtAtwtMZ2cJQ==
X-Received: by 2002:a05:6000:1813:b0:38a:418e:21c7 with SMTP id ffacd0b85a97d-38dc935246fmr8277014f8f.53.1739216342059;
        Mon, 10 Feb 2025 11:39:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTiiTPkwAyfuLx0qL+LO6PapdaXuVNjUwBeGg/Z0ah/0RffyIckymQJ3LkKa1NUzxInLX6yQ==
X-Received: by 2002:a05:6000:1813:b0:38a:418e:21c7 with SMTP id ffacd0b85a97d-38dc935246fmr8276996f8f.53.1739216341643;
        Mon, 10 Feb 2025 11:39:01 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dc4d00645sm11916376f8f.66.2025.02.10.11.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:39:00 -0800 (PST)
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
Subject: [PATCH v2 15/17] mm/damon: handle device-exclusive entries correctly in damon_folio_mkold_one()
Date: Mon, 10 Feb 2025 20:37:57 +0100
Message-ID: <20250210193801.781278-16-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: t0xc0syungq99G2bPHMjCvYjm3aF2hvG87u2kkI7DgI_1739216342
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Ever since commit b756a3b5e7ea ("mm: device exclusive memory access")
we can return with a device-exclusive entry from page_vma_mapped_walk().

damon_folio_mkold_one() is not prepared for that and calls
damon_ptep_mkold() with PFN swap PTEs. Teach damon_ptep_mkold() to deal
with these PFN swap PTEs. Note that device-private entries are so far not
applicable on that path, as damon_get_folio() filters out non-lru
folios.

Should we just skip PFN swap PTEs completely? Possible, but it seems
straight forward to just handle it correctly.

Note that we could currently only run into this case with
device-exclusive entries on THPs. We still adjust the mapcount on
conversion to device-exclusive; this makes the rmap walk
abort early for small folios, because we'll always have
!folio_mapped() with a single device-exclusive entry. We'll adjust the
mapcount logic once all page_vma_mapped_walk() users can properly
handle device-exclusive entries.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/damon/ops-common.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index d25d99cb5f2bb..86a50e8fbc806 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -9,6 +9,8 @@
 #include <linux/page_idle.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 
 #include "ops-common.h"
 
@@ -39,12 +41,29 @@ struct folio *damon_get_folio(unsigned long pfn)
 
 void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
 {
-	struct folio *folio = damon_get_folio(pte_pfn(ptep_get(pte)));
+	pte_t pteval = ptep_get(pte);
+	struct folio *folio;
+	bool young = false;
+	unsigned long pfn;
+
+	if (likely(pte_present(pteval)))
+		pfn = pte_pfn(pteval);
+	else
+		pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
 
+	folio = damon_get_folio(pfn);
 	if (!folio)
 		return;
 
-	if (ptep_clear_young_notify(vma, addr, pte))
+	/*
+	 * PFN swap PTEs, such as device-exclusive ones, that actually map pages
+	 * are "old" from a CPU perspective. The MMU notifier takes care of any
+	 * device aspects.
+	 */
+	if (likely(pte_present(pteval)))
+		young |= ptep_test_and_clear_young(vma, addr, pte);
+	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE);
+	if (young)
 		folio_set_young(folio);
 
 	folio_set_idle(folio);
-- 
2.48.1

