Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAF4428480
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438113; cv=none; b=CXXkmPU1o5vDAYvoIWQgZVwR2MaXjK5QXE8qBrhe0wVhsoqENmDgA6YrnemTUqeu06f5AeSxb84yXLW621qRtvS0aOLS/QHX2p4tkWlOfsfDWo6de1hfP9S2NBSXNBtZ2qR4ngQzoJmCy8SmxCpcl8XRSuSq0HTHuAuJ8nU0sZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438113; c=relaxed/simple;
	bh=d5xYhG2hX0Z5LYLLkWTErTtiNrSlB7MVDBVKDcBAUXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EP9iCp+xAXjc34JPiCrsIEu2K34NjZPoWAKoL6DrZf/BMms3WLLc79W84mL1kIYlmCLL2rYnvu05BSHVhUocfCnz/ascHvct8YUkkxKaZgxQuuu/jb3M6ValoHRV/HP9dK3KjACw39RPLseVqk/8i5YQyTiZjd5FyI3p5mchl7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=V2mp06PI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="V2mp06PI"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B621340E029F;
	Tue,  7 Jul 2026 15:28:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HjE96e7rH9tE; Tue,  7 Jul 2026 15:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783438098; bh=2uks/4C8ANKSue2FooHR2fOD1vcHZENkZsyUiD1kh9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2mp06PImRVVEzD7A2oD392jDBI60ysYtmCiHBipsESyUCuuKNKsOzLY8q6dygURt
	 BDxIHof2aiJBwgMUq+1jrM4V4/xc+WJIG6boP7uiYF/+xEbS4BGchztjBmklDjp8Yr
	 h0i/kIvOnVyfxzwk8BM1HJ/lwrssZeWW+ZrI8ePAjjMNbvJyJSpL6pabT1g3yV7dv8
	 6A9KEc5WMGxNN86YX2GzIW+1YFM6t77X4hJoIe0mmzyZoq/wZ0qkYjyXaKvPOWWSHj
	 mC37rUs303+qjcvBfnT4jqfPxu7HAfK7jsOwWb1ayxbQbG5PbZQDnVLW2Hpo5rH9LQ
	 tl5NtRuhJHIrqs4u2hNDu9fQBfvnPDA11HlmrEDG5W7l3q5XQvDe64eDEC68vTf3HY
	 y+EZkfADz8Pfud3ktcA22n4JCXA6kLDOmabI/R/VCyZUmAB6zTJ/KAil39IOOy1y9Z
	 6gjFUXKDjP5B3S+uQyjHgD1jyor//QGGtxp0uk3Qb3V2GlyuBGIdvM4hBiyDwSNv2J
	 7bBcr7NEBAkICrPMpROHVYB9uqhdj50MoJD2+oiGBzOo3Q50OHZ//QnYaBcSQer2E5
	 y7pFEEbV8RKlqznif1e+jIwR8fdiCp9gewyjqKKYUPsVphJ5Th0IgUUeWH4ukdUQ2u
	 Z1iR5mX3OYcjm545s/E02/Bw=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E8C9540E0140;
	Tue,  7 Jul 2026 15:27:16 +0000 (UTC)
Date: Tue, 7 Jul 2026 08:27:13 -0700
From: Borislav Petkov <bp@alien8.de>
To: tao <tao.wangtao@honor.com>
Cc: akpm@linux-foundation.org, david@kernel.org, catalin.marinas@arm.com,
	will@kernel.org, tglx@kernel.org, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, willy@infradead.org,
	sj@kernel.org, kees@kernel.org, luizcap@redhat.com,
	zhangjiao2@cmss.chinamobile.com, kas@kernel.org, ljs@kernel.org,
	hpa@zytor.com, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jack@suse.cz,
	riel@surriel.com, harry@kernel.org, jannh@google.com, jgg@ziepe.ca,
	jhubbard@nvidia.com, peterx@redhat.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev,
	muchun.song@linux.dev, baoquan.he@linux.dev,
	nao.horiguchi@gmail.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	pfalcato@suse.de, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, damon@lists.linux.dev, shakeel.butt@linux.dev,
	ryncsn@gmail.com, jparsana@google.com, dvander@google.com,
	zhangji1@honor.com, wangzicheng@honor.com
Subject: Re: [RFC PATCH v2 00/13] mm: rework anon_vma and remove
 anon_vma_chain
Message-ID: <20260707152713.GAak0a0fUAZN_5jgeR@fat_crate.local>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707063308.29176-1-tao.wangtao@honor.com>

On Tue, Jul 07, 2026 at 02:32:55PM +0800, tao wrote:
>  include/linux/mm.h       |   2 +
>  include/linux/mm_types.h |   2 +
>  include/linux/rmap.h     |  56 ++++
>  include/linux/rwsem.h    |  10 +
>  mm/Kconfig               |  37 +++
>  mm/internal.h            | 205 ++++++++++++
>  mm/ksm.c                 |  19 +-
>  mm/memory-failure.c      |   8 +-
>  mm/mmap.c                |   7 +-
>  mm/rmap.c                | 686 +++++++++++++++++++++++++++++++++++++--
>  mm/vma.c                 |  76 ++++-
>  mm/vma_init.c            |   2 +

Why am I on To: on this diffstat?

Please learn how to use ./scripts/get_maintainer.pl and do not spam unrelated
people with mail.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
