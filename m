Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795117499
	for <damon@lists.linux.dev>; Tue, 21 Jun 2022 21:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655845469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6KcRH4/KUHtf5xpIj4aJVy42n1FCoQeasRmMHkO/WZY=;
	b=E7wUBBi69Q3R4BLzK6cRKeRvUupH9HUjeE4ZWFLUPItj0yNzePOfpUUkERhIevrnrUxP05
	ZNIi47sn3S1k1BnC7OxHqNWLpVQI3LTPcIKJuAlgYtBXT8+ttAXhepwSqL/nqM+ovUCr07
	Tx5Nz6vAt4DYFLDHJumzAIHrfWlI8t0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-gBPBtyKPNcGj-axcUGJgaw-1; Tue, 21 Jun 2022 17:04:24 -0400
X-MC-Unique: gBPBtyKPNcGj-axcUGJgaw-1
Received: by mail-wm1-f70.google.com with SMTP id j20-20020a05600c1c1400b0039c747a1e5aso6724840wms.9
        for <damon@lists.linux.dev>; Tue, 21 Jun 2022 14:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=6KcRH4/KUHtf5xpIj4aJVy42n1FCoQeasRmMHkO/WZY=;
        b=gNRB6HK4UIyOabYAMn6yV3P6ueDonMMM/mds+PDNPS6E3Q96QwjqKY1QkiTebOfdQS
         mLqIFyiFL+9rIMKPao7OWJJfOplbH9jnpAe+udvy+bnswNSGg3eWcr/czEJm6ESRPW4E
         70+NqdYG9SEI1vav4fn+A4cftglIJf7Mfguxlb+3G/SXM73UXNDF4hYO6PjfIvVFqs3K
         3u1zR8seuEX+/6kOrD+6M1Ae01rIF07Y/xEOaswYsYZewdai3PdVRLB6CBVsRhtiUPPx
         mZiasFHl/wa1q5Z8kHAvggEAN/WWav+qW+ZUVIoZaTA41chWQIvjY2c4DPsvYvHDHNfS
         6KyQ==
X-Gm-Message-State: AOAM530J/lrz58ja8VSrzsLLPcheaOPct0u5QBNWk6xgISfm9KTimvJI
	qbhzT1upeK8YZ5c+097HMX2h2THQuf+bwZ4hvQk0kI0GTzjO9anHugpKxwo7bTb1kPrk+H9UVTE
	bhCsmemqhSInlKDE=
X-Received: by 2002:a1c:7411:0:b0:39c:8e4c:9704 with SMTP id p17-20020a1c7411000000b0039c8e4c9704mr42808298wmc.52.1655845459381;
        Tue, 21 Jun 2022 14:04:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm+wwv4IGBrN3CJ2eLl14IUYzF8AfIDUJBjL++7SCmt5nepLdvMx+y2Kx/kdCIkOHLNxnIWg==
X-Received: by 2002:a1c:7411:0:b0:39c:8e4c:9704 with SMTP id p17-20020a1c7411000000b0039c8e4c9704mr42808282wmc.52.1655845459151;
        Tue, 21 Jun 2022 14:04:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:bc00:a63c:7e37:6061:1706? (p200300cbc705bc00a63c7e3760611706.dip0.t-ipconnect.de. [2003:cb:c705:bc00:a63c:7e37:6061:1706])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d5503000000b0021b881c4c5csm10872237wrv.53.2022.06.21.14.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 14:04:18 -0700 (PDT)
Message-ID: <e25cb58c-464c-8bd4-c7da-9ab80b49f3bb@redhat.com>
Date: Tue, 21 Jun 2022 23:04:18 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v10 11/69] mm/mmap: use the maple tree in find_vma()
 instead of the rbtree.
To: Liam Howlett <liam.howlett@oracle.com>,
 "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "damon @ lists . linux . dev" <damon@lists.linux.dev>,
 SeongJae Park <sj@kernel.org>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-12-Liam.Howlett@oracle.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220621204632.3370049-12-Liam.Howlett@oracle.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.06.22 22:46, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Using the maple tree interface mt_find() will handle the RCU locking and
> will start searching at the address up to the limit, ULONG_MAX in this
> case.
> 
> Add kernel documentation to this API.
> 
> Link: https://lkml.kernel.org/r/20220504010716.661115-13-Liam.Howlett@oracle.com
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/mmap.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d7e6baa2f40f..fdb61252448f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2486,11 +2486,18 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>  
>  EXPORT_SYMBOL(get_unmapped_area);
>  
> -/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
> +/**
> + * find_vma() - Find the VMA for a given address, or the next vma.
> + * @mm: The mm_struct to check
> + * @addr: The address
> + *
> + * Returns: The VMA associated with addr, or the next vma.
> + * May return %NULL in the case of no vma at addr or above.

Nit: inconsistent use of VMA vs. vma.

> + */
>  struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  {
> -	struct rb_node *rb_node;
>  	struct vm_area_struct *vma;
> +	unsigned long index = addr;
>  
>  	mmap_assert_locked(mm);
>  	/* Check the cache first. */
> @@ -2498,22 +2505,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  	if (likely(vma))
>  		return vma;
>  
> -	rb_node = mm->mm_rb.rb_node;
> -
> -	while (rb_node) {
> -		struct vm_area_struct *tmp;
> -
> -		tmp = rb_entry(rb_node, struct vm_area_struct, vm_rb);
> -
> -		if (tmp->vm_end > addr) {
> -			vma = tmp;
> -			if (tmp->vm_start <= addr)
> -				break;
> -			rb_node = rb_node->rb_left;
> -		} else
> -			rb_node = rb_node->rb_right;
> -	}
> -
> +	vma = mt_find(&mm->mm_mt, &index, ULONG_MAX);

I guess it would be handy to have a mt_find() variant that simply
consumes an address, because for example here, we don't actually care
about the output semantics? Does anything speak against such a utility
function or is this here really just a corner case?

That would make that code *even easier* to read.

>  	if (vma)
>  		vmacache_update(addr, vma);
>  	return vma;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

