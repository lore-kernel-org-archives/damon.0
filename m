Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104635CBC
	for <damon@lists.linux.dev>; Tue, 13 Dec 2022 14:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670942579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iyz/A4LFohBBU//HBmJQ22gEPbhzpd8wIR4AqycoUGI=;
	b=OC6p8rnZKzXt3PLLVIiUa1Kx/svQIRQuD1slDqQNWz98BT13VcPyGe6g6lX8nceZ0/iJXa
	0IfYZX7dGgocecawDUykT7Rp1XudSMZQNS/hVTfslxhzKCm61vlbTQvkzzCIy1haG7O5na
	f3awDo1xhrDHfoW7q2kCZVRiy5vsOhE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-343-Is-z4CVGOTOAk17syapcsQ-1; Tue, 13 Dec 2022 09:42:58 -0500
X-MC-Unique: Is-z4CVGOTOAk17syapcsQ-1
Received: by mail-wm1-f69.google.com with SMTP id f1-20020a1cc901000000b003cf703a4f08so3127104wmb.2
        for <damon@lists.linux.dev>; Tue, 13 Dec 2022 06:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iyz/A4LFohBBU//HBmJQ22gEPbhzpd8wIR4AqycoUGI=;
        b=b8502hwGCE0Y0Z9kVc87KotZk1+O6NGuroXYktTEfM5A9zidsN1TTNRSLXXkkmGGgZ
         CPyQjE/AKymJlrOAl4fgvXa77Y4HtgBvAo5Wp3gC6vWyQk/ovT9xDIonD14fsRTtp1qj
         0810Ec+KVGaqkU2tF5inxKTuHeSLG6OJ53koCaaDF0/LmUuUyOIK0cMKxlCn30RLvaj5
         stN1sEldFdshB/F1FsREuGk2wii6+SBb+4JfzLHzhbzfLeWouYGjgb11Kqg4Uq1A5X4F
         eXsgoA5gw8p6vK2mJNnXj7dkOC0GzgBPwf1QbZfQNb0876OzdhEOxxltdvI7xDqPxWRB
         5pyA==
X-Gm-Message-State: ANoB5pnUfxI4169g1YcfIK0D/FJMtJ86W92N5XPydc7ck4zvskmxmm3A
	qZryl9+M6mubDwmRqMTL2Na9SOp9nUFn0pspd+Hmz4M+2jwa5toecU799KGeD10T3rMJTEFGeSV
	DtLBPpgVvHYMLfdk=
X-Received: by 2002:a05:600c:2101:b0:3cf:6cc7:5ba4 with SMTP id u1-20020a05600c210100b003cf6cc75ba4mr15310491wml.19.1670942577608;
        Tue, 13 Dec 2022 06:42:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7YVRH9z0xBIs04mhAg7/iqONWkZSrvGqNUVa5oK78NIvIOfGackyHj8+SAieNUQWQadWXhtA==
X-Received: by 2002:a05:600c:2101:b0:3cf:6cc7:5ba4 with SMTP id u1-20020a05600c210100b003cf6cc75ba4mr15310477wml.19.1670942577355;
        Tue, 13 Dec 2022 06:42:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:6e00:8b72:420e:df27:90c2? (p200300cbc7026e008b72420edf2790c2.dip0.t-ipconnect.de. [2003:cb:c702:6e00:8b72:420e:df27:90c2])
        by smtp.gmail.com with ESMTPSA id h67-20020a1c2146000000b003d1de805de5sm13076781wmh.16.2022.12.13.06.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 06:42:56 -0800 (PST)
Message-ID: <6d33b510-e913-5738-1e87-9f70da2ccee0@redhat.com>
Date: Tue, 13 Dec 2022 15:42:55 +0100
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
 <f07d1c95-f13c-682b-0519-0b137ccdc631@redhat.com>
 <801ccbe2-08b8-e1cb-9aee-614d59a807d2@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <801ccbe2-08b8-e1cb-9aee-614d59a807d2@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.12.22 13:13, Kefeng Wang wrote:
> 
> On 2022/12/13 19:40, David Hildenbrand wrote:
>> On 13.12.22 10:27, Kefeng Wang wrote:
>>> Introduce a wrapper function pfn_to_online_folio(), which calls
>>> pfn_to_online_page() and returns the folio of the page found,
>>> or null if no page.
>>>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>    include/linux/memory_hotplug.h | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/include/linux/memory_hotplug.h
>>> b/include/linux/memory_hotplug.h
>>> index 9fcbf5706595..e841e4fb52a7 100644
>>> --- a/include/linux/memory_hotplug.h
>>> +++ b/include/linux/memory_hotplug.h
>>> @@ -265,6 +265,13 @@ static inline void pgdat_kswapd_unlock(pg_data_t
>>> *pgdat) {}
>>>    static inline void pgdat_kswapd_lock_init(pg_data_t *pgdat) {}
>>>    #endif /* ! CONFIG_MEMORY_HOTPLUG */
>>>    +static inline struct folio *pfn_to_online_folio(unsigned long pfn)
>>> +{
>>> +    struct page *page = pfn_to_online_page(pfn);
>>> +
>>> +    return page ? page_folio(page) : NULL;
>>> +}
>>
>> Who guarantees that page_folio() is safe and stable at that point?
>>
>> IIRC, that's very tricky. We could have the page concurrently getting
>> freed and the folio dissolved.
> So the caller should consider this,  lock or get the folio in the caller?
> 

I think the helper pfn_to_online_folio() as is might be wrong approach. 
The caller should convert to a folio after taking precautions that it is 
actually safe to do that (e.g., succeeded grabbing a reference first).

-- 
Thanks,

David / dhildenb

