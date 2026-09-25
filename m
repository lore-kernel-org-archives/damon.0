Received: from mta1.migadu.com (out-237.mta1.migadu.com [95.215.58.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3E3839A1
	for <damon@lists.linux.dev>; Fri, 25 Sep 2026 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324116; cv=none; b=DjOMktnobyVVhlGy8VzFcSIFfpzot9uSeckRUhNg3tVqh8AJLkRUBeZwfecOGnAPr2wzqIlRzuFmYUBGafJ2FdjCaY58mGO65uwtzTqa/ILf8EmzE6+crZKsNrxbuY0XkvLghrnU5YL2y3FJJ6cC6atQMGKlIf6wvui7/psnX6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324116; c=relaxed/simple;
	bh=juiO3GcMTXWmLdFNZ5aDekSzxCw2FRDtxyNSWHdnk1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqD3IaUaJ6X63I92gmehL2SBS6psDlpCAnMfYSmGMqr3881ekmieLvQk5mkrntmWopiLKkNOetIDDqvjSqu+emmjGkur8igrvRaWAcJCT3xrAHG1N/Ey3KuT4pd0mbB8E4JRHIrcXCNeJcqLFf7jzZtp1EIySHIcRSQo2LQxb/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KRNnJLwd; arc=none smtp.client-ip=95.215.58.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KRNnJLwd"
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=juiO3GcMTXWmLdFNZ5aDekSzxCw2FRDtxyNSWHdnk1g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790324111; v=1; x=1790928911;
 b=KRNnJLwdUIq5fJcqekxo4lfAdpCs/jAWBfWjnIWqYUBxAFlskdm/kxzLMZslZtUx0aUBCw8e
 cv/gIc2bRM7OvfODZVGykpizRaA/igfaTpYWBYRe7/zfkMAUdgVf6plcopvqKCUoMbu6a/JUTMH
 H3PLxipRLHMCbRbgTztn8RXs=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 0c74c6bed6dbbf42;
	Fri, 25 Sep 2026 08:15:09 +0000
X-Mizu-Trace-ID: 0c74c6bed6dbbf42
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org,
	muchun.song@linux.dev,
	research@deepseek.com
Cc: lance.yang@linux.dev,
	sj@kernel.org,
	mst@redhat.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	ryncsn@gmail.com,
	kunwu.chan@gmail.com,
	lianux.mm@gmail.com,
	baohua@kernel.org,
	xueyuan.chen21@gmail.com
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Date: Fri, 25 Sep 2026 16:15:04 +0800
Message-ID: <20260925081504.23569-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <9f63d60c-913e-4e79-9d28-890dd48ef713@kernel.org>
References: <9f63d60c-913e-4e79-9d28-890dd48ef713@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+Cc DeepSeek and Muchun

On Fri, Sep 25, 2026 at 09:04:41AM +0200, David Hildenbrand (Arm) wrote:
>On 9/25/26 07:44, Lance Yang wrote:
>> Hi all,
>> 
>> I was reading DeepSeek's new DSec paper[1] and found a nice use of DAMON
>> and virtio-balloon:
>> 
>> With this kind of workload, an agent may read a file once and never touch
>> it again, while those pages remain in the guest page cache. Without memory
>> pressure in the guest, they can stay cached even though the host would
>> like that memory back ...
>> 
>> The trick is DAMON + virtio-balloon free-page reporting :) DAMON reclaims
>
>Heh, I read "virtio-balloon" and thought "balloon inflation/deflation, what year
>is it?!". Free-page reporting makes much more sense.
>
>> cold file pages from the guest page cache; buddy gets a chance to coalesce
>> them into reportable blocks, and virtio-balloon passes those blocks to
>> Firecracker. Firecracker can then drop the host backing with MADV_DONTNEED.
>
>When I was at RH we were looking at this issue as well. virtio-pmem was one way
>of avoiding the page cache in VM entirely. But it has its own limitations.

YES, they enable virtio-pmem with DAX for the read-only EROFS base-image
and toolkit layers, while using DAMON with balloon free-page reporting to
reclaim cold file pages from the guest page cache on larger writable disks.

They also point out that the guest must allocate struct page metadata for
the entire pmem-backed address range. So virtio-pmem is not free either :)

BTW, Muchun recently posted a pretty cool series for exactly that:

https://lore.kernel.org/linux-mm/20260903122128.12264-1-songmuchun@bytedance.com/

(It shares vmemmap backing until a DAX fault needs private metadata,
avoiding the full per-PFN cost up front.)

I have a feeling the DeepSeek team will be watching this one closely :P

>Thanks for sharing!

Cheers!
