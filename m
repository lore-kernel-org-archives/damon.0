Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE60025A323
	for <damon@lists.linux.dev>; Mon, 10 Feb 2025 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216316; cv=none; b=p20tPyDmJ3KziezvbhyyFWilanqGzgvmZUnrSwsYnUKfwGdCrhox3M5LWROUFa8fQdrPeAi0CQ+u4SvTZD2aUeZ5DIN1/7mQ+bQqqJSoYIhVP34ArRkMRVECpyB6vLGTGU4QVp+/bpYz/b/lUtZS01gwAugubhxAW7YS3gLh5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216316; c=relaxed/simple;
	bh=WTAKrIObiH0+XnAmevo4XgmL855z4Fu5Qvoz089fAGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=NZRMd7adkHkmNqu5Qw0yR0mq3+rQeHxEMsds9/HH8DFxCVAfP25QsRCEAjlrmTB3cSQix165ySp2hDd8S46+ebPI4J0ySI6YYCYlSn8smX1Yi13Ye4LjH8hZyGgaTAxdW/RqHiPedq5QKsEX9D7OGYa1Gv25BreFzLyeIbhrHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikpo1MCT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikpo1MCT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPITbiV5yRtNZIanqm2v+SKlb5hdEoVu/zyhpD+AgeU=;
	b=ikpo1MCTffr8Ho/CsjTxQinDzBJSBDm6LK1sMOgGp3IeFkuZ97IiW/rcOxRahPXs2RnVNs
	UB/aNkXi1DB6RTEIKPoJ69lKDqtUfbor+VUMI/31D+kaJ2UE4q8zU9NGL4O+TF+ZPf7h+I
	8mrTEJmoqpQwZfgdk3D9cL5yoKTgl7c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-AUTLjC_wO1qNUdLROt2tHw-1; Mon, 10 Feb 2025 14:38:32 -0500
X-MC-Unique: AUTLjC_wO1qNUdLROt2tHw-1
X-Mimecast-MFC-AGG-ID: AUTLjC_wO1qNUdLROt2tHw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4394c489babso2565735e9.1
        for <damon@lists.linux.dev>; Mon, 10 Feb 2025 11:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216311; x=1739821111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPITbiV5yRtNZIanqm2v+SKlb5hdEoVu/zyhpD+AgeU=;
        b=vV+eR0lTKeuhn6qGF3YFjuq7V15Ixwp1v4EcxWHH5Px+AkG3pmPQCk4o9J1IceLMoS
         X+hns655r4oiZmWQ5cMHDjWZcnPVry+1w7G89z61meU3trP4i9z9ACHktBg5Cc2yXuG3
         xv/BUQRtLGiFs1DYfteQvgQ7N/vWjze6IjIqAnxHQayLS7doGLwf9gfbh4YxFztHWHyX
         SMpul7Lo5mQHZlIOW36dIN2bnXOySn/1hSFF3qlp8T53bVk9XWimOPYXYla9QE4iPqVT
         z0wFk9AZMNzGkuZh9X2ksUVNHoxttwLj73he2SLqbv9qW6ypFeW7Z3NrlPDkc1E+37p2
         FQfA==
X-Forwarded-Encrypted: i=1; AJvYcCUgxyuFM8F2zVprdsmQlU5WCLbEjhRfNJ3d+bq1thOM+GKmb7kkDW8clVqJmrTEbdC7BDXpvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOGilbQXbvyjJz8dbWcgF00Ldtt5e9cjpSYo3zruILngvyAaei
	FjV9Z/C6QfMjmZqsM4yjy//qJUPomzUOcsw4RPZWXCArWd3yKnMHJX56a/CNMc4UBs4oHwOzdj5
	zveXRGugsd1M8F2JpHnA32qCqKpztc9LKvaQIl7YHz4Xbqz64wFwi
X-Gm-Gg: ASbGnctcGNhv3MgoORWqTXbS6OjX5I36K69phpd34PKSO7zs2oJIPdL4AXboveTitPF
	eC3GQ2N1zI7zSFyvLcgCslCLpv+Muz3kSJNkjYTe1fG7g/UfH+rGipD81HhjU4EXHBr8ETmDP0k
	EPa1xaOCxC8Ns87+q/EvImD8rekcCBADX16IY3yEvkUH3PdX+H85z27ek3ALCpt5GMQ88HuzWEB
	F5YmsE2pMeUSSG2etHrxY1RfUPO8XjO4ByBNAFomLc3X0KoVjQV/y2ThBNbGJV7T6eq5JNs0xyv
	dDIcGJm09JQZsfAy1+MkZiDKO9CetBm1JfdrLw1dbExGFEedqkeVM6nppSfZIEAOaA==
X-Received: by 2002:a05:600c:500d:b0:439:3dc0:29b6 with SMTP id 5b1f17b1804b1-4393dc02be1mr57220195e9.2.1739216311477;
        Mon, 10 Feb 2025 11:38:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbUQzL3Yq1p3VwDR+lxH773I/PQZNBDcgTpUgE2nEJHxULXhio/DNj6yNxLtRtBjWIFSwTIg==
X-Received: by 2002:a05:600c:500d:b0:439:3dc0:29b6 with SMTP id 5b1f17b1804b1-4393dc02be1mr57220015e9.2.1739216311167;
        Mon, 10 Feb 2025 11:38:31 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4390d933523sm192523445e9.1.2025.02.10.11.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:29 -0800 (PST)
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
Subject: [PATCH v2 07/17] mm/page_vma_mapped: device-exclusive entries are not migration entries
Date: Mon, 10 Feb 2025 20:37:49 +0100
Message-ID: <20250210193801.781278-8-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Rzs7n6EeV1CQ81Cq05MXTy1Hh5i3AogHfcWxpOMvI1Q_1739216311
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It's unclear why they would be considered migration entries; they are
not.

Likely we'll never really trigger that case in practice, because
migration (including folio split) of a folio that has device-exclusive
entries is never started, as we would detect "additional references":
device-exclusive entries adjust the mapcount, but not the refcount.

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_vma_mapped.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 81839a9e74f16..32679be22d30c 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -111,8 +111,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 			return false;
 		entry = pte_to_swp_entry(ptent);
 
-		if (!is_migration_entry(entry) &&
-		    !is_device_exclusive_entry(entry))
+		if (!is_migration_entry(entry))
 			return false;
 
 		pfn = swp_offset_pfn(entry);
-- 
2.48.1

