Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363DE7E
	for <damon@lists.linux.dev>; Thu,  4 May 2023 13:49:21 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ac82912a59so1675341fa.3
        for <damon@lists.linux.dev>; Thu, 04 May 2023 06:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683208159; x=1685800159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LBFpGrlQPOFsfKj0H7qoM29WPsISbvF7okMTDZ3TK+U=;
        b=LlHdNyvxOq/aJFLIarCVX+n+2XxI+FUiN9Ua/uL2/r8Kv44XyscNOve6J69PYvPHRT
         eaT1JVUIjHkqJKB9UtT+d6wcg9QI0h3HRlxPJNXNsnGLwBSQ0dA+I5oE/GurhM1XPK2e
         Lu+EEelmNW6EAzLJT8bjlDTeg6OpOyYHbIHfdwIZOqw1VNEAwTYfaEIrqSJwNWwMYm75
         ZikTxFI7PdyILKQu15Fm29C0bTlvJnFKrOSfY0MNHHjyCxywWT3Hrt9oGrUCp6gY36kc
         DxmaCnL0ra58wPd38WcpDNBu3MOhJa+KtAYbB32LgbtCxo6Adrj2SVEnnvAEq98kSN6K
         Juig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683208159; x=1685800159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBFpGrlQPOFsfKj0H7qoM29WPsISbvF7okMTDZ3TK+U=;
        b=Xx/qUUxA9vpJVaUyN+snuM3BtMuM7Z9EEwfdyTq1ZXD6dothzGK9k/IQ/6/Q93HExt
         dBA2PC2PuhvNnherNlKb6l3cE5F2Z+grhpGVMvUU/TcmgvhK3je1zjcYwLxKSLbhOhbb
         6KS2B/Bvup2a8ru9UmIRCoY84U9qJcBJmCLCKeUS+vvCmrW4JbWSJWaTt2Ir8gKu0fm2
         UduHxXYHmzvQHQ0oGtioImou/X6HST7pNPM3ge37G88B4k/vNR1qvhpWeZ+GSpqvTDMc
         3kohHf3hR3YmKwKzXzT5naFibyYcX7T1CJBATYZLAfHfmgUKyo6fBgRNHNnPULbEp8pu
         xsUA==
X-Gm-Message-State: AC+VfDx47ohdDtEEbUBDbsGlTYF4FaPaNT9ziLwL7c4bPngA27378mUB
	XkMPZ9hi5XG/ayjNjs3NV4Q=
X-Google-Smtp-Source: ACHHUZ54QTRhDmNzCYStoUbqDF9Izpvc1Gy1IjSapB9Ppx5bnDoTwVjq7fX0HMqfspFlqPIFqOwleA==
X-Received: by 2002:a2e:9d87:0:b0:2a9:f9ee:bd9c with SMTP id c7-20020a2e9d87000000b002a9f9eebd9cmr937137ljj.1.1683208158918;
        Thu, 04 May 2023 06:49:18 -0700 (PDT)
Received: from [192.168.88.92] (95-158-68-28.static.chello.pl. [95.158.68.28])
        by smtp.gmail.com with ESMTPSA id a13-20020a2e860d000000b002a798d12cdbsm6580758lji.116.2023.05.04.06.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 06:49:18 -0700 (PDT)
Message-ID: <29e96910-a068-3201-fa77-fb715ffca36f@gmail.com>
Date: Thu, 4 May 2023 15:47:25 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: What kind of memory is DAMON RECLAIM able to free?
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, dutkahugo@gmail.com,
 Grzegorz Uriasz <gorbak25@gmail.com>
References: <20230502012740.150413-1-sj@kernel.org>
From: Grzegorz Uriasz <gorbak25@gmail.com>
In-Reply-To: <20230502012740.150413-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi SeongJae,

/* I apologize for the duplicate email but damon@lists.linux.dev 
rejected my previous message due to embedded pictures, moved the 
screenshots to imgur ;) */

Thank you for your help and providing us a link to the DAMON user space 
tools, they are very helpful.
I've checked the memory regions and indeed there was a 3GB RAM region 
besides the largest system ram(https://imgur.com/a/q8gdV8b).

After setting the start of the monitoring region to 0 DAMOS RECLAIM 
suddenly became more responsive and ram reclamation became more 
immediate and useful. Unfortunately there is still something which holds 
DAMOS RECLAIM back.

I've changed the memory region to start from 0 and ran the same workload 
as before, Damon was able to reclaim 1GB more ram compared to my 
previous tests, unfortunately this still leaves 2GB's of unused RAM in 
the caches :( Like before after dropping the caches the cache usage 
never grows indicating the ram was idling. I've also checked that after 
rising the amount of monitoring regions in DAMON_RECLAIM from 10 to 100 
the reclamation became more effective, DAMON_RECLAIM was able to reclaim 
0.4GB more than in the last test, but this still left 1.6GB of 
reclaimable ram overall(https://imgur.com/a/FHww4XA).

My questions:
1) What is holding DAMOS RECLAIM back?
2) Is it possible to explicitly specify multiple monitoring regions in 
DAMOS RECLAIM or do i need to configure DAMOS manually from userspace 
for that?
3) How to find the number of monitoring regions where DAMOS is most 
effective?

Best Regards,
Grzegorz Uriasz

On 02/05/2023 03:27, SeongJae Park wrote:
> Hi Grzegorz,
>
> On Fri, 28 Apr 2023 16:15:12 +0200 Grzegorz Uriasz <gorbak25@gmail.com> wrote:
>
>> Hi!
>>
>> I'm running some experiments using DAMON RECLAIM on the 6.2 kernel. I've
>> set up an VM with free page reporting enabled with 16 vcores and 16GB of
>> ram with very aggressive memory reclamation settings, my kernel boot
>> line includes:
>> - transparent_hugepage=never
>> - page_reporting.page_reporting_order=0
>> - damon_reclaim.enabled=Y
>> - damon_reclaim.min_age=10000000
>> - damon_reclaim.wmarks_low=0
>> - damon_reclaim.wmarks_mid=999
>> - damon_reclaim.wmarks_high=1000
>> - damon_reclaim.quota_sz=1073741824
>> - damon_reclaim.quota_reset_interval_ms=1000
>>
>> The memory usage of the VM starts at 800 MB, after running some
>> workloads and ballooning the VM to 16 GB DAMON RECLAIM was able to
>> quickly bring the memory usage back down to 3GB, after which it just
>> stopped doing anything. What concerns me is that 20%(3.2GB for that VM)
>> is the default low watermark in the DAMON RECLAIM module. I've verified
>> that the watermarks were properly set in sysfs to my custom values, but
>> it doesn't seem to affect anything as free -mh shows 400Mb for apps but
>> 2.6GB for caches/buffers. The VM besides idling for a very long time
>> isn't able to free the buffers. When dropping the caches manually using
>> /proc/sys/vm/drop_caches the memory usage returns back to the starting
>> one. The cache/buffers don't increase at all after dropping them
>> indicating that this memory was indeed idling.
> Thank you for sharing your great experience and questions!
>
>> My questions:
>> 1. Are there types of freeable memory which DAMON is not allowed to touch?
> Basically there is no such limitation.  We implemented page type of cgroups
> based DAMOS filtering feature in v6.3, but as you're using v6.2, it shouldn't
> be related with your use case.
>
> One possible limitation for this case might be the monitoring region.  You can
> specify the region to monitor and reclaim using `monitor_region_{start,end}`
> parameters.  By default, it's set to biggest System RAM.  If your system is
> having non-countinuous System RAMs and the biggest one is not covering the 3GiB
> region, the 3GiB regions will not be moitored and therefore not reclaimed.
>
> Can you check if it is excluding the 3GiB region?  You may be able to get it
> using `proc/iomem` like files.  You could also refer to DAMON user-space tool
> to show its usage of the file[1].
>
> Also, you could get DAMON_RECLAIM internal statistics[2].  Checking those could
> also provide some hints, or help excluding unnecessary suspects.
>
>> 2. What prevents DAMON from getting back the memory?
> Other than quotas, watermarks and access pattern, there should be nothing
> preventing DAMON_RECLAIM reclaiming memory on v6.2 kernel.  DAMOS filters could
> also make some effect, but as mentioned-above, it's available from v6.3.
>
>> 2. /sys/kernel/debug/damon/* seems separate from DAMON RECLAIM,
>> /sys/module/damon_reclaim/parameters/kdamond_pid shows DAMON RECLAIM is
>> running but the DAMON debugfs doesn't show it nor exposes any registered
>> reclamation schemes.
> You're correct.  DAMON provides two main user interfaces, via debugfs
> (/sys/kernel/debug/damon/) and sysfs (/sys/kernel/mm/damon/).  Those are for
> fine-controlled use of all DAMON capabilities.  Btw, the debugfs interface is
> deprecated now, so please use the sysfs interface.
>
> DAMON modules like DAMON_RECLAIM and DAMON_LRU_SORT are for simpler control of
> DAMON for only special purpose system-wide utilization, like proactive reclaim
> and LRU lists manipulation.  Those hence provide simpler module parameters
> interface.
>
>
> [1] https://github.com/awslabs/damo/blob/next/_damo_paddr_layout.py
> [2] https://docs.kernel.org/admin-guide/mm/damon/reclaim.html#nr-reclaim-tried-regions
>
>
> Thanks,
> SJ
>
>> Best Regards,
>> Grzegorz Uriasz
