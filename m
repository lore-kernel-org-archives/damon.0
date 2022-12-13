Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAC02C9D
	for <damon@lists.linux.dev>; Tue, 13 Dec 2022 11:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670931633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/wKFqPacuSwbRiY6CcY0zi15fYAnhBFmQsx8ZQhcxk=;
	b=RyUmFOFpPPXOL3AnffGi/AKV5Oh84rQpHhNwAEs0Q+aettOg8+ExLEIG6QzAxBqyWMzTp/
	xKXB1SDv9B/91juUXp0K/YTF+286n3EDiHZ4nPwOVA2tyqCRNvKZg8516tGgGOLI0LLotM
	GUa3xYvFYpHPMlcG1oSMlFsp+5C4oDY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-442-RaAUar2iPhST3fEp1x3VYg-1; Tue, 13 Dec 2022 06:40:30 -0500
X-MC-Unique: RaAUar2iPhST3fEp1x3VYg-1
Received: by mail-wm1-f72.google.com with SMTP id n8-20020a05600c294800b003d1cc68889dso2905120wmd.7
        for <damon@lists.linux.dev>; Tue, 13 Dec 2022 03:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/wKFqPacuSwbRiY6CcY0zi15fYAnhBFmQsx8ZQhcxk=;
        b=JVA/8rwHWKFfXVO2cSv2n+ULwpWzJAZ5I73YQvJnbbFXyGD5btzwWcCtvCSJFNgR92
         mFtchXDQPXw6+k6f2aZpA0Os79cb2TuhKz973NIaRTgqJXPjIxtyffdk39pL8qAeaCTu
         0yPjjqj0L6Za6ZWjWpJ6/Sk6QIxYPsUl7IU8w/pcRa48TwSWek60g/ZvtvR2I4jpDs5P
         SU+svPZOsAloHWNxVl+jkbjKbb/sjUPjzWTn+381kbit+QnXlQSD5kkVVcn7whFR9SFt
         aI8CHdeIPYaIRY201f/0ip0RCE1Cq+ViFrkghLGeYUxDgir4IP1o+fbr0mFX0kJBy3Ec
         lKpQ==
X-Gm-Message-State: ANoB5pkJSg7otxasth76y6jmXdhJ/r1oXQj0v2NT1NTQxNba8o9G2zAI
	eXnWYQfvjqthufs+6hcC7witVdf/9vmdf0KZKksJxkhqH5aUG/XYQoNW4NwvmUav/wc0GPoLW3m
	s28MjaDJxcYnv8mQ=
X-Received: by 2002:a05:600c:5109:b0:3cf:70e3:a6ad with SMTP id o9-20020a05600c510900b003cf70e3a6admr15630453wms.31.1670931628940;
        Tue, 13 Dec 2022 03:40:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6lKK8gIol22aYC/DrLGmzGYqhbxO4A+uFiCJajED3EbHfMJpJ8g1TU4b4n6DqANU2jz03mnQ==
X-Received: by 2002:a05:600c:5109:b0:3cf:70e3:a6ad with SMTP id o9-20020a05600c510900b003cf70e3a6admr15630427wms.31.1670931628479;
        Tue, 13 Dec 2022 03:40:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:6e00:8b72:420e:df27:90c2? (p200300cbc7026e008b72420edf2790c2.dip0.t-ipconnect.de. [2003:cb:c702:6e00:8b72:420e:df27:90c2])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c1c9200b003d22528decesm8899801wms.43.2022.12.13.03.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 03:40:27 -0800 (PST)
Message-ID: <f07d1c95-f13c-682b-0519-0b137ccdc631@redhat.com>
Date: Tue, 13 Dec 2022 12:40:26 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next 1/8] mm: memory_hotplug: add pfn_to_online_folio()
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, damon@lists.linux.dev,
 vishal.moola@gmail.com, willy@infradead.org
References: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
 <20221213092735.187924-2-wangkefeng.wang@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221213092735.187924-2-wangkefeng.wang@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.12.22 10:27, Kefeng Wang wrote:
> Introduce a wrapper function pfn_to_online_folio(), which calls
> pfn_to_online_page() and returns the folio of the page found,
> or null if no page.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   include/linux/memory_hotplug.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 9fcbf5706595..e841e4fb52a7 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -265,6 +265,13 @@ static inline void pgdat_kswapd_unlock(pg_data_t *pgdat) {}
>   static inline void pgdat_kswapd_lock_init(pg_data_t *pgdat) {}
>   #endif /* ! CONFIG_MEMORY_HOTPLUG */
>   
> +static inline struct folio *pfn_to_online_folio(unsigned long pfn)
> +{
> +	struct page *page = pfn_to_online_page(pfn);
> +
> +	return page ? page_folio(page) : NULL;
> +}

Who guarantees that page_folio() is safe and stable at that point?

IIRC, that's very tricky. We could have the page concurrently getting 
freed and the folio dissolved.

-- 
Thanks,

David / dhildenb

