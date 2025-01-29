Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A61DF268
	for <damon@lists.linux.dev>; Wed, 29 Jan 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169077; cv=none; b=ODteRSce539YcnTp3MyNgi8/SN4jcPmVlxMbx4WMQZc0bum2qAiJeKxNygIgaQZh5S7JtuBiWdIKvcm1ec856ycv/HSCAni92QFFh1mMgBwTpes+UJgsfW04OxPokObtm5WjTlL7ankOmzWJF91NgfPV/660GiAYbmLUZx6COhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169077; c=relaxed/simple;
	bh=p/+NjkcxkM4EezYfksnqPTyEygFiuuvpLQFSA0KEbH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NALbBLVhOTRASWWM0AMc78o1AdbGYn6VfP2/xA8O3xWygD+j2qgG6NzdU9KyYM/CIEXcXM71zAfQVGsEz1giIsTBThlKj3UpBY3K3fvNU8Xe9s33qjds0cCHEjiD77sFRqhrfkyA1wsQE1jl6jV2DrbC9j+tjOjvAM4XFcEhLqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JorrZU1A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JorrZU1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738169074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n2Gu/Qndi7yO7ZvaM1m+DLy9qwHQqccsR3SY/PKWVEo=;
	b=JorrZU1AyXPjI0TuY0DQ1DSMkNjwx2+SpF9npVtnOLE9oIVFKZf9h/Xp7MOxiOBa7h94nW
	WlHrdLrXRnWU3wKpon21wan1iIhNYitw9ZOsJEbmS/1OMKV0cMan1c7gNTvv/L/adPHKO/
	CqK7PbDjbfB/N3I/meOnO5F1NqAF5f4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-8mXZuKOpObiJjY7rT_cJKQ-1; Wed, 29 Jan 2025 11:44:33 -0500
X-MC-Unique: 8mXZuKOpObiJjY7rT_cJKQ-1
X-Mimecast-MFC-AGG-ID: 8mXZuKOpObiJjY7rT_cJKQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385d80576abso4402421f8f.3
        for <damon@lists.linux.dev>; Wed, 29 Jan 2025 08:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738169072; x=1738773872;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n2Gu/Qndi7yO7ZvaM1m+DLy9qwHQqccsR3SY/PKWVEo=;
        b=FX+RPdODoLqHzRbtFYyFRIWNO1rToJyP2FPCjnRBq/eO7Q4WS31xZEmyG9YxHYhyvc
         QgDKOvARmyx7pTGEup+UO+bN8+xA2tHPVChvhPZpppHA1b0H516C4OgrVqMQTHaML/Bd
         ivhszqzyUZVu09f2H7T30aWekhNBttuecyFdoJkq5bNv/uktFAKrtN+ct3VXxxY3A5yb
         dwEqwdFhOyE7I78XJoA5JodFjfFy/bfj6XH4Vq1HBlg5y040vnWLnd/WEDeu+ii6UplB
         CcOE2Mm0bmpmNZNOH8QLskRFNoQJF/p9LqWuD8SH11lfh5SeLWQhrHY3RL0zOuhQ2s64
         H8dg==
X-Gm-Message-State: AOJu0YyYyDwFy/QwQMMByDaAJsw2NHZN5pjCbTVgILYIqbQNJRquk236
	ltPmOJ4kVi46CdnZcMycxiJSZddaYC1MLCOC8mrkinG8glON5vp3Lanorn/UM1LwqHDtK4QKzot
	1HAmlJmzUo6RYLb8MzfKpec6EGQqQYzX6CNIsn17KdbRuC81H9upn
X-Gm-Gg: ASbGncsIZhXdjyfTZOAiJ59lYlZGYUBsmB+GMn3+YxUAFth2xkAVwhL1j0TdA4Z1R8q
	OOuuWrPhzKMoTCC6FH7qRRDw8f1v+/R4TRChmwqK2eg5mZGsYDyfle+aA7+hbH1KBd3e9kCebji
	2WznFOaiZytuMj3ICVSFamBS/q4EKVa4NrrI6um/X2wfrMmnz2HS/u7p+JvPf6L4lwcGFuF30zI
	dwcEmywYYRxxi2noK+9YjTlfyTcR1dx0ir162LynWOqpGYaEMRunC7rrXF3+fHVjPJfTwLu1AU5
	KjBxr542iYCo62yIkHS0JVvcSu6K2isOxvKKA7DG7mVwCpqJfGWDMpIKWT97r3DNNubwaRV+03c
	Qr1VbkXkPkyfhx4pa+glPVP/EMGQ0ovfv
X-Received: by 2002:a5d:47cd:0:b0:385:e88a:7037 with SMTP id ffacd0b85a97d-38c51939740mr3757648f8f.6.1738169071672;
        Wed, 29 Jan 2025 08:44:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQ/HByK/JSFhUNIQvMI8OQ7ivI9bcSi2qkGn2ioLNG8d6ynmmuXYyQBCxcKRDb1NWjGC37Zw==
X-Received: by 2002:a5d:47cd:0:b0:385:e88a:7037 with SMTP id ffacd0b85a97d-38c51939740mr3757626f8f.6.1738169071305;
        Wed, 29 Jan 2025 08:44:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:3b00:64b8:6719:5794:bf13? (p200300cbc7053b0064b867195794bf13.dip0.t-ipconnect.de. [2003:cb:c705:3b00:64b8:6719:5794:bf13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2e384sm29647105e9.19.2025.01.29.08.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 08:44:30 -0800 (PST)
Message-ID: <2d0eeca2-7875-415b-b20f-cebebce70f50@redhat.com>
Date: Wed, 29 Jan 2025 17:44:28 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] damon: add feature to monitor only writes
To: SeongJae Park <sj@kernel.org>,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250129055237.38547-1-sj@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250129055237.38547-1-sj@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jGVhZS7YFrxoAC-Q_vGgjjFpUVfrZz2Pp03N_DBPSeE_1738169072
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.01.25 06:52, SeongJae Park wrote:
> + linux-mm@ and David
> 
> Hi Pedro,
> 
> On Wed, 29 Jan 2025 01:40:41 -0300 Pedro Demarchi Gomes <pedrodemargomes@gmail.com> wrote:
> 
>> Add damon operation DAMON_OPS_VADDR_WRITES to monitor only writes.
> 
> Thank you for this patch!  I think this is a successor of the patch[1] that you
> posted before.  Thank you very much for continuing this work.
> 
> Nonetheless, could you please add more description about this patch including
> changes you made from the previous version?  I'm especially curious if the
> concern[2] that David raised to the previous version is solved. 

The CoW concern is resolved upstream now. You can convert pte_write(pte) 
-> !ptw_write(pte) without risking weird interactions with DMA etc.


> Motivation of
> this patch including expected usage (I remeber that you mentioned using this
> feature to find KSM-candidate memory regions, but I'm curious if you found more
> potential usages) and test/evaluation results if available.
> 
> Adding comments below to things that stand out to my eyes on a glance.
> 
> [1] https://lore.kernel.org/lkml/20220203131237.298090-1-pedrodemargomes@gmail.com/
> [2] https://lore.kernel.org/dcb5d9c7-ae5c-e0c5-adee-37f5b92281e0@redhat.com
> 
>>
>> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
>> ---
>>   include/linux/damon.h   |   5 +-
>>   mm/damon/Makefile       |   2 +-
>>   mm/damon/ops-common.c   |  80 +++++
>>   mm/damon/ops-common.h   |   3 +
>>   mm/damon/sysfs.c        |   1 +
>>   mm/damon/vaddr-writes.c | 735 ++++++++++++++++++++++++++++++++++++++++
>>   6 files changed, 824 insertions(+), 2 deletions(-)
>>   create mode 100644 mm/damon/vaddr-writes.c
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index af525252b853..9a6027faa7a6 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -485,6 +485,7 @@ struct damos {
>>    * enum damon_ops_id - Identifier for each monitoring operations implementation
>>    *
>>    * @DAMON_OPS_VADDR:	Monitoring operations for virtual address spaces
>> + * @DAMON_OPS_VADDR_WRITES: Monitoring only write operations for virtual address spaces
>>    * @DAMON_OPS_FVADDR:	Monitoring operations for only fixed ranges of virtual
>>    *			address spaces
>>    * @DAMON_OPS_PADDR:	Monitoring operations for the physical address space
>> @@ -492,6 +493,7 @@ struct damos {
>>    */
>>   enum damon_ops_id {
>>   	DAMON_OPS_VADDR,
>> +	DAMON_OPS_VADDR_WRITES,
>>   	DAMON_OPS_FVADDR,
>>   	DAMON_OPS_PADDR,
>>   	NR_DAMON_OPS,
>> @@ -846,7 +848,8 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id);
>>   
>>   static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
>>   {
>> -	return ctx->ops.id == DAMON_OPS_VADDR || ctx->ops.id == DAMON_OPS_FVADDR;
>> +	return ctx->ops.id == DAMON_OPS_VADDR || ctx->ops.id == DAMON_OPS_VADDR_WRITES
>> +	 || ctx->ops.id == DAMON_OPS_FVADDR;
>>   }
>>   
>>   static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
>> diff --git a/mm/damon/Makefile b/mm/damon/Makefile
>> index 8b49012ba8c3..c3c8dce0b34a 100644
>> --- a/mm/damon/Makefile
>> +++ b/mm/damon/Makefile
>> @@ -1,7 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   
>>   obj-y				:= core.o
>> -obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
>> +obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o vaddr-writes.o
>>   obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
>>   obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs-schemes.o sysfs.o
>>   obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
>> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
>> index d25d99cb5f2b..4a3cad303a60 100644
>> --- a/mm/damon/ops-common.c
>> +++ b/mm/damon/ops-common.c
>> @@ -9,6 +9,8 @@
>>   #include <linux/page_idle.h>
>>   #include <linux/pagemap.h>
>>   #include <linux/rmap.h>
>> +#include <linux/swap.h>
>> +#include <linux/swapops.h>
>>   
>>   #include "ops-common.h"
>>   
>> @@ -67,6 +69,84 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
>>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>   }
>>   
>> +static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
>> +{
>> +	struct folio *folio;
>> +
>> +	if (!pte_write(pte))
>> +		return false;
>> +	if (!is_cow_mapping(vma->vm_flags))
>> +		return false;
>> +	if (likely(!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags)))
>> +		return false;
>> +	folio = vm_normal_folio(vma, addr, pte);
>> +	if (!folio)
>> +		return false;
>> +	return folio_maybe_dma_pinned(folio);
>> +}
>> +
>> +static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
>> +		unsigned long addr, pmd_t *pmdp)
>> +{
>> +	pmd_t old, pmd = *pmdp;
>> +
>> +	if (pmd_present(pmd)) {
>> +		/* See comment in change_huge_pmd() */
>> +		old = pmdp_invalidate(vma, addr, pmdp);
>> +		if (pmd_dirty(old))
>> +			pmd = pmd_mkdirty(pmd);
>> +		if (pmd_young(old))
>> +			pmd = pmd_mkyoung(pmd);
>> +
>> +		pmd = pmd_wrprotect(pmd);
>> +		pmd = pmd_clear_soft_dirty(pmd);
>> +
>> +		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
>> +	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
>> +		pmd = pmd_swp_clear_soft_dirty(pmd);
>> +		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
>> +	}
>> +}
>> +
>> +static inline void clear_soft_dirty(struct vm_area_struct *vma,
>> +		unsigned long addr, pte_t *pte)
>> +{
>> +	/*
>> +	 * The soft-dirty tracker uses #PF-s to catch writes
>> +	 * to pages, so write-protect the pte as well. See the
>> +	 * Documentation/admin-guide/mm/soft-dirty.rst for full description
>> +	 * of how soft-dirty works.
>> +	 */
>> +	pte_t ptent = *pte;
>> +
>> +	if (pte_present(ptent)) {
>> +		pte_t old_pte;
>> +
>> +		if (pte_is_pinned(vma, addr, ptent))
>> +			return;
>> +		old_pte = ptep_modify_prot_start(vma, addr, pte);
>> +		ptent = pte_wrprotect(old_pte);
>> +		ptent = pte_clear_soft_dirty(ptent);
>> +		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
>> +	} else if (is_swap_pte(ptent)) {
>> +		ptent = pte_swp_clear_soft_dirty(ptent);
>> +		set_pte_at(vma->vm_mm, addr, pte, ptent);
>> +	}
>> +}
> 
> Seems you're copying code from task_mmu.c to here.  Can you explain why you do
> so instead of making those be able to use from other files and reuse?

+1

This code should not be copied in that way.

I am not sure, though, if the interaction between both interfaces is 
actually desirable, and if the interaction with VM_SOFTDIRTY is properly 
taken care of here.

soft-dirty is not something that I am particularly exited to see getting 
used more and in different context.

-- 
Cheers,

David / dhildenb

