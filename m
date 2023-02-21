Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D756E1C07
	for <damon@lists.linux.dev>; Tue, 21 Feb 2023 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676974122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQngTxIAa7bq5F++Qt1+J5qF8M9CFcFTXwihCMqwxiU=;
	b=LXYefHCvgn3T8u3hrl1REa7QUrtDqiQN2MhHNZEmr5+d09NFedHeB4dxMuHYax3B2t15tA
	FjFGWRIrdGJfBoov4P8YzRtcuPtrHVdKuStcmh1ys/uWi6N0HRVdpJmdYdz/mfGPJNN+6x
	unOX0OwkZ8+AjeIQrx4r5VmTL1N0J+0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-307-nY9j5BNvMReI8-L-vjGLKw-1; Tue, 21 Feb 2023 05:08:41 -0500
X-MC-Unique: nY9j5BNvMReI8-L-vjGLKw-1
Received: by mail-wm1-f72.google.com with SMTP id f14-20020a7bcc0e000000b003dd41ad974bso1674305wmh.3
        for <damon@lists.linux.dev>; Tue, 21 Feb 2023 02:08:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQngTxIAa7bq5F++Qt1+J5qF8M9CFcFTXwihCMqwxiU=;
        b=mJ94RKg5dDTf7oMbRy2RFlDnC+paMr0RR2IRbbDgfvdVoAx9nItPqe2UEqmUTW1+EB
         e1SnSLbPsA9Pb2giR+qh6B0k80r/UFaVCrdUBbqUksQlMVqIF+Ae8ExTTxm5I+Y/SViG
         ip4qTGKgtiO4TOZoNUxYYUhbU9xOq2w2kg3LonaQviQ3MWBiN0R2dPvn95xkuKBnQSmc
         HVG7lLJz3qR5UdCtMuilbulz2+rSdyGjZyk4ug0r1rlvcc+3veW6GI0ha+ZszplKhBie
         Jg7PtjHD0I/tSI+vHBGEhy5oMNnbWoihuhNGJtIdPihSyly6Ebg/x+25BY5G+P3jbQBQ
         /jQg==
X-Gm-Message-State: AO0yUKWBCAm4BZD6k4cU6aG8Yag520I39Oz+gam8vkWZN2phAch+KP9w
	zEF6pkE2MsUVY0bc2lpra0bbSGJ8tre/yB3Mxm93WrKPEmdyovHnSQdGFT/9aQqHAH1K+vTW8cB
	4JKsthEqtoXoV1/Y=
X-Received: by 2002:adf:fbc8:0:b0:2c5:5ff8:93e5 with SMTP id d8-20020adffbc8000000b002c55ff893e5mr3060438wrs.44.1676974120107;
        Tue, 21 Feb 2023 02:08:40 -0800 (PST)
X-Google-Smtp-Source: AK7set+yvZn9hxlDINT7LN34Sejar7rKnrWklRGP11gcX16WuW5/FXenaqtVUV1kKpqHEv+TURtHBg==
X-Received: by 2002:adf:fbc8:0:b0:2c5:5ff8:93e5 with SMTP id d8-20020adffbc8000000b002c55ff893e5mr3060418wrs.44.1676974119708;
        Tue, 21 Feb 2023 02:08:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:4800:aecc:dadb:40a8:ce81? (p200300cbc7074800aeccdadb40a8ce81.dip0.t-ipconnect.de. [2003:cb:c707:4800:aecc:dadb:40a8:ce81])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcc15000000b003dfdeb57027sm3086701wmh.38.2023.02.21.02.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 02:08:39 -0800 (PST)
Message-ID: <1b3e8e88-ed5c-7302-553f-4ddb3400d466@redhat.com>
Date: Tue, 21 Feb 2023 11:08:38 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
To: Andrew Yang <andrew.yang@mediatek.com>, SeongJae Park <sj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: wsd_upstream@mediatek.com, casper.lin@mediatek.com,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20230221090313.15396-1-andrew.yang@mediatek.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/damon/paddr: fix pin page problem
In-Reply-To: <20230221090313.15396-1-andrew.yang@mediatek.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.02.23 10:03, Andrew Yang wrote:
> From: "andrew.yang" <andrew.yang@mediatek.com>

Nit: I'd suggest a different subject

"mm/damon/paddr: fix missing put_page()"


Fixes: ?
Cc: stable ?


I think a patch from Willy is queued that converts this code into folios.

> 
> damon_get_page() would always increase page _refcount and
> isolate_lru_page() would increase page _refcount if the page's lru
> flag is set.
> 
> If a unevictable page isolated successfully, there will be two more
> _refcount. The one from isolate_lru_page() will be decreased in
> putback_lru_page(), but the other one from damon_get_page() will be
> left behind. This causes a pin page.
> 
> Whatever the case, the _refcount from damon_get_page() should be
> decreased.
> 
> Signed-off-by: andrew.yang <andrew.yang@mediatek.com>
> ---
>   mm/damon/paddr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index e1a4315c4be6..56d8abd08fb1 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -223,8 +223,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r)
>   			putback_lru_page(page);
>   		} else {
>   			list_add(&page->lru, &page_list);
> -			put_page(page);
>   		}
> +		put_page(page);
>   	}
>   	applied = reclaim_pages(&page_list);
>   	cond_resched();

-- 
Thanks,

David / dhildenb

