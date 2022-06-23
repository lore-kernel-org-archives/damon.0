Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8FE1FB2
	for <damon@lists.linux.dev>; Thu, 23 Jun 2022 17:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656005157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4H0hc8Du3nY/oCseQOeBBjY2ZACt1jajcUPDM0qtvz4=;
	b=RVuljAJM5S2bteL3KffuGOqRWiCdYFeYnrTHwhwWVYtiVlfk7tEYejHTjaXXFleY7XIEZL
	t4XElqy00k7fbxoc8OaNMIP8eZQpJ/UPt7mEOv3TLP3IENjkGmxal1aTslHyyaLgP7fyDZ
	zVPwrcvVCsnKZdKxGsLPoT0BxCPmW+w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-quuWpdgJM02mfI8mG92iGw-1; Thu, 23 Jun 2022 13:25:56 -0400
X-MC-Unique: quuWpdgJM02mfI8mG92iGw-1
Received: by mail-wm1-f69.google.com with SMTP id o23-20020a05600c511700b0039743cd8093so89382wms.6
        for <damon@lists.linux.dev>; Thu, 23 Jun 2022 10:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=4H0hc8Du3nY/oCseQOeBBjY2ZACt1jajcUPDM0qtvz4=;
        b=r2/Qx/71VDBNM50x34cY6WSC+PH5Cm3+7TDhQ2+rUjAgNjPsAs65Zmi7wBCp9R27O2
         CJ42H26Uxl+pimm8Fwl4s4TVs8aHCS0rd//Lnl+NPEBDsaVTC9N8jfHWDDU4FzOYGPa5
         8Imwc/hkxn1CZsQeD2hKZF+JrAGUTMJS4AZc0efrZWBGI+NTTfb6Zn11d+sPofSI8Eic
         P1V7cOwfCUMIqg+caaB2VPRd4V4zWVatl8Ka6RaIgrOcRD3t78NdQx2MF2i/EJ0+6uPk
         a0OeEL9lQZ5WSN4iNrQWeLc7ybMB1wq483FMQSrLM0oAbtKwKqckfMGw4XBhLF1upOk/
         o0Uw==
X-Gm-Message-State: AJIora/aOZdrF4v2+Fm+qVfvf/9M76rg7osrMQ4fidWdCF/+/tzosDqc
	gmSugJB4dlvRbu/vErWcSSsC97QDABc77umc+h8p/LElTXkNHxpmogT4zeuP/u7aL5rFODjR7/+
	FtU/8/fWiXxlv6j8=
X-Received: by 2002:a05:600c:3503:b0:39c:65e0:c070 with SMTP id h3-20020a05600c350300b0039c65e0c070mr5373282wmq.161.1656005155009;
        Thu, 23 Jun 2022 10:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vJyq9ZzEeWdCIMTKXFNIDyGCOfxTXaE0YEorcmZChZlK3RamVYTnhSFvza4mKsapK/OGnOUw==
X-Received: by 2002:a05:600c:3503:b0:39c:65e0:c070 with SMTP id h3-20020a05600c350300b0039c65e0c070mr5373264wmq.161.1656005154769;
        Thu, 23 Jun 2022 10:25:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:b100:7694:f34e:d0dd:95e7? (p200300cbc704b1007694f34ed0dd95e7.dip0.t-ipconnect.de. [2003:cb:c704:b100:7694:f34e:d0dd:95e7])
        by smtp.gmail.com with ESMTPSA id r13-20020a5d4e4d000000b0021b96cdf68fsm8917991wrt.97.2022.06.23.10.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 10:25:54 -0700 (PDT)
Message-ID: <5972b785-a98a-ca3d-8c21-8156dd981749@redhat.com>
Date: Thu, 23 Jun 2022 19:25:53 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To: Liam Howlett <liam.howlett@oracle.com>,
 "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "damon @ lists . linux . dev" <damon@lists.linux.dev>,
 SeongJae Park <sj@kernel.org>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-14-Liam.Howlett@oracle.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v10 13/69] mm/mmap: use maple tree for
 unmapped_area{_topdown}
In-Reply-To: <20220621204632.3370049-14-Liam.Howlett@oracle.com>
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
> The maple tree code was added to find the unmapped area in a previous
> commit and was checked against what the rbtree returned, but the actual
> result was never used.  Start using the maple tree implementation and
> remove the rbtree code.
> 
> Add kernel documentation comment for these functions.
> 
> Link: https://lkml.kernel.org/r/20220504010716.661115-15-Liam.Howlett@oracle.com
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Will Deacon <will@kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/mmap.c | 253 +++++++-----------------------------------------------
>  1 file changed, 32 insertions(+), 221 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 08845a0317bf..b91d22329418 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2053,250 +2053,61 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	return error;
>  }
>  
> +/* unmapped_area() Find an area between the low_limit and the high_limit with

/**
 * unmapped_area() - ...

> + * the correct alignment and offset, all from @info. Note: current->mm is used
> + * for the search.
> + *
> + * @info: The unmapped area information including the range (low_limit -
> + * hight_limit), the alignment offset and mask.
> + *
> + * Return: A memory address or -ENOMEM.
> + */
>  static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
>  {

...

>  
> +/* unmapped_area_topdown() Find an area between the low_limit and the

\Dito

> + * high_limit with * the correct alignment and offset at the highest available
> + * address, all from * @info. Note: current->mm is used for the search.

I'm confused about the "*" in the text, but maybe I'm just tired :)

> + *
> + * @info: The unmapped area information including the range (low_limit -
> + * hight_limit), the alignment offset and mask.
> + *
> + * Return: A memory address or -ENOMEM.
> + */
>  static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
>  {

[...]

> -found:
> -	/* We found a suitable gap. Clip it with the original high_limit. */
> -	if (gap_end > info->high_limit)
> -		gap_end = info->high_limit;
> -
> -found_highest:
> -	/* Compute highest gap address at the desired alignment */
> -	gap_end -= info->length;
> -	gap_end -= (gap_end - info->align_offset) & info->align_mask;
> -
> -	VM_BUG_ON(gap_end < info->low_limit);
> -	VM_BUG_ON(gap_end < gap_start);

Can we leave some of these in, please? (same applies to other function)

I keep getting confused by align_offset. vs align_mask. I *think* this
is correct, but some checks that we stay in limits and actually have
proper alignment would be reasonable.


-- 
Thanks,

David / dhildenb

