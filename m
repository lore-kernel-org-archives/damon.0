Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99FB25A34A
	for <damon@lists.linux.dev>; Mon, 10 Feb 2025 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216323; cv=none; b=psaXHezcX9LmuAyX62mDlSZKL3bJhsoQ0ah2+I7botwbxR1WJcwIS0VCKIBnuRwg9lpE9MsK4GV+hQetZHAi8nGX4g55lujz15c40WJZW5rq38qjnrz1ZEIYEmk57DW1s5LPnNdF/rXZN4OxKneebw86hqF29o8oFMALXRWqoZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216323; c=relaxed/simple;
	bh=XECEsYRumwDXs38xfqw/DSW1eeDdoyEKYX/zmrQ3FPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Acb8MEHJnZv3r1WNzFWFx/aQH9Cfcc6O/LW3UU8BbeRBP5kj4t2hCjrBg2Wx8eevpfsetPqhYYTVsZ6v32Ebbz2YpkWDY2Fl0UJnVreYX213zF5a0QtKQ9g00DHKgJhX4Nru+2TGVuXJJ4svbpXxFmn8FQ7Qe9PPc6rAGGk/u2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDw8D0Gg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDw8D0Gg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7jLfJ9vH0eUU1vYEXZ3dUW5UEIvFQqjIYltl+lFPPU=;
	b=WDw8D0GgGNKMZT0mBqbsJGqDgZ1bopJ6Wn8XeBgE2JfTPy/bXAIs9x7Icx+dU9j2gwqsH7
	jNsRRx84/y3XfBK/gbSYVm6ut4C2//TEmmPA6N0oEjLTBJ09j5fk5qlU3sV7olL4mmVpB9
	mHzpSMXwHM0FyOzUlGzTbGCVrtAXu2I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-V2Q6wvviMpmKR1y4Ohb4QQ-1; Mon, 10 Feb 2025 14:38:39 -0500
X-MC-Unique: V2Q6wvviMpmKR1y4Ohb4QQ-1
X-Mimecast-MFC-AGG-ID: V2Q6wvviMpmKR1y4Ohb4QQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4392fc6bceaso13134335e9.2
        for <damon@lists.linux.dev>; Mon, 10 Feb 2025 11:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216318; x=1739821118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7jLfJ9vH0eUU1vYEXZ3dUW5UEIvFQqjIYltl+lFPPU=;
        b=Obg4YPUveELxmN6ALEyFsk7u3PXtpc564JHEBIA2sAFXWvMwfQvenBzGdR5oxjdFXm
         XsApiTYuokY/oorHLOrw9Dh60JUh5QrWmJcRybYySTGJwiY/g3Cx6E2f4w958RK7kNTU
         YqwjUzgsIAXJbpE5ThU1DKBvOMX5tDOsGE+SPj/TxesrUg8bUXZbeJQpznJCfptE8CqN
         C3I97rBI1Fomq2rjXwsp+eyOxwolX4bPLUDHuji8kyjfjtiKJKlQKSoipIxw/0SY1/Kr
         E8Rn4nKd5Rp5T2F8/lrMgNqonPtbvTq+ChtNolzRRkAD8omaqFRTwgFckzSoBClxdB5F
         kfWA==
X-Forwarded-Encrypted: i=1; AJvYcCXVouD8gH6LvDuZCcWE7kEvPft/pxadVpeS2u7Xj34bzPr1tbLbQ5V28tB7CzH5/T0y4NOt0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdSGNZXT96C0PNZg7XRdQGl264Ln2bsEzhNiCavN+EfCMm+8ct
	JMQRO7uPhmMtdF8rXoSdnddAvL6aRL6YdLP5OsHIm59xmMwQMsy8FlGZHC1Rmka4p4ndg108se0
	ZV4WnL4/yN39glKNKl2EXdlzdIM2NUpdYylzDGN8rrtoobOaT1NSh
X-Gm-Gg: ASbGnctVxCcQ4jcGAP6q0J+hXFbBsJK7o9debsr+9fy76XJlva5F7ghEuQCBA3vRNEq
	v/6B5f9vGAxRTcXAkJ8y8GSU8jYP/28iR6/xEhGHwtOHGQPAAZEZ9flKJcPneK7Oq799mYDPeaM
	hkScouurjyJ4GlGQHHkcHfjAVg+T90U181HE1kuK5nOJt4TVmmnxeAgexNMCjiCYImvx9XU6HJj
	TqZQzDFIRccQ9IpCa8ect8W5DiXKI8FTPLnVnqqfYfg4tLJmFNhS1Q3eRYBo3txugJ0Ivj9LLPu
	/p7FqGB+zDxJjbS8uGe1HNQdxnUpb9KHvMceoHYku7e/n6fcD2bjjPgG25+Rfa+ezw==
X-Received: by 2002:a05:600c:4f90:b0:434:a7e7:a1ca with SMTP id 5b1f17b1804b1-439249b04f8mr116077635e9.20.1739216318632;
        Mon, 10 Feb 2025 11:38:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdlczuWpIJN55C/ZdLw7mis7jMK/FKd714PEZJ/2b6DQtULEf1bpuI2yab2McnQRseLHdLgg==
X-Received: by 2002:a05:600c:4f90:b0:434:a7e7:a1ca with SMTP id 5b1f17b1804b1-439249b04f8mr116077285e9.20.1739216318299;
        Mon, 10 Feb 2025 11:38:38 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4391da96502sm158809495e9.1.2025.02.10.11.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:37 -0800 (PST)
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
Subject: [PATCH v2 09/17] mm/ksm: handle device-exclusive entries correctly in write_protect_page()
Date: Mon, 10 Feb 2025 20:37:51 +0100
Message-ID: <20250210193801.781278-10-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: qSGQjJaDvo2A1Oweh-29_L7l6LEcXvuIxoP_VOb5yEI_1739216319
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Ever since commit b756a3b5e7ea ("mm: device exclusive memory access")
we can return with a device-exclusive entry from page_vma_mapped_walk().

write_protect_page() is not prepared for that, so teach it about these
PFN swap PTEs. Note that device-private entries are so far not
applicable on that path, because GUP would never have returned such
folios (conversion to device-private happens by page migration, not
in-place conversion of the PTE).

There is a race between performing the folio_walk (which fails on
non-present PTEs) and locking the folio to look it up using
page_vma_mapped_walk() again, so this is likely a fix (unless something
else could prevent that race, but it doesn't look like). In the
future it could be handled if ever required, for now just give up and
ignore them like folio_walk would.

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 8be2b144fefd6..8583fb91ef136 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1270,8 +1270,15 @@ static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
 	if (WARN_ONCE(!pvmw.pte, "Unexpected PMD mapping?"))
 		goto out_unlock;
 
-	anon_exclusive = PageAnonExclusive(&folio->page);
 	entry = ptep_get(pvmw.pte);
+	/*
+	 * Handle PFN swap PTEs, such as device-exclusive ones, that actually
+	 * map pages: give up just like the next folio_walk would.
+	 */
+	if (unlikely(!pte_present(entry)))
+		goto out_unlock;
+
+	anon_exclusive = PageAnonExclusive(&folio->page);
 	if (pte_write(entry) || pte_dirty(entry) ||
 	    anon_exclusive || mm_tlb_flush_pending(mm)) {
 		swapped = folio_test_swapcache(folio);
-- 
2.48.1

