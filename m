Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BD01FD7
	for <damon@lists.linux.dev>; Thu,  2 Mar 2023 09:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677749542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkrOJUQ60Wu48EXn1l+hwmQScNz7d/g4W7cVaHobRd0=;
	b=ZsI/5H7jSMDdGjfikN29d6KXMhrhktNrymZQJK7MbFHEUQbhnUXEHY8VBfOzezWyVb15PT
	Chs54H2Dn6warQS22F/XlD6+WJeSVT4n7MeN7O8ER2X+nZDRPgAoE8DoSKz9B/V++YlfQ5
	jcggLYxRNeQIF5SQD0y0PUd2TjqQeUA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-HN0tsqnMNWq7GfKDF6qFkA-1; Thu, 02 Mar 2023 04:32:21 -0500
X-MC-Unique: HN0tsqnMNWq7GfKDF6qFkA-1
Received: by mail-wr1-f72.google.com with SMTP id u5-20020a5d6da5000000b002cd82373455so1963835wrs.9
        for <damon@lists.linux.dev>; Thu, 02 Mar 2023 01:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkrOJUQ60Wu48EXn1l+hwmQScNz7d/g4W7cVaHobRd0=;
        b=KOQJqFgwHvobdu9vIV+NTQdW0vElH5oPOsk2b9a5IacVYHj57VZFR5uEIdIiB7Auip
         QrlmUc1Q6WJdinmStKUDFan4PeiH9XQ9CnQsHRvR6tuxXDKmNhfPYw0UYd7ULwW0YuRX
         i4fgnkHuuk+OEFBC52kGe/9glcM1QFh3DY6CEK0xxiRLU7GsXUK5HgsonAPlgObI8uYS
         CfSuwaAiPQTd/cAcv1kBrYsIjTs5wTEDLWdtMkrufM/8jrysddPInKg51DNDo9MP0P1s
         uppHJB/29z3ADt1aLAuNH0HEgXBISV3/DDQbtcNY47zXMgadCxCk+hmCJAoAlIoE4Udc
         7AIw==
X-Gm-Message-State: AO0yUKU2586BWVW6lWCM+xks/kLR8gJnSqyRYf5PxTkr2jx2iRzWg7d+
	o+RgzCn+3dZ3yjJexZM7qKmO3x2oc6WAcwgjjAD3NpZNEeiIbBUuqQMXMyktZQ0NgDSm+m8BqYn
	xPYmgfxKf0mdqBT0=
X-Received: by 2002:a05:600c:908:b0:3eb:20f6:2d5c with SMTP id m8-20020a05600c090800b003eb20f62d5cmr7595255wmp.35.1677749540155;
        Thu, 02 Mar 2023 01:32:20 -0800 (PST)
X-Google-Smtp-Source: AK7set/EkA1BVOmlC4m1V0JoTxXzQ7lRvvoVOnyBHvW2/3P7CH7tSLE6ruLitx/3WkxtqGZKJ8Y7zg==
X-Received: by 2002:a05:600c:908:b0:3eb:20f6:2d5c with SMTP id m8-20020a05600c090800b003eb20f62d5cmr7595230wmp.35.1677749539819;
        Thu, 02 Mar 2023 01:32:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:4f00:87ba:e9e9:3821:677b? (p200300cbc70e4f0087bae9e93821677b.dip0.t-ipconnect.de. [2003:cb:c70e:4f00:87ba:e9e9:3821:677b])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b003e11f280b8bsm2360750wmq.44.2023.03.02.01.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 01:32:19 -0800 (PST)
Message-ID: <e660ae94-7b7b-19a4-3748-60432ab389df@redhat.com>
Date: Thu, 2 Mar 2023 10:32:18 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [LSF/MM/BPF TOPIC] VM Memory Overcommit
To: David Rientjes <rientjes@google.com>
Cc: SeongJae Park <sj@kernel.org>, "T.J. Alumbaugh" <talumbau@google.com>,
 lsf-pc@lists.linux-foundation.org,
 "Sudarshan Rajagopalan (QUIC)" <quic_sudaraja@quicinc.com>, hch@lst.de,
 kai.huang@intel.com, jon@nutanix.com, Yuanchu Xie <yuanchu@google.com>,
 linux-mm <linux-mm@kvack.org>, damon@lists.linux.dev
References: <20230228223859.114846-1-sj@kernel.org>
 <5751ca20-9848-af42-bd1d-c7671b5796db@redhat.com>
 <c57f3f06-5079-6e28-5238-c5731ee02a6e@google.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c57f3f06-5079-6e28-5238-c5731ee02a6e@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.03.23 04:26, David Rientjes wrote:
> On Tue, 28 Feb 2023, David Hildenbrand wrote:
> 
>> On 28.02.23 23:38, SeongJae Park wrote:
>>> On Tue, 28 Feb 2023 10:20:57 +0100 David Hildenbrand <david@redhat.com>
>>> wrote:
>>>
>>>> On 23.02.23 00:59, T.J. Alumbaugh wrote:
>>>>> Hi,
>>>>>
>>>>> This topic proposal would be to present and discuss multiple MM
>>>>> features to improve host memory overcommit while running VMs. There
>>>>> are two general cases:
>>>>>
>>>>> 1. The host and its guests operate independently,
>>>>>
>>>>> 2. The host and its guests cooperate by techniques like ballooning.
>>>>>
>>>>> In the first case, we would discuss some new techniques, e.g., fast
>>>>> access bit harvesting in the KVM MMU, and some difficulties, e.g.,
>>>>> double zswapping.
>>>>>
>>>>> In the second case, we would like to discuss a novel working set size
>>>>> (WSS) notifier framework and some improvements to the ballooning
>>>>> policy. The WSS notifier, when available, can report WSS to its
>>>>> listeners. VM Memory Overcommit is one of its use cases: the
>>>>> virtio-balloon driver can register for WSS notifications and relay WSS
>>>>> to the host. The host can leverage the WSS notifications and improve
>>>>> the ballooning policy.
>>>>>
>>>>> This topic would be of interest to a wide range of audience, e.g.,
>>>>> phones, laptops and servers.
>>>>> Co-presented with Yuanchu Xie.
>>>>
>>>> In general, having the WSS available to the hypervisor might be
>>>> beneficial. I recall, that there was an idea to leverage MGLRU and to
>>>> communicate MGLRU statistics to the hypervisor, such that the hypervisor
>>>> can make decisions using these statistics.
>>>>
>>>> But note that I don't think that the future will be traditional memory
>>>> balloon inflation/deflation. I think it might be useful in related
>>>> context, though.
>>>>
>>>> What we actually might want is a way to tell the OS ruining inside the
>>>> VM to "please try not using more than XXX MiB of physical memory" but
>>>> treat it as a soft limit. So in case we mess up, or there is a sudden
>>>> peak in memory consumption due to a workload, we won't harm the guest
>>>> OS/workload, and don't have to act immediately to avoid trouble. One can
>>>> think of it like an evolution of memory ballooning: instead of creating
>>>> artificial memory pressure by inflating the balloon that is fairly event
>>>> driven and requires explicit memory deflation, we teach the OS to do it
>>>> natively and pair it with free page reporting.
>>>>
>>>> All free physical memory inside the VM can be reported using free page
>>>> reporting to the hypervisor, and the OS will try sticking to the
>>>> requested "logical" VM size, unless there is real demand for more memory.
>>>
>>> I think use of DAMON_RECLAIM[1] inside VM together with free pages reporting
>>> could be an option.  Some users tried that in a manual way and reported some
>>> positive results.  I'm trying to find a good way to provide some control of
>>> the
>>> in-VM DAMON_RECLAIM utilization to hypervisor.
>>>
>>
>> I think we might want to go one step further and not only reclaim
>> (pro)actively, but also limit e.g., the growth of caches, such as the
>> pagecache, to make them also aware of a soft-limit. Having that said, I still
>> have to learn more about DAMON reclaim :)
>>
> 
> I'm curious, is this limitation possible to impose with memcg today or are
> specifically looking to provide a cap on page cache, dentries, inodes,
> etc, without specifically requiring memcg?

Good question, I remember the last time that topic was raised, the 
common understanding was that existing mechanisms (i.e., memcg) were not 
sufficient. But I am no expert on this, so this sure sounds like a good 
topic to discuss in a bigger group, with hopefully some memcg experts 
around :)

-- 
Thanks,

David / dhildenb

