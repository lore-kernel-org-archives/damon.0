Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707BF7499
	for <damon@lists.linux.dev>; Tue, 21 Jun 2022 21:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655846227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncxGKHn2fXjYFFgqRt4Fpjb6P4qj7hYEpB/9I/rKxUI=;
	b=W1GxWaxnrRr0iXsZd1UUmm+ixv+nNEjLqwK0Vv3CxwcRcYGFb/+XcQJrsA7h2hCFIwMhnw
	HXXHqRA1BMOeEs9OkDu6bQqyMXPZK+8ayitksPv2pOlFRNrHx2/zkJn0UAAnqxm+JTmGMy
	WRJ2htEryDWOn/XSOcjzdXQd1xvWzQE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-M63yey7bNR6kqbHF1BI-JA-1; Tue, 21 Jun 2022 17:17:06 -0400
X-MC-Unique: M63yey7bNR6kqbHF1BI-JA-1
Received: by mail-wm1-f70.google.com with SMTP id k32-20020a05600c1ca000b0039c4cf75023so8963466wms.9
        for <damon@lists.linux.dev>; Tue, 21 Jun 2022 14:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ncxGKHn2fXjYFFgqRt4Fpjb6P4qj7hYEpB/9I/rKxUI=;
        b=1MyH5jqAmwrq4g0x9f6Fa5dkdKw7QJce0KexwW69aTTaRBKZqPTA/KjghDkFpAcWLk
         P+MyKCn+D/A60QxjYTgggPyXgh+G8jtFCBWzNv+G4H7cyBkKeQX4lLEODKj2VEOqNSyv
         l9ygPQZMoDfLuYTV+Z9yDmiLRfpPmTzd0xI8y4hJYNvXeocynMslzb8RmXT/u5tfvypl
         WQuKndKubbDAQY7ni8NEpBCnNH7ttqCiKZgqqSdHmeSoyK7BE5aqj2mLidzcP9dVZM1Q
         89ia8xuoDsyUkcCcx0+ySVqxziJe8a0//GGixJJMbA8wUG1CMK2tq6WPUCRZQCFfZ7fC
         mx1Q==
X-Gm-Message-State: AJIora9dPObUxWADCjb4sXxipMSVWGhLUlnLjelUzkJ7r7mJjeY+EkVo
	GQ+GCMn9VpW/TvWh16IJNfWdg23OwfhOLGaFuJw2rxPxneZcaO8hvaSJqShQO8nBxGa1eqD/Qtx
	xGc4CT9ulBKLJk44=
X-Received: by 2002:adf:fb0e:0:b0:21a:34a2:5ca9 with SMTP id c14-20020adffb0e000000b0021a34a25ca9mr28692551wrr.472.1655846225130;
        Tue, 21 Jun 2022 14:17:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s7mvnYEndH0NNtzPZ+cRT9yucSmwHDvgIekUsuB3uVzNJ+k0JDAj46iI0F/imm2A0LaiJAkg==
X-Received: by 2002:adf:fb0e:0:b0:21a:34a2:5ca9 with SMTP id c14-20020adffb0e000000b0021a34a25ca9mr28692535wrr.472.1655846224902;
        Tue, 21 Jun 2022 14:17:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:bc00:a63c:7e37:6061:1706? (p200300cbc705bc00a63c7e3760611706.dip0.t-ipconnect.de. [2003:cb:c705:bc00:a63c:7e37:6061:1706])
        by smtp.gmail.com with ESMTPSA id j38-20020a05600c1c2600b0039c7f790f6asm22892637wms.30.2022.06.21.14.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 14:17:04 -0700 (PDT)
Message-ID: <8e4d37dc-722c-6b9d-b1fd-84df4a0076bb@redhat.com>
Date: Tue, 21 Jun 2022 23:17:03 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v10 12/69] mm/mmap: use the maple tree for find_vma_prev()
 instead of the rbtree
To: Liam Howlett <liam.howlett@oracle.com>,
 "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "damon @ lists . linux . dev" <damon@lists.linux.dev>,
 SeongJae Park <sj@kernel.org>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-13-Liam.Howlett@oracle.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220621204632.3370049-13-Liam.Howlett@oracle.com>
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
> Use the maple tree's advanced API and a maple state to walk the tree for
> the entry at the address of the next vma, then use the maple state to walk
> back one entry to find the previous entry.
> 
> Add kernel documentation comments for this API.
> 
> Link: https://lkml.kernel.org/r/20220504010716.661115-14-Liam.Howlett@oracle.com
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/mmap.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index fdb61252448f..08845a0317bf 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2512,23 +2512,30 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  }
>  EXPORT_SYMBOL(find_vma);
>  
> -/*
> - * Same as find_vma, but also return a pointer to the previous VMA in *pprev.
> +/**
> + * find_vma_prev() - Find the VMA for a given address, or the next vma and
> + * set %pprev to the previous VMA, if any.
> + * @mm: The mm_struct to check
> + * @addr: The address
> + * @pprev: The pointer to set to the previous VMA
> + *
> + * Note that RCU lock is missing here since the external mmap_lock() is used
> + * instead.

Can we assert that, please?

> + *
> + * Returns: The VMA associated with @addr, or the next vma.
> + * May return %NULL in the case of no vma at addr or above.

Nit: Inconsistent use of VMA vs. vma.

>   */
>  struct vm_area_struct *
>  find_vma_prev(struct mm_struct *mm, unsigned long addr,
>  			struct vm_area_struct **pprev)
>  {
>  	struct vm_area_struct *vma;
> +	MA_STATE(mas, &mm->mm_mt, addr, addr);
>  
> -	vma = find_vma(mm, addr);
> -	if (vma) {
> -		*pprev = vma->vm_prev;
> -	} else {
> -		struct rb_node *rb_node = rb_last(&mm->mm_rb);
> -
> -		*pprev = rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : NULL;
> -	}
> +	vma = mas_walk(&mas);
> +	*pprev = mas_prev(&mas, 0);
> +	if (!vma)
> +		vma = mas_next(&mas, ULONG_MAX);
>  	return vma;
>  }
>  
Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

