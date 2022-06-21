Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880A67499
	for <damon@lists.linux.dev>; Tue, 21 Jun 2022 21:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655846015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2ZyEjz/X1rrSRyY38O7XcVSbvfO1EBTiv9ehORRiiM=;
	b=amlFTC61cxaMpJAJOk7D9m9lnlqVWMxEAopTgTXzBpiliSYNg3e53VVgIaN8Pr2Io3QMzU
	CoJ2dAPtBXM36VqI/3/NblxCQnfnJumBNMx1tvsJvWYuwq0J7fXuZAgaKlGQpnIJtUcvtc
	ExI1L3NnvSoBHRS0gJIFtpjpd/X6RNA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-d1Q2YJwoOcm4sKXZyLsTKw-1; Tue, 21 Jun 2022 17:13:34 -0400
X-MC-Unique: d1Q2YJwoOcm4sKXZyLsTKw-1
Received: by mail-wm1-f70.google.com with SMTP id l3-20020a05600c1d0300b0039c7efa2526so6752806wms.3
        for <damon@lists.linux.dev>; Tue, 21 Jun 2022 14:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=p2ZyEjz/X1rrSRyY38O7XcVSbvfO1EBTiv9ehORRiiM=;
        b=yOMopO0lhsQ8k5Zh+OGRCa1tl8UKx9uzlhun2QGYfy27rYTcrpns+rlN4CoqkiKL1o
         uYoRBbvovVNSwoVO+GopjPPItS+ThqF1S9etmbN6SV+uQsk9DPvCARCywsTp84KKFXeJ
         TpOUoMPDAtVqsHAxKGUfqii61338ed9F0SNKa7MmQBK/3s5OoJoP1PHfhO66Wnm989Ix
         rbeAbyFyPMbjoFWMUm+cb4Edf03kSU2pY/yC4VhhfadZeUv7PIqNFvldwnWfNT2b56pl
         7Sv1UxRhy5lDtNmwAt0SDmx5gRm0ZJqGyBlY68NEps54PnPz4AnsCMPUACbwIM2P7jAM
         x+PQ==
X-Gm-Message-State: AOAM532plFmWF7EOWiteS3C+gfx5lfNwsOmz7UEhuBw6RO0AFu+rP18h
	fcejnvBKyc9FfGBMPuGWflFM7mKIuhclScqXbhx0N+TY/MmUMXe/CwJVTG9sl+/gfOKwij5eczF
	DdWdyrCdhskk5Zb0=
X-Received: by 2002:a05:600c:583:b0:39c:3637:b9f with SMTP id o3-20020a05600c058300b0039c36370b9fmr41890254wmd.79.1655846013141;
        Tue, 21 Jun 2022 14:13:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOeKyTVNcHGO8XIrslQyDEH0amifKDQHgWoO8MHT556YVEyS90MtqIiT8yBXXL779Lr60M4g==
X-Received: by 2002:a05:600c:583:b0:39c:3637:b9f with SMTP id o3-20020a05600c058300b0039c36370b9fmr41890234wmd.79.1655846012925;
        Tue, 21 Jun 2022 14:13:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:bc00:a63c:7e37:6061:1706? (p200300cbc705bc00a63c7e3760611706.dip0.t-ipconnect.de. [2003:cb:c705:bc00:a63c:7e37:6061:1706])
        by smtp.gmail.com with ESMTPSA id 64-20020a1c1943000000b0039c6390730bsm22251249wmz.29.2022.06.21.14.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 14:13:32 -0700 (PDT)
Message-ID: <5d3bf51b-3bba-3bd4-db1f-1c0a3930a1e4@redhat.com>
Date: Tue, 21 Jun 2022 23:13:31 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v10 10/69] mmap: use the VMA iterator in
 count_vma_pages_range()
To: Liam Howlett <liam.howlett@oracle.com>,
 "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "damon @ lists . linux . dev" <damon@lists.linux.dev>,
 SeongJae Park <sj@kernel.org>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-11-Liam.Howlett@oracle.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220621204632.3370049-11-Liam.Howlett@oracle.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.06.22 22:46, Liam Howlett wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This simplifies the implementation and is faster than using the linked
> list.
> 
> Link: https://lkml.kernel.org/r/20220504010716.661115-12-Liam.Howlett@oracle.com
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/mmap.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 6be7833c781b..d7e6baa2f40f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -675,29 +675,19 @@ munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long len,
>  
>  	return 0;
>  }
> +
>  static unsigned long count_vma_pages_range(struct mm_struct *mm,
>  		unsigned long addr, unsigned long end)
>  {
> -	unsigned long nr_pages = 0;
> +	VMA_ITERATOR(vmi, mm, addr);
>  	struct vm_area_struct *vma;
> +	unsigned long nr_pages = 0;
>  
> -	/* Find first overlapping mapping */
> -	vma = find_vma_intersection(mm, addr, end);
> -	if (!vma)
> -		return 0;
> -
> -	nr_pages = (min(end, vma->vm_end) -
> -		max(addr, vma->vm_start)) >> PAGE_SHIFT;
> -
> -	/* Iterate over the rest of the overlaps */
> -	for (vma = vma->vm_next; vma; vma = vma->vm_next) {
> -		unsigned long overlap_len;
> -
> -		if (vma->vm_start > end)
> -			break;
> +	for_each_vma_range(vmi, vma, end) {
> +		unsigned long vm_start = max(addr, vma->vm_start);
> +		unsigned long vm_end = min(end, vma->vm_end);

I thought using max_t and min_t was the latest advisory. I might be
wrong and simply kept doing it that way ;)

>  
> -		overlap_len = min(end, vma->vm_end) - vma->vm_start;
> -		nr_pages += overlap_len >> PAGE_SHIFT;
> +		nr_pages += (vm_end - vm_start) / PAGE_SIZE;

PHYS_PFN(vm_end - vm_start)

>  	}
>  
>  	return nr_pages;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

