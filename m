Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFEF3D79
	for <damon@lists.linux.dev>; Tue, 28 Feb 2023 22:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677624766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSkx1WZQdN5DNH0qm7hxBqFACCwZTS1b5AtHMrLmxf8=;
	b=iad5YMYerZE89p/QB6sheARbbuhukB5B3SxhgFovZZP/g1QkVQYrp8484CF2iA5cO+XCto
	V4G9Xxf9204jXjfF0TTvXf0+LKePV+ZBbPM1112VXb4y+IvozqzwwPGKVm9xxRZE3WYHwS
	dmnovwfmUnndOCmVUJ23FLAGu35PWc0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-139--khMH_9LP5yVGoH1A3M9-g-1; Tue, 28 Feb 2023 17:52:44 -0500
X-MC-Unique: -khMH_9LP5yVGoH1A3M9-g-1
Received: by mail-wm1-f70.google.com with SMTP id bi27-20020a05600c3d9b00b003e9d0925341so4136657wmb.8
        for <damon@lists.linux.dev>; Tue, 28 Feb 2023 14:52:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KSkx1WZQdN5DNH0qm7hxBqFACCwZTS1b5AtHMrLmxf8=;
        b=Vir9kBqWL1Z7IH/peu9x0MkRLaG/ou5Brw60BG0QYazDljHNoL6uw9q11SGgtFxROp
         V08jkzKwkjDDjNRpC87dpbiIO3c8rSUi+K5Atgwf9XcixbOJ0AQWJwqpjyZpgKTjFF6x
         e/90nRyBMnvKm6YQdwoNrjXZeLcV6NEfHduqtkf9jxE8/ZRR+Ezy9HAGWWrDTdgx1dp7
         e5PO2yH/D479Zw9XT6i/CpOg/be37qcTeszcbnT5K+ISh9jU16nSFIQmKfM++u17OBPo
         Y089BK8LlZLcpnKUaPCwiQVEjA16wF6SKyYSpGZhOZ7/D1IiMcKmoOz1oc/9kclKYRem
         +nBg==
X-Gm-Message-State: AO0yUKUVKdOC9UjyWiq+y+4Mof2KJ0NtWMmQZGZH7Q5bBzP0NqmrDb53
	IoOxacW4gI6aSgi/tClzi9BctFb4+JXCSpwtNNyMydeMUSqu76aH7qp66fGEWdGHGJOFew7SGBW
	sQGuPBiGJKj0rSH4=
X-Received: by 2002:a5d:59a9:0:b0:2c3:d032:5b29 with SMTP id p9-20020a5d59a9000000b002c3d0325b29mr3312281wrr.12.1677624763700;
        Tue, 28 Feb 2023 14:52:43 -0800 (PST)
X-Google-Smtp-Source: AK7set/tbtOOZ+0X8Q0TBm5m1WMfIB2tqHCEDxn7HRIEwj8y/XYzo/A2WddmJERMPSL6s+bxkUZ/hQ==
X-Received: by 2002:a5d:59a9:0:b0:2c3:d032:5b29 with SMTP id p9-20020a5d59a9000000b002c3d0325b29mr3312273wrr.12.1677624763370;
        Tue, 28 Feb 2023 14:52:43 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:b800:3757:baed:f95e:20ac? (p200300cbc706b8003757baedf95e20ac.dip0.t-ipconnect.de. [2003:cb:c706:b800:3757:baed:f95e:20ac])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6a45000000b002c5706f7c6dsm10891626wrw.94.2023.02.28.14.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 14:52:42 -0800 (PST)
Message-ID: <5751ca20-9848-af42-bd1d-c7671b5796db@redhat.com>
Date: Tue, 28 Feb 2023 23:52:41 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [LSF/MM/BPF TOPIC] VM Memory Overcommit
To: SeongJae Park <sj@kernel.org>
Cc: "T.J. Alumbaugh" <talumbau@google.com>,
 lsf-pc@lists.linux-foundation.org,
 "Sudarshan Rajagopalan (QUIC)" <quic_sudaraja@quicinc.com>, hch@lst.de,
 kai.huang@intel.com, jon@nutanix.com, Yuanchu Xie <yuanchu@google.com>,
 linux-mm <linux-mm@kvack.org>, damon@lists.linux.dev
References: <20230228223859.114846-1-sj@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230228223859.114846-1-sj@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.02.23 23:38, SeongJae Park wrote:
> On Tue, 28 Feb 2023 10:20:57 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 23.02.23 00:59, T.J. Alumbaugh wrote:
>>> Hi,
>>>
>>> This topic proposal would be to present and discuss multiple MM
>>> features to improve host memory overcommit while running VMs. There
>>> are two general cases:
>>>
>>> 1. The host and its guests operate independently,
>>>
>>> 2. The host and its guests cooperate by techniques like ballooning.
>>>
>>> In the first case, we would discuss some new techniques, e.g., fast
>>> access bit harvesting in the KVM MMU, and some difficulties, e.g.,
>>> double zswapping.
>>>
>>> In the second case, we would like to discuss a novel working set size
>>> (WSS) notifier framework and some improvements to the ballooning
>>> policy. The WSS notifier, when available, can report WSS to its
>>> listeners. VM Memory Overcommit is one of its use cases: the
>>> virtio-balloon driver can register for WSS notifications and relay WSS
>>> to the host. The host can leverage the WSS notifications and improve
>>> the ballooning policy.
>>>
>>> This topic would be of interest to a wide range of audience, e.g.,
>>> phones, laptops and servers.
>>> Co-presented with Yuanchu Xie.
>>
>> In general, having the WSS available to the hypervisor might be
>> beneficial. I recall, that there was an idea to leverage MGLRU and to
>> communicate MGLRU statistics to the hypervisor, such that the hypervisor
>> can make decisions using these statistics.
>>
>> But note that I don't think that the future will be traditional memory
>> balloon inflation/deflation. I think it might be useful in related
>> context, though.
>>
>> What we actually might want is a way to tell the OS ruining inside the
>> VM to "please try not using more than XXX MiB of physical memory" but
>> treat it as a soft limit. So in case we mess up, or there is a sudden
>> peak in memory consumption due to a workload, we won't harm the guest
>> OS/workload, and don't have to act immediately to avoid trouble. One can
>> think of it like an evolution of memory ballooning: instead of creating
>> artificial memory pressure by inflating the balloon that is fairly event
>> driven and requires explicit memory deflation, we teach the OS to do it
>> natively and pair it with free page reporting.
>>
>> All free physical memory inside the VM can be reported using free page
>> reporting to the hypervisor, and the OS will try sticking to the
>> requested "logical" VM size, unless there is real demand for more memory.
> 
> I think use of DAMON_RECLAIM[1] inside VM together with free pages reporting
> could be an option.  Some users tried that in a manual way and reported some
> positive results.  I'm trying to find a good way to provide some control of the
> in-VM DAMON_RECLAIM utilization to hypervisor.
> 

I think we might want to go one step further and not only reclaim 
(pro)actively, but also limit e.g., the growth of caches, such as the 
pagecache, to make them also aware of a soft-limit. Having that said, I 
still have to learn more about DAMON reclaim :)

> Hope to attend this session and discuss about that together.

Absolutely!

-- 
Thanks,

David / dhildenb

