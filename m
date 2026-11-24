Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541094;
	b=Ze7aGvJflgJMeo4yetwP7Y8a00Hq4UsNt/CxUZ026sBDPlQJkwGs0H/KkSMCaPwvXW39
	 NKl3xhzNTuUmc2L19zwm/kn1LKefbFrBGGDB3ePqWEZp+e/djJfpUk7NYIcIF53Dc8KRl
	 cORGGb1cbqV9cDMZpttH2NU1Q3ysHOjlubGXDMss6gtBWBHXmWINVVPm5J6xbX9U3aD9y
	 V0kYr9O4CldKDVOkj8fmpm0Tn1yTZZCJtL3bKi8FdxwDaiB2mrcMssYGCbhbvyu3Re396
	 seCyF01nKxjznJkiRSLza53XCp4z4iG8oPk2TDIW3ZW2zuIFs7xHHqGZzQ809htYaYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ozTidCXqTzSwi9dcCKWD5fJGGI9rCJsLQ/Ov08gLSsk=;
	b=W8qMYSdYpNx9Ni/SIMx8SE0YvhYWpdEL6LHgXiiiO10alfSSS0jQcC6RsUmUe5vM+mDv
	 nCbGFp+1KSQk05k7paBLJkPWEJfCj1PFoL1vtpe18vbrXXRHb1UU9KssOoLqsKTwllrTo
	 IDSDcsY/cUKCSfGgHhoGcnVNxEjPQTHI5ECsLmHc23EskkmbNm6YVYxqayHtWsof9B0MF
	 iHzaEHZyiMXBlzfrUPTC2ch8jTKivu7x5E5HHGMtjb+xrE+o95WQ/szztVzAKhSbC23lt
	 y0BH/zNeFIzvcoGHH/AVLS8LVTKdbv/JovwQYqZaR4e2ZKCm6abvQ2mjCZNDid3hHcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="I+GC0/dN";
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC3606A333
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 17:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08FC3606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I+GC0/dN
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f0a0d1a1e5so11644225ad.0
        for <damon@lists.linux.dev>; Tue, 24 Nov 2026 09:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795541093; x=1796145893; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ozTidCXqTzSwi9dcCKWD5fJGGI9rCJsLQ/Ov08gLSsk=;
        b=I+GC0/dNqVtdJ8Ld4MHoIlYt6Qf+5Zo4jTimneMlL7Q5MuInb4NIoPsyDJqF8jWjHg
         aLb/ldOdS/VBoTvdPV9FV50KBABae94rRAeXKHD1lcLgXKt9t9NsLWOe1rL8zeW50ojK
         JcdF/5QuT3Rr8piHfvLxM75L69tzey0WscPtA8S2/Wf+lpQEFhR8dZi8Clwqs1xClRwo
         cwT970ZlP39b2I3eWewFiyvsQCRFY+8dzWK7a2nRaBL2OIgTtr5+ggEzfJqLyjlw4Wp9
         S6lb+7Gm4hY+aEsEuiOawRG0gZbhKzbicaPG339T0LM7+320dbsznkQobQCDoGj4IJAW
         Ol8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541093; x=1796145893;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ozTidCXqTzSwi9dcCKWD5fJGGI9rCJsLQ/Ov08gLSsk=;
        b=JDOILROlw1vdxe/bCpiE4KdaACM6Ejw7Y1lQskxL7tVdx6LzREHX7hxcSZg3q4+0aK
         +SGkVKo6pUaVKEHYdRfGSuq1Hnq6LzRtUmRNHQq4LhjKkAGdkjM1puIkdiE0z5Ju2dXM
         QTWnLDfqcdd2kYysaWDhh9js7kmgfbzKVIwLVXIWHxpXCQ2AUNx7CGGEShAGq0gEytr6
         sZYETC3IXFS+xEaID7DltE68d/9VuTXTPy13hknHlH7Xhnx5j9wIG1ujZCwQ+6jCDX4J
         DNzvvLux3cs2NrTZXrQkzZifgPzVpE6IYVmgiMkHF54mOm0P8MgQxzDrtFrjXV7FfJPI
         wQFw==
X-Forwarded-Encrypted: i=1; AL+hErFxgvVi0FuUKIt/P363kiMaTiAK3aA1Jwg6m3PoBGbheBzoQEwvFR2YYdbmGeTLd3KRZ6nKNw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/onPXYc2Gv2R77H5/Xtg3l+zzD/4hkrO4CHfhUZ0JMDjJPmt17
	m2KuWC4IsFrc0FYBFtGMfsyveYLEuXSRgSc+uCCnvZy8J2FWCHTA/3Ir
X-Gm-Gg: AZFdTZfD/ERYJv/XqN+1afwWpeYOZkraJpAGIaJTaAXqCbxDILcpzzJpYArW8cBRUwF
	rBHF02QxP7e0TRgjhIHhfPFWv1d4Efad0LlTexGB3i2/rjRtitpCzuNaZzzKT3qJriI4rJOgh34
	NuOflq/JUUxwOUDQnIWJMrLytxhGjOa11r6YTUDCQZbmruHhkgc1UYc5sRjEnbQyncLWlCeBNnT
	HuWl6tr2+FT8gESlbz9SDTJY9+u4i32RvdgV/aMwnhjkFdhYelUV52JqPpYRSMMZrUEMbexdMoI
	6+bms4N1DV5N/b0+5pmqH2SKmTu6VpLdYUnBn8/HEMdlPdcFEXEB2Sxbd+5THvYSnxxVTk1ZT9L
	MOlWsfcCQSkJwaivBSY0KuowR3FcsGcvEYc2TgEWZNGOjmXPK/RpmLNZqntsk0RRghw9C4beA3R
	wTFohNd0uD6otXExGUUctFYwtfrq7sWwaJ+TwgtLXmHYbVMbWdzbxXChTqlTzxViTpFxcQMpABj
	a3hLHEvJuPziKCAn6FBNIqigh2soTSg3YOFMORu/75p5lWD0DxqpXxzkt3/c+7PLpvdE21DWtLj
	3IFy2bEInYyw/KjxV2wMZeMu7zjZFRel19Je2vTnkIE3VdmLc9qQ69KefWI/DQDfPhYVrdc=
X-Received: by 2002:a17:902:f647:b0:2ef:e130:1505 with SMTP id d9443c01a7336-2f03f17d196mr143597245ad.10.1795541093208;
        Tue, 24 Nov 2026 09:24:53 -0800 (PST)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f102fc4sm72406805ad.43.2026.11.24.09.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:24:52 -0800 (PST)
Date: Wed, 25 Nov 2026 01:24:38 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: kasong@tencent.com, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
	Hugh Dickins <hughd@google.com>, SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, 
	Yu Zhao <yuzhao@google.com>, Vernon Yang <vernon2gm@gmail.com>, 
	Zicheng Wang <wangzicheng@honor.com>, Tal Zussman <tz2294@columbia.edu>, 
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
	Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, Tianyi Chen <hi@tychen.cc>, 
	Ridong Chen <ridong.chen@linux.dev>
Subject: Re: [PATCH v6 15/18] mm/huge_memory: mark folio as accessed more
 accurately on split
Message-ID: <awXABa3dYhEN0YEt@KASONG-MC4>
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
 <20261124-mglru-fg-v6-15-8ffea39934a6@tencent.com>
 <DN2V8E26C4EL.2TU52TEVLUFA@nvidia.com>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DN2V8E26C4EL.2TU52TEVLUFA@nvidia.com>

On Mon, Nov 23, 2026 at 03:17:05PM +0800, Zi Yan wrote:
> On Mon Nov 23, 2026 at 1:53 PM EST, Kairui Song via B4 Relay wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > The behavior of updating the folio's access info isn't consistent for
> > huge mapping splitting or ordinary unmapping. The page table's young
> > flag has to be translated into folio's access info.
> >
> > Right now it only checks and sets the folio's referenced flag, which isn't
> > enough since folio flag updates on access have their own rules. Ordinary
> > unmapping (zapping) calls folio_mark_accessed(), and it also checks
> > if the VMA has recency to avoid false updates.
> 
> Can you elaborate on why vma_has_recency() should be used? "false updates"
> might be too vague.

Thanks for the careful review!

Right, maybe I shouldn't say these are "false updates" indeed. But it
makes sense to do so, will reword that paragraph.

The young PTE becomes folio hotness via the LRU refs to help improve
LRU accuracy: telling the LRU that the folio is accessed, so it should
be protected as it is more likely to be reused soon.

But vma_has_recency() is the app's hint that these accesses are not a
recency signal: MADV_RANDOM expects "page references in random order",
POSIX_FADV_NOREUSE sets FMODE_NOREUSE, and MADV_SEQUENTIAL expects
pages which "may be freed soon after they are accessed", which is the
opposite of what the refs mean. In all these cases, marking the folio
referenced from a PTE access hurts instead of helping.

zap_pte_range() and folio_referenced_one() already ignore the accessed
bit for such VMAs. The split path is the last place translating a young
PTE into folio hotness without it. So while converting to the more
useful folio_mark_accessed(), also add the missing recency check to
avoid wrong promotion.
