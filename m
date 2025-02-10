Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30012505BE
	for <damon@lists.linux.dev>; Mon, 10 Feb 2025 19:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216344; cv=none; b=EWYz33i/OpnNpuGtq7Ax/c8yE8eu/xmr+Tae76xxYEoAMlpqrLwwW8I5J9UzpU5c+zvN6uXibIlk96HSBmhHeeDzXBIVqXxnhO4/8S9V1HFyAlgFdZ+lGB7B8rpsuCL2AhOAEWKjLnjIjPjvAfWxeugZBVPYQ7/fsNhyT6YNco0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216344; c=relaxed/simple;
	bh=xdb/Bd8nabay5U0SQXbchR0hBzNIzuX4jtY3vE4Olv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FV1zKej9Sw5qsk90ShqZK6TpgkJcouUUGI/QfFMiX/A1SBSXafyNDPeSbUgqnjeKYgeqzfYLch+yICJk1L22rWy7PW+vFdSFi/zIZbta+h36+yathpw+/7O4OkEs1NiI5R0nHiCX5/I8Ne/WU8m6ukPYgh59CTW/dN/hnNFUfzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZoGbIB9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZoGbIB9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oE9Ja/aC61CHup4qeT96Odiagg40Q7TPEFXRUvHwXRo=;
	b=IZoGbIB9p5VJ1F8sDEQ6K8+ewsKkSMz8IJiiiHbZ9Hjs5SCHJy2fipNgOx98WmCDWO620S
	RTKakGXf1IniOx3l6F+Wo3waMo9IdOPerWmL0huQKngLpJNl8zUhutAGBHQ4+j1+esuruZ
	mecfVlcBwxptg93MVoSqyClda0sR9Zw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-XVVvMsB4OjOavaXbBI0X3g-1; Mon, 10 Feb 2025 14:38:59 -0500
X-MC-Unique: XVVvMsB4OjOavaXbBI0X3g-1
X-Mimecast-MFC-AGG-ID: XVVvMsB4OjOavaXbBI0X3g
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38dc6aad9f8so1835280f8f.1
        for <damon@lists.linux.dev>; Mon, 10 Feb 2025 11:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216338; x=1739821138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE9Ja/aC61CHup4qeT96Odiagg40Q7TPEFXRUvHwXRo=;
        b=BB4hs6aUi+BqwFU5ZjlczYXB1WQ83XPdgGh4tsP5jRnhDmkyUDywkfNzer1L8bF8Ex
         dX+6FRnIkCrObnX+ZplbHrDdZC4+S+Cjtg05ecxO/VTNxLGDEkT0c6HvL3ZSWyx4FIL9
         MPpzQMURUEwtpOjC8wrETj7NvCNiA1gQIx8hRpKsnT9Uzin3UX++Au4sFc0MO+SBVNGh
         1wqcPDV4mMA3LVmtDSTy4u1vGPmQj+bUH47/DW5wIXbN0qc1MM9hW1S4Ru8uI1kFLXE5
         SDDPeK8z3/keZ0oWCUEyMXFP7sClvC5mlSoteOs1aQ0SEJpJu+wtx5onMB3KIGI7Xqz2
         UmHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKpBNdQ5G77fzBnrEga7PTArir5ZUVeBPhJkcyEpohRSmMuAyimuBtQ+Ldj3HlIDe40VErmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuASiLQLLIm7kt8L4noTg9m0cJie+VQ8j5+8GYLa9yRJIx4wGj
	fjARTn2PMSdvRKVdEeU5GcAh2YSR/0J/9t0opCofRSCLSqQp7fjNVYIcGOpuWRfpcShXf+jEXvt
	V59DWwDgyFtbSrT0dqfnmQfbVJsfKOc779JhnwP4plStOeLSTb2xr
X-Gm-Gg: ASbGncsCS2xZnSpmvz96bfAYNPQkUc4JB886rYD5hRdvYWVhsT11al7N4yuSYS7Zn3z
	2sNab79tfLKDLPzM/2oo+b5wYH7ONt9hNOdofd6a4l+Dn5pf0AL4ScQPTVxG+iS5BXWevG9Q75p
	HoU4Cu50iPCM3pIpYn/QOy2GmuZ8yrbLiVR+o8xiCkvu+YTdXYrYNo/yB/kMdzk2/IQPRpnH0HO
	P/fwvCw4vUpXqRiMAM4HQdlRGhNqQKgTqVcyIGfsn9QH9rRyT9SXso+YFD5X1oAI4D+kT5TS/63
	mMnh4wmfdPBpOqtI052ok0BYKDw7gU983IGbeQrjVjUxW5OFJVm8y4ttZs8hU0SwQA==
X-Received: by 2002:a05:6000:1887:b0:38b:f4e6:21aa with SMTP id ffacd0b85a97d-38de439b7e5mr512537f8f.5.1739216337884;
        Mon, 10 Feb 2025 11:38:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/uzgNmJSm7r4vj5m1RC+0Hk4d4M8qsuHzJI2p/6gaMOev6b/snbfbww+U3ctbsFbws8/HTA==
X-Received: by 2002:a05:6000:1887:b0:38b:f4e6:21aa with SMTP id ffacd0b85a97d-38de439b7e5mr512516f8f.5.1739216337518;
        Mon, 10 Feb 2025 11:38:57 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dcc9bd251sm9816921f8f.9.2025.02.10.11.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:56 -0800 (PST)
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
Subject: [PATCH v2 14/17] mm/damon: handle device-exclusive entries correctly in damon_folio_young_one()
Date: Mon, 10 Feb 2025 20:37:56 +0100
Message-ID: <20250210193801.781278-15-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: AKnLP7X0izB7_3stuoRN3VWsP8wHLiU1Mx28_rJUgtk_1739216338
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Ever since commit b756a3b5e7ea ("mm: device exclusive memory access")
we can return with a device-exclusive entry from page_vma_mapped_walk().

damon_folio_young_one() is not prepared for that, so teach it about these
PFN swap PTEs. Note that device-private entries are so far not applicable
on that path, as we expect ZONE_DEVICE pages so far only in migration code
when it comes to the RMAP.

The impact is rather small: we'd be calling pte_young() on a
non-present PTE, which is not really defined to have semantic.

Note that we could currently only run into this case with
device-exclusive entries on THPs. We still adjust the mapcount on
conversion to device-exclusive; this makes the rmap walk
abort early for small folios, because we'll always have
!folio_mapped() with a single device-exclusive entry. We'll adjust the
mapcount logic once all page_vma_mapped_walk() users can properly
handle device-exclusive entries.

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/damon/paddr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 0f9ae14f884dd..10d75f9ceeafb 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -92,12 +92,20 @@ static bool damon_folio_young_one(struct folio *folio,
 {
 	bool *accessed = arg;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
+	pte_t pte;
 
 	*accessed = false;
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte) {
-			*accessed = pte_young(ptep_get(pvmw.pte)) ||
+			pte = ptep_get(pvmw.pte);
+
+			/*
+			 * PFN swap PTEs, such as device-exclusive ones, that
+			 * actually map pages are "old" from a CPU perspective.
+			 * The MMU notifier takes care of any device aspects.
+			 */
+			*accessed = (pte_present(pte) && pte_young(pte)) ||
 				!folio_test_idle(folio) ||
 				mmu_notifier_test_young(vma->vm_mm, addr);
 		} else {
-- 
2.48.1

