Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640904;
	b=3yXe0+Ld8dhT5wQ1e3fJtUmsG0aSovq5EGO1UVGlIjvBRwYuQQrWNgNMgxDS3R7gTg0O
	 h2VWo+yh7bt+zi4hKU+WZVAELjhhXQdi5xiai0vRY4d2+69OP++WrUE1CPseHeSMWCerI
	 pkybqgnsGHfUdXFXPMg3qzGrPXCQG1pLBJsp01ymfy4LzEYLUPxxAcNJNazNVzWxoT326
	 PJ9/ruQr4O9EGS5ittKDFZEqh2vbNsdR0c7ekQmxanky4n/t0nlWGMmyO7acWpvY6dOio
	 Bxe74jUgWbMyia267AWkCyI8lnvW6NE/MBxSn/t3gzzl1pxBpjYU3pHEpcGda29OTKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640904;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SySnQWEZZt0ZJcY0gD5OVrDsND9/1T98niGZwR/wiT4=;
	b=EbWPFPsd9PdHb8F0AKE0zvpa73v9QKkyIRxbrLfzt3VIPgAIkxJx5HZFmA4kRxty+uYS
	 WfU7MmGo62DFUZ3g17QXU3XoWc6Skg5PWPQTSVsVeyt68QxXYJtCUImmY2xrKnG6PRegy
	 tfdF/qr/QC6AbByTHh+MizejkdrYPAdd6pDgX4vD2zesXe8ty0JXgyCPgtu5cgkg0dU3T
	 Gm0OWWrVh/zPWwNkplO5NzUOvX5YdwwBAMo8B22qcr5RWmwjwRr3vBGz5kXDHSZqWNcDF
	 lRERjDBTf7jbKH14/kBZUAxPGeuEoUg0+wCqyVWAVsTSXc7jmJUqwM+vVfIedrxpMcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=fail reason="signature verification failed" header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QS0kLU7m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30155606A327;
	Sat, 14 Nov 2026 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QS0kLU7m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3015F1F000C4;
	Sat, 14 Nov 2026 07:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640903;
	bh=SySnQWEZZt0ZJcY0gD5OVrDsND9/1T98niGZwR/wiT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QS0kLU7mA8nNQkh1mioJKyLHUOPwA4e3Jbn/FDXu8YM/vbOIvnClPO/kYBq3DaEPU
	 To6lyW4Bodv/ef+5WC8o/CDKIJ3pHAvzh2zEBZlJZbChJGwAG/LgfxTjc8o935qFb2
	 skhSmpPaYX1NTyHPmPhSEKm9WdyII5LpDWl7BbEcefknr+mzW3BkXbx4qdkmIitUMh
	 +0U0WctafQuOZlgsj5kFtrcQCCNChTjBAC/V0Y/paSOCGm93hiUKwfj17txlZCiPS6
	 cQyFBcxkfxHv5wEIYjr9wEGF/rxi/8LisMNs71oq6Wx2dGyriH/Tn0hEFRzJfxsgiw
	 RgiKmZAVtUk6w==
Message-ID: <sashiko-outbox-214261@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/22] mm/khugepaged: restrict collapse to common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>, linux-mm@kvack.org
Cc: kernel-team@meta.com, linux-serial@vger.kernel.org, damon@lists.linux.dev, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, david@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk, pavel@kernel.org, lenb@kernel.org, hannes@cmpxchg.org, brendan.jackman@linux.dev, ziy@nvidia.com, sj@kernel.org, muchun.song@linux.dev, osalvador@suse.de, nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, xu.xin@linux.dev, chengming.zhou@linux.dev, joshua.hahnjy@
 gmail.com, rakie.kim@sk.com, ying.huang@linux.alibaba.com, matthew.brost@intel.com, byungchul@sk.com, apopple@nvidia.com, rientjes@google.com
In-Reply-To: <20261114070959.3490008-11-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-11-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:21:40 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mm/khugepaged: missing folio_is_common_memory() check in
  collapse_file()
--

commit 5cdd71b37e4c9e4d2c7bf61d7c51d7ba89a07fb5
Author: Gregory Price (Meta) <gourry@gourry.net>

mm/khugepaged: restrict collapse to common memory

This commit replaces the zone_device checks in anonymous THP scan and
isolation paths with page_is_common_memory() and adds a
folio_is_common_memory() check to collapse_scan_file().

> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4bbe319ef86fa..b4bd29f25c145 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c

[ ... ]

> @@ -2741,6 +2741,12 @@ static enum scan_result collapse_scan_file(struct =
mm_struct *mm,
>  			break;
>  		}
> =20
> +		if (unlikely(!folio_is_common_memory(folio))) {
> +			result =3D SCAN_PAGE_NULL;
> +			failed_pfn =3D folio_pfn(folio);
> +			folio_put(folio);
> +			break;
> +		}
>  		node =3D folio_nid(folio);
>  		if (collapse_scan_abort(node, cc)) {
>  			result =3D SCAN_SCAN_ABORT;

[Severity: Medium]
Should collapse_file() also check folio_is_common_memory(folio) after
locking each folio, matching __collapse_huge_page_isolate()?

collapse_scan_file() drops its folio reference on each iteration and
skips missing page-cache indices and swapped-out shmem entries, and
collapse_single_pmd() drops mmap_read_lock() before calling
collapse_pmd() -> collapse_file().  Folios that are faulted into holes,
migrated, or instantiated by shmem_get_folio() or
page_cache_sync_readahead() on a node outside N_MEMORY_COMMON after the
pre-scan will still be isolated and collapsed by collapse_file().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D10
