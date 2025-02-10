Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6089F257AF1
	for <damon@lists.linux.dev>; Mon, 10 Feb 2025 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216298; cv=none; b=CnRp5ItPqb4ZzzYAs19lP4yUdhsGlh5tTpWeXJ3Cy0bKQSL+xFL+R8CJt7kTZ8u7T+dC0pVr4g9samFY9+oR4/rbZDkbvXZ5ctWTDFkQw2sIeS/M9E6t7mUBSVmnBDgq3Gi5qOE7PpeTeO2ZUMvgMPUrgIFH4D9aH693nUzwd+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216298; c=relaxed/simple;
	bh=Xaxds3jkrAWo/nPRt6XArpsBiXLgWRUTYm/DhS1e3Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=WhwuP8FkR7i8eEWk7tfN5X6zQ9QQ5KUpE/FIElavt7FubKLddDVLFtJq1PxsBSAGBfQvXonACMF3BnZM0cgpDywF0f0h409RcekR9dXv2lUEinaOOFFmiy9E2RYBMMXrqld9+vGMHkoc0uFQvYk8XpfTv7aF/Kqos61ydzIfOkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1sB74H+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1sB74H+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqeXk3kyzFMqBsxEiyyOZegmX6HzmCNZGUJC3XQma+8=;
	b=Y1sB74H+lLXHynIowQPEBxX4frA5Jo6hSg79U4+CgdJq4Hn7P9Ol1YOmmx2QKQ6pQVWTFa
	VWt5fwzyvZ3KwIULs6fni3H3Zj7qYs3lL+IwvB2JC8mGLqWNs8rllUFdjLxuR8BvtX/Mrm
	/OjgwD3XkMQE3YWtXk27uCIoom2zzDw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-nsGtTYUmO-OWHrCoFNIm4w-1; Mon, 10 Feb 2025 14:38:14 -0500
X-MC-Unique: nsGtTYUmO-OWHrCoFNIm4w-1
X-Mimecast-MFC-AGG-ID: nsGtTYUmO-OWHrCoFNIm4w
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43935bcec79so9251445e9.3
        for <damon@lists.linux.dev>; Mon, 10 Feb 2025 11:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216293; x=1739821093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqeXk3kyzFMqBsxEiyyOZegmX6HzmCNZGUJC3XQma+8=;
        b=tJzMLQDCSOT7Ecozd4UFk0MleoX2xK/shh5ZM5VnzLaNvMSShOouBEFyAPlu376KgR
         1jcUKkwYl+JwQnjPAt/Wo1J+ZeoZQ06LMGDVTdRlDH5LnZvkpHkWvalcH39tQ1BFVQVv
         mzc0s6jgI5y/zsPpglRkJlSbcrMmp/Pm1DzT0wGbV0aj3pOo65gER4TbRubyDqVSedPx
         Z4sZEUpLSW0FpbqeRUVPxnpj1QYdpFx19eEe6BkA7CS9FIW3psq8CAVWuxfQGLiTEApz
         el5U/noahKvteWtCCDLndBL+Y0+jq7NA3B2v7/3AlVk+G13xOspyGIyIDD9JO2CJDBiQ
         HzHA==
X-Forwarded-Encrypted: i=1; AJvYcCWmabdD2ra94pZR/VpNu0BSP09ZwqmOn8H/AQjDjog0cLjOxCjS6nRgg/N4h0pb3Qd8QMAfAA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxp2pJzlvkbtLInAuT/5PEFz1PbydINtjW9g1E2g6U9hOz6JHAb
	ytSyGNS3X6pqkCbnJK/U9SpqbESMKyHUXjPwKWkAiv4z3htBfigMpEAmdRxCZ3cKo+qZNMQS6uM
	Ss8h0fNepzGC2IwUcTEakrxzp4VJdhOi29LmMEvEBvtFAxoeCBvx6
X-Gm-Gg: ASbGncsWc7TjEg9MiN/qguS/1hGG+TWoZtqC51I9Fra5wI1U33XsvB5VpLQuyzE3U2h
	EGDGLfvX9t2hx1NU+fsnMVbGNI3LjvWcU8j/qttEPtcdlhYB9Faf08nmC0lTAlyujoGAjBgYSlc
	knpS+gPhvkGb1BxIk/todPSwL8U56IXfjRMDfA/bk7uohUg1aWzPxTNiAb2wFevjKScUuV17ncJ
	KgNsGNk4EKDLToMpU9ot8s+jIQzocwOaQPp+5digipdcxirXlsJv6H+0PvJPvXAoJAMpJ9XGNEE
	pChlzqwj4/nZbzRUDvaHMghBfX+I7j3FfGA0VuyMaIJqoJmKPQNoSGMJvacg8U7//A==
X-Received: by 2002:a05:600c:34c4:b0:439:4b9e:461b with SMTP id 5b1f17b1804b1-4394b9e47dfmr21358195e9.14.1739216292949;
        Mon, 10 Feb 2025 11:38:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz4p8WiTgagZxwnDzZ7MmocZCF9a1hUwQMJIvxH3cH5x6X+HJSMDirq9gM71FmkI7KhAXcpA==
X-Received: by 2002:a05:600c:34c4:b0:439:4b9e:461b with SMTP id 5b1f17b1804b1-4394b9e47dfmr21357855e9.14.1739216292555;
        Mon, 10 Feb 2025 11:38:12 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43947bdc5c4sm26937995e9.23.2025.02.10.11.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:11 -0800 (PST)
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
	Jason Gunthorpe <jgg@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 02/17] mm/rmap: reject hugetlb folios in folio_make_device_exclusive()
Date: Mon, 10 Feb 2025 20:37:44 +0100
Message-ID: <20250210193801.781278-3-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: n1sUPF8o0Wr8HC7veTcAbbPKcB9lAiUoSuYWC0q2Oik_1739216293
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Even though FOLL_SPLIT_PMD on hugetlb now always fails with -EOPNOTSUPP,
let's add a safety net in case FOLL_SPLIT_PMD usage would ever be reworked.

In particular, before commit 9cb28da54643 ("mm/gup: handle hugetlb in the
generic follow_page_mask code"), GUP(FOLL_SPLIT_PMD) would just have
returned a page. In particular, hugetlb folios that are not PMD-sized
would never have been prone to FOLL_SPLIT_PMD.

hugetlb folios can be anonymous, and page_make_device_exclusive_one() is
not really prepared for handling them at all. So let's spell that out.

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index c6c4d4ea29a7e..17fbfa61f7efb 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2499,7 +2499,7 @@ static bool folio_make_device_exclusive(struct folio *folio,
 	 * Restrict to anonymous folios for now to avoid potential writeback
 	 * issues.
 	 */
-	if (!folio_test_anon(folio))
+	if (!folio_test_anon(folio) || folio_test_hugetlb(folio))
 		return false;
 
 	rmap_walk(folio, &rwc);
-- 
2.48.1

