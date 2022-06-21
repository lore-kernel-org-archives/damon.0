Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D2A7499
	for <damon@lists.linux.dev>; Tue, 21 Jun 2022 21:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655845824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdUI0K3w6UZwdwxK9UpEw+8+48uw2ZOlT+wIg6Q8bOY=;
	b=aZ9OqL4d/aQqCznf/rXdPVxa/y0huyF3faN78RRWaVcTCVR0ZcUGaK6rQmMQQpRTU8KLNW
	Zg2okX6NQ4Y6LiMBgjn9rIiX0Tdb7AcS0bTX8BWhC8tqZ2A3Xn2slZzfIOvkNsPlImotX1
	W3BZ1NrW6yoiHs4+uxfAei0mWRaGi5w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-4qjYkg8_NdqNmHQVJ1OIAQ-1; Tue, 21 Jun 2022 17:10:23 -0400
X-MC-Unique: 4qjYkg8_NdqNmHQVJ1OIAQ-1
Received: by mail-wm1-f72.google.com with SMTP id o23-20020a05600c511700b0039743cd8093so6739885wms.6
        for <damon@lists.linux.dev>; Tue, 21 Jun 2022 14:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=SdUI0K3w6UZwdwxK9UpEw+8+48uw2ZOlT+wIg6Q8bOY=;
        b=Dg3VRTpXBDE7/cyhlmhCca156XtRgmWpFN9Hi/vHrZ1gBciueKgrcWyktNf+bGzxCt
         k+8pX3nGMHt6Y0pmaPEFOhluxNIPpNe27ZQEGtJANAB2zgT2Io9aY5mpxQTL/XT764B0
         IkWPYOw44etRfxMRB7ZQ1jzPDV+yHIIuks5PgajA4LkiVwhtZSiA/+mrS8dCj+ErxZnx
         VkpYqM0MrwL9qiN+ByO25D4mDnFetkjtPCoP5MxDZBlINXmS1ZCcPUSDKLnH0F+nVTeX
         ERGCrpq0VjajKoRXfbXeZyEVv5W11k1fO1vWV+wJlso0E4CTzJklCsrum5XuUjpG1W7R
         kZlQ==
X-Gm-Message-State: AJIora+3uHyyvwQO2NmoVQ/BrKoO6ZUG0FbqPNUtFz4DxSoHfhxUnoyo
	msGMvWR7FepAiWnLa5sptUZtuNdt+jIpRTIOz6WwoCANPYFEPPmcBZdXwIUmpu957PVqVanqr4H
	q9EMYKE/P1W/CZds=
X-Received: by 2002:a05:600c:2215:b0:39c:55a0:9531 with SMTP id z21-20020a05600c221500b0039c55a09531mr108965wml.29.1655845822339;
        Tue, 21 Jun 2022 14:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ud+bHPP4KWO8KY35eiF30xNySOOWliDKJe6HtrrpkxxAj+WdmqBBYwA8RLBb2B32014Zn5TA==
X-Received: by 2002:a05:600c:2215:b0:39c:55a0:9531 with SMTP id z21-20020a05600c221500b0039c55a09531mr108952wml.29.1655845822122;
        Tue, 21 Jun 2022 14:10:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:bc00:a63c:7e37:6061:1706? (p200300cbc705bc00a63c7e3760611706.dip0.t-ipconnect.de. [2003:cb:c705:bc00:a63c:7e37:6061:1706])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d48ce000000b0021020517639sm17018132wrs.102.2022.06.21.14.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 14:10:21 -0700 (PDT)
Message-ID: <20192b57-30de-1426-6694-238e018104eb@redhat.com>
Date: Tue, 21 Jun 2022 23:10:09 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v10 09/69] mm: add VMA iterator
To: Liam Howlett <liam.howlett@oracle.com>,
 "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "damon @ lists . linux . dev" <damon@lists.linux.dev>,
 SeongJae Park <sj@kernel.org>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-10-Liam.Howlett@oracle.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220621204632.3370049-10-Liam.Howlett@oracle.com>
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
> This thin layer of abstraction over the maple tree state is for iterating
> over VMAs.  You can go forwards, go backwards or ask where the iterator
> is.  Rename the existing vma_next() to __vma_next() -- it will be removed
> by the end of this series.
> 
> Link: https://lkml.kernel.org/r/20220504010716.661115-11-Liam.Howlett@oracle.com
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
>  include/linux/mm.h       | 31 +++++++++++++++++++++++++++++++
>  include/linux/mm_types.h | 21 +++++++++++++++++++++
>  mm/mmap.c                | 10 +++++-----
>  3 files changed, 57 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 810b3dd929e4..f22c6f71a18c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -658,6 +658,37 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
>  	return vma->vm_flags & VM_ACCESS_FLAGS;
>  }
>  
> +static inline
> +struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
> +{
> +	return mas_find(&vmi->mas, max);
> +}
> +
> +static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
> +{
> +	/*
> +	 * Uses vma_find() to get the first VMA when the iterator starts.
> +	 * Calling mas_next() could skip the first entry.
> +	 */
> +	return vma_find(vmi, ULONG_MAX);
> +}
> +
> +static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
> +{
> +	return mas_prev(&vmi->mas, 0);
> +}
> +
> +static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
> +{
> +	return vmi->mas.index;
> +}
> +
> +#define for_each_vma(vmi, vma)		while ((vma = vma_next(&(vmi))) != NULL)
> +
> +/* The MM code likes to work with exclusive end addresses */
> +#define for_each_vma_range(vmi, vma, end)				\
> +	while ((vma = vma_find(&(vmi), (end) - 1)) != NULL)
> +
>  #ifdef CONFIG_SHMEM
>  /*
>   * The vma_is_shmem is not inline because it is used only by slow
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 254c30def2b2..1485a24796be 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -696,6 +696,27 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
>  	return (struct cpumask *)&mm->cpu_bitmap;
>  }
>  
> +struct vma_iterator {
> +	struct ma_state mas;
> +};
> +
> +#define VMA_ITERATOR(name, mm, addr) 					\
> +	struct vma_iterator name = {					\
> +		.mas = {						\
> +			.tree = &mm->mm_mt,				\
> +			.index = addr,					\
> +			.node = MAS_START,				\
> +		},							\
> +	}
> +

No __* and () macro magic?

I'd have expected at least

tree = &(__mm)->mm_mt,
.index = (__addr),

;)


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

