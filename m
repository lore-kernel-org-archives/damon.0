Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E924E4C0
	for <damon@lists.linux.dev>; Mon, 10 Feb 2025 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216336; cv=none; b=gZziVJImvM5BdzYe6n6DWeB8Zo5HN33tRAN9ZWBOmvUghZKZow74xDWe9CaPNuXrTJOuv5Bcpjs/1C+tR6gNnFJ5DSQ2SSDRlq5eI3355rSAbvXVHxRhGVosA0IlJohNO0nZxTuZhC7WBzMgsOXGusYPcRmrrr90HPq5V577W3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216336; c=relaxed/simple;
	bh=cMJXMPJ9fLW/woS9dzf0yuP4P9GXVUKQkO8wkukVnbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rOX3w/VxtAkI56qiHSpKzPJN/W8Hpl6DMTbw7nLHLxht+SDyUBRY0WUV3MYgRb0ZMkeAwMKNOqjCObu0mterSDgv+G01rBEUtEMLTGnOBJF7Cx+33O2RKWQ/dW3mIJoC+n61Wri8sTrFRBwuTjj2dx6FkcOMRhj7JwOx8guUIpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mz2aQmDK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mz2aQmDK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LTEWxPe8B8Wum8eXVDX5hUwjNBhNNdMWJNli9ItwISM=;
	b=Mz2aQmDKq8fZmzlhh+7TvwASMvFmco/VmG8rfsvTVfk4HnKZjDGtCDi4u5anMMEPJBnPRU
	kGZNEb5kCPnffms0gcDNb/WDWUbmp11c0p9bZSLVr9TsPa9zdmQM+uv5IE4iisBjnQVA02
	8km1iYIEcJ/VhptfOI+C5/34ww0qJ3w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-9z9U09oPMIa0eWi4sKSXAw-1; Mon, 10 Feb 2025 14:38:51 -0500
X-MC-Unique: 9z9U09oPMIa0eWi4sKSXAw-1
X-Mimecast-MFC-AGG-ID: 9z9U09oPMIa0eWi4sKSXAw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43933eb7f7eso13411605e9.3
        for <damon@lists.linux.dev>; Mon, 10 Feb 2025 11:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216330; x=1739821130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTEWxPe8B8Wum8eXVDX5hUwjNBhNNdMWJNli9ItwISM=;
        b=PjR2jOGWlxknFGTGv2oV1pzzXdnGusLDgh5FQ7Q+M49RdpLbH/7Zzkn3/05m1BVvZB
         zM/nKioPKV1skB02Zd141OR0k7SrG7g9ImS1lrnyOql/adDfcFKFlSq8eIfRNUqsoi37
         Xsk9UASvyutkEp6P1F6UawyL+mGeKunhX7XqUWHc5TAecvsRcDpOrwKJHYhywUpB3vzG
         8yESBv2FsYiSF1sVdZx8UsoonpNv2QUlI65bbH84jCQl7w9cw2WJOGuZuY+3bvKY3ViL
         QoxgsfQH69aqSpwQwx/YyTd+0ycnr5s8WfbNixaoJohUBjHEwRPtC7Vya019hrxtRh10
         rizg==
X-Forwarded-Encrypted: i=1; AJvYcCXHlaFMhP03bGbeDYeWZiGqAcmP+m3SxGEKPoZP+3zFDzoGDnts2BK1Wz8mW6ywcYM2znPp2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUCzz4c4Id8KiUVdG5XMRUCYkY9+vwko2SybDDmwGMCKm6yuJ2
	KGC5o3sXJq9C4VYgWmW2E8UPMXSD7PvzWCg6tiDFurQ9quLywj4hVtZXWyKvUhRWHQ/OO6qjtUu
	nByVCEsnmb0fFXj7Af2sIl1h7wFAbOXcMX9boJILdhNXWwyoz913I
X-Gm-Gg: ASbGncscv/HsuKrfO0Fz6APxpYpkho5ighVJKAfg3DavdGN2JunHVD9GerHbv2QnGLV
	ljygSr2TzB2x/q32pyO9Xud4sgnvHOr9pQZgIjksb20STIsA2qvI+jl6lvI0+8dwVdPZnD/jUZR
	JoxRbpYXSCZJwFOSugeSOpf6ohiZFd7r6RvXjwrQkr6OlaLY+Nc56J4JJ3netagsPBrdgvhkgPP
	U4ihUUvF+XHGRWcityJPAgg7nLqeRjCIU+OFg/SXeLMUaaX8wdnx3HU3FEY11zRRlPmZxrPthhx
	PGA+prbJNqGtDGvJ+N2454XUm/vDnaYpSg/F+wWmFKTLMwYS8oZGFYHrte+WYmDJ/A==
X-Received: by 2002:a05:600c:4f89:b0:439:4bb0:aba0 with SMTP id 5b1f17b1804b1-4394bb0adb6mr17902785e9.8.1739216329962;
        Mon, 10 Feb 2025 11:38:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0Un4mhmMUf8CyrAHOSxNb3M+hrifrlRxr2GMjHtCC/u6kqhVG2aMU260gZj/4uoW1cKICNg==
X-Received: by 2002:a05:600c:4f89:b0:439:4bb0:aba0 with SMTP id 5b1f17b1804b1-4394bb0adb6mr17902495e9.8.1739216329619;
        Mon, 10 Feb 2025 11:38:49 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43947bdc5c4sm26951255e9.23.2025.02.10.11.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:48 -0800 (PST)
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
Subject: [PATCH v2 12/17] mm/rmap: handle device-exclusive entries correctly in page_vma_mkclean_one()
Date: Mon, 10 Feb 2025 20:37:54 +0100
Message-ID: <20250210193801.781278-13-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: aSZ3az4XFlpr-eWgYPfNEiTSPsaBBB_riPuKqCAq2v8_1739216330
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Ever since commit b756a3b5e7ea ("mm: device exclusive memory access")
we can return with a device-exclusive entry from page_vma_mapped_walk().

page_vma_mkclean_one() is not prepared for that, so teach it about these
PFN swap PTEs. Note that device-private entries are so far not applicable
on that path, as we expect ZONE_DEVICE pages so far only in migration code
when it comes to the RMAP.

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
 mm/rmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index 7c471c3ea64c4..7b737f0f68fb5 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1044,6 +1044,14 @@ static int page_vma_mkclean_one(struct page_vma_mapped_walk *pvmw)
 			pte_t *pte = pvmw->pte;
 			pte_t entry = ptep_get(pte);
 
+			/*
+			 * PFN swap PTEs, such as device-exclusive ones, that
+			 * actually map pages are clean and not writable from a
+			 * CPU perspective. The MMU notifier takes care of any
+			 * device aspects.
+			 */
+			if (!pte_present(entry))
+				continue;
 			if (!pte_dirty(entry) && !pte_write(entry))
 				continue;
 
-- 
2.48.1

