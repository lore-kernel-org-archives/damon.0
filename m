Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580B627510E
	for <damon@lists.linux.dev>; Mon, 16 Jun 2025 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067168; cv=none; b=SL3RguhIxWqqP9UJbfMOTLCF0xm8ahM7FBrHmcFajACh+l3ORXQhmPq1lFrlRnXb5dAsxTD+JQrBXf95LVOjEmqDZy10OPJozjFvSlDDOEk2pVlO1Vo/P731EsliIbotr7MAwAcdcEVVb7/BKV5tG0uyFPznHZdMRg4tqQB3qCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067168; c=relaxed/simple;
	bh=BI8LIOoaWxZ9ZU4rqgk8yOCwSaiMDSfmMVuZY888waE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWOdVApA9QfsPKjuI2RUfSm6XUqIMQwYAEBHyNziGZN9nU8aHRzwt2jTUmhb2wFYwz+anQmgG0Mkvbk2r7r2wZh3vCeMW1Zi9ObbsRUsB2K3MEBuErNv1UuKybBxcCkLwkxBvl5HTBGDleYL+Qy7jkRAkWYB1kMsRHa1PiVcT4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqAvg7zT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqAvg7zT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750067165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9LpBwQhNiE5GmshdXCIa53CrveoAMtvXDG7n1Vt+nVY=;
	b=bqAvg7zTQPcyhWMTL9qyvkFeocH7Eh1XFRuXS14Xylb64WEbItTIuYITCwyC89aKsFwxI5
	McyineyJohyqidjzAqEixw4jrBpZfgrM5BbEG29Ronp4bz7ZLGSHmEkHsKUqAtmkCJFRI8
	vecy1YQentoGXLCuf9W+iLBThdVbMB8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-sPWlKfo7Pr-Dgn3D4qRA1w-1; Mon, 16 Jun 2025 05:46:01 -0400
X-MC-Unique: sPWlKfo7Pr-Dgn3D4qRA1w-1
X-Mimecast-MFC-AGG-ID: sPWlKfo7Pr-Dgn3D4qRA1w_1750067160
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451dda846a0so32608525e9.2
        for <damon@lists.linux.dev>; Mon, 16 Jun 2025 02:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750067160; x=1750671960;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9LpBwQhNiE5GmshdXCIa53CrveoAMtvXDG7n1Vt+nVY=;
        b=EYttCnAlPFJBFR0GRAew3VSJCFkc/QXc0EzPa8E5PTdJb9x2VBRSvX+LF9SgWUbxH5
         MMYXr5Vr05FnJZBohMhJEp36/5nptE8eP/9rGvG1Q2nLLm8YAIzLRIm26FAOrqTDtogX
         xwm38Bt/lf4Y2Dwliv7DokPh+tKQBjhWGNF/DymMCB5cDOMTg383/+NVTYWITdc7txJw
         CD/VmqKNXSPMtvdCddujmG97xXp9nOa0uyS89rcaEIIFYEN3D2woOhAlOSFaxr0VZ9gM
         lR0L9dHzz8rRIghv2p2XwturOvDje75ndKZeh0MZYx1AGKMLlsuSzr24DAQ6cDPCXXMn
         /tjA==
X-Forwarded-Encrypted: i=1; AJvYcCXf0mrGwkRpQLIawzo6A8ZQif6Pvwc1B1KjudpYsyu5+SBVtaleh3ftgcAIM8wg/J4nIObWXA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyf0hjQCUkWBQNwUGMmr08hNyjvj1wYjD5MUkvzCau+T6ZSBOcb
	aOKslVaC7PylxJxlkXBQBz60UzYP2G7LHFe512ln1BDkeYu3B5UJPGrDhAYKAXCSLHi8J3VbM4U
	NxSQCio5jaTWeiAc4q78cMRsc9C4wsVcytrvun+QczHL9kE4HgnfHXd6x
X-Gm-Gg: ASbGncubKXIm7F7j3kWYDRZ1/2e5jfW4kkUvzr2BgP7+fadwp+GlFVfTAovbtdmoNFG
	DbnO8vt30YcTKd/2lMi3Sk/2deCxRqckcxqkJTga5cATrtsJ6gJM2aEkKuNEFuqO/JOIi3EaNda
	nfKtgJzhJlJAvdwxCeEcXRid7CrQwaZzAjTu34HVD78AiPu/J7wBDeeyYQ1KRX5FWUG1779SnNv
	9Yfsq8TRofuDozHkIn/MKXzTUDZNVVxlvD20VvldJefqLr9slpYPaCuJLO3It3MGvj2yR3gAZO7
	z4ww8fKkhXBoA8hj2qCWBlM/QiNb6VhUL42IntkFaPinQqUcmLrEbMHEPfw2tH7CfoEh9bN/3mx
	gefZ1ji+XVpGyjH8QwY82qMc6jUr6Z9AgaBW6aQiZs/ZpHPk=
X-Received: by 2002:a05:600c:a016:b0:450:d3b9:4ba2 with SMTP id 5b1f17b1804b1-4533cac06acmr74755425e9.24.1750067160424;
        Mon, 16 Jun 2025 02:46:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBSBsqoa72A42RcmXkBG9lG51qenCWppKc7zo8qZQnQmQOSEpYDrQSdVz/aVJQr08DxTPJ8g==
X-Received: by 2002:a05:600c:a016:b0:450:d3b9:4ba2 with SMTP id 5b1f17b1804b1-4533cac06acmr74755055e9.24.1750067159963;
        Mon, 16 Jun 2025 02:45:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:bd00:949:b5a9:e02a:f265? (p200300d82f25bd000949b5a9e02af265.dip0.t-ipconnect.de. [2003:d8:2f25:bd00:949:b5a9:e02a:f265])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b087f8sm10750271f8f.53.2025.06.16.02.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 02:45:59 -0700 (PDT)
Message-ID: <e40aa590-f0a2-4666-84b0-c33c8f4fef87@redhat.com>
Date: Mon, 16 Jun 2025 11:45:58 +0200
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm/mempolicy: Expose policy_nodemask() in
 include/linux/mempolicy.h
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, sj@kernel.org, akpm@linux-foundation.org,
 corbet@lwn.net, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 bijantabatab@micron.com, venkataravis@micron.com, emirakhur@micron.com,
 ajayjoshi@micron.com, vtavarespetr@micron.com, damon@lists.linux.dev
References: <20250612181330.31236-1-bijan311@gmail.com>
 <20250612181330.31236-2-bijan311@gmail.com>
 <5a50eeba-b26d-4913-8016-45278608a1ee@redhat.com>
 <CAMvvPS5U8exSvy0fknfhv8ym_dKgMVa7cfMOqn0fGyd+NSjSuQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAMvvPS5U8exSvy0fknfhv8ym_dKgMVa7cfMOqn0fGyd+NSjSuQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x577mL8Nj9nTIVgCthQ-YKey4vbf0Y7r2qTBseu-tP8_1750067160
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.06.25 18:33, Bijan Tabatabai wrote:
> On Fri, Jun 13, 2025 at 8:45 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 12.06.25 20:13, Bijan Tabatabai wrote:
>>> From: Bijan Tabatabai <bijantabatab@micron.com>
>>>
>>> This patch is to allow DAMON to call policy_nodemask() so it can
>>> determine where to place a page for interleaving.
>>>
>>> Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
>>> ---
>>>    include/linux/mempolicy.h | 9 +++++++++
>>>    mm/mempolicy.c            | 4 +---
>>>    2 files changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
>>> index 0fe96f3ab3ef..e96bf493ff7a 100644
>>> --- a/include/linux/mempolicy.h
>>> +++ b/include/linux/mempolicy.h
>>> @@ -133,6 +133,8 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
>>>    struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
>>>                unsigned long addr, int order, pgoff_t *ilx);
>>>    bool vma_policy_mof(struct vm_area_struct *vma);
>>> +nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
>>> +             pgoff_t ilx, int *nid);
>>>
>>>    extern void numa_default_policy(void);
>>>    extern void numa_policy_init(void);
>>> @@ -232,6 +234,13 @@ static inline struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
>>>        return NULL;
>>>    }
>>>
>>> +static inline nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
>>> +                             pgoff_t ilx, int *nid)
>>> +{
>>> +     *nid = NUMA_NO_NODE;
>>> +     return NULL;
>>> +}
>>> +
>>>    static inline int
>>>    vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
>>>    {
>>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>>> index 3b1dfd08338b..54f539497e20 100644
>>> --- a/mm/mempolicy.c
>>> +++ b/mm/mempolicy.c
>>> @@ -596,8 +596,6 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
>>>
>>>    static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
>>>                                unsigned long flags);
>>> -static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
>>> -                             pgoff_t ilx, int *nid);
>>>
>>>    static bool strictly_unmovable(unsigned long flags)
>>>    {
>>> @@ -2195,7 +2193,7 @@ static unsigned int interleave_nid(struct mempolicy *pol, pgoff_t ilx)
>>>     * Return a nodemask representing a mempolicy for filtering nodes for
>>>     * page allocation, together with preferred node id (or the input node id).
>>>     */
>>> -static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
>>> +nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
>>>                                   pgoff_t ilx, int *nid)
>>>    {
>>>        nodemask_t *nodemask = NULL;
>>
>> You actually only care about the nid for your use case.
>>
>> Maybe we should add
>>
>> get_vma_policy_node() that internally does a get_vma_policy() to then
>> give you only the node back.
>>
>> If get_vma_policy() is not the right thing (see my reply to patch #2),
>> of course a get_task_policy_node() could be added.
>>
>> --
>> Cheers,
>>
>> David / dhildenb
> 
> Hi David,

Hi,

> 
> I did not use get_vma_policy or mpol_misplaced, which I believe is the
> closest function that exists for what I want in this patch, because
> those functions

I think what you mean is, that you are performing an rmap walk. But 
there, you do have a VMA + MM available (stable).

> seem to assume they are called inside of the task that the folio/vma
> is mapped to.

But, we do have a VMA at hand, so why would we want to ignore any set 
policy? (I think VMA policies so far only apply to shmem, but still).

I really think you want to use get_vma_policy() instead of the task policy.


> More specifically, mpol_misplaced assumes it is being called within a
> page fault.
> This doesn't work for us, because we call it inside of a kdamond process.

Right.

But it uses the vmf only for ...

1) Obtaining the VMA
2) Sanity-checking that the ptlock is held.

Which, you also have during the rmap walk.


So what about factoring out that handling from mpol_misplaced(), having 
another function where you pass the VMA instead of the vmf?

> 
> I would be open to adding a new function that takes in a folio, vma,
> address, and
> task_struct and returns the nid the folio should be placed on. It could possibly
> be implemented as a function internal to mpol_misplaced because the two would
> be very similar.

Good, you had the same thought :)

> 
> How would you propose we handle MPOL_BIND and MPOL_PREFFERED_MANY
> in this function? mpol_misplaced chooses a nid based on the node and
> cpu the fault
> occurred on, which we wouldn't have in a kdamond context. The two options I see
> are either:
> 1. return the nid of the first node in the policy's nodemask
> 2. return NUMA_NO_NODE
> I think I would lean towards the first.

I guess we'd need a way for your new helper to deal with both cases 
(is_fault vs. !is_fault), and make a decision based on that.


For your use case, you can then decide what would be appropriate. It's a 
good question what the appropriate action would be: 1) sounds better, 
but I do wonder if we would rather want to distribute the folios in a 
different way across applicable nodes, not sure ...

-- 
Cheers,

David / dhildenb

