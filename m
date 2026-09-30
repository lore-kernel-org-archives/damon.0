Received: from mta1.migadu.com (out-241.mta1.migadu.com [95.215.58.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781793793A5
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761056; cv=none; b=pUB84i6jGaTuFPjH0YZ6z+lku2RLE94odADK9pWEhEqD8h6EbVKW799Ah2gaEgYE3xNrR9TW2OvEPXoQKHM5evBgpBY6UMwaaziNKTxJHVzVD0VE9cbJGUgMeMeNUKmHnUulDtbUv2kdFZc1uN1Mo2fB9laowRwF7yIylKBpRVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761056; c=relaxed/simple;
	bh=X6NhOSSQEW58fF/T8iO6Cc8WhbapIj1EK2DhImjFRYI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ux+R5em0sSUG6yOB2vWXXLI/93Lz06CcHxWK7TqatgT1dF4JzcvuWomp/nPUE/UIlwW/LQ/7o4G7exYxAiUgCWMVVcCiD2Otn7Ihu0GnMh0CSoPfnOU2VVrF43LRFeQJnCavDZJqi8A3dacUqR/W36UfmSuHdl3QDMT/u53iU3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vDaXKaPx; arc=none smtp.client-ip=95.215.58.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vDaXKaPx"
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=X6NhOSSQEW58fF/T8iO6Cc8WhbapIj1EK2DhImjFRYI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790761052; v=1; x=1791365852;
 b=vDaXKaPxoHUDe6xJBYjz/b8ax5TbwYLTCOwoNEhfLYhiepxMG3G0feiagcL8gJplJONpzP6n
 7UaYmpuzQVxXSNzMEmWt/60cDauC6JZRdlFQXy0pWDNhIoITDUu/5K5kdiqlTLeiMPzzzGnfHmb
 KW0ixfR6RPFSBS78pfS7lAKw=
X-Envelope-To: damon@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id 2848c540328b850a;
	Wed, 30 Sep 2026 09:37:31 +0000
X-Mizu-Trace-ID: 2848c540328b850a
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ary5Nn9le4xG7_-N@MacBookPro>
Date: Wed, 30 Sep 2026 17:37:11 +0800
Cc: Jialiang Huang <huang-jl@deepseek.com>,
 lance.yang@linux.dev,
 baohua@kernel.org,
 damon@lists.linux.dev,
 david@kernel.org,
 kunwu.chan@gmail.com,
 lianux.mm@gmail.com,
 linux-mm@kvack.org,
 mst@redhat.com,
 ryncsn@gmail.com,
 sj@kernel.org,
 virtualization@lists.linux.dev,
 xueyuan.chen21@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <CEE47F27-874B-486A-995F-E223249659FE@linux.dev>
References: <20260925054408.10431-1-lance.yang@linux.dev>
 <20260929123241.1408414-1-huang-jl@deepseek.com>
 <aruyFPzEe3pS_Qzx@XiangdeMacBook-Pro.local>
 <AA71E56E-F29A-44B2-B5A0-7806CD684B21@linux.dev>
 <ary5Nn9le4xG7_-N@MacBookPro>
To: Gao Xiang <xiang@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On Sep 30, 2026, at 15:24, Gao Xiang <xiang@kernel.org> wrote:
> 
> On Wed, Sep 30, 2026 at 11:36:23AM +0800, Muchun Song wrote:
>> 
>> 
>>> On Sep 29, 2026, at 20:41, Gao Xiang <xiang@kernel.org> wrote:
>>> 
>>> On Tue, Sep 29, 2026 at 08:32:41PM +0800, Jialiang Huang wrote:
>>>> Hi all,
>>>> 
>>>> I'm an engineer at DeepSeek. Thanks for the discussion, and thanks
>>>> to everyone working on DAMON and virtio-balloon free-page reporting.
>>>> They have been very useful for our workloads.
>>>> 
>>>> Gao Xiang wrote:
>>>>> It can cause sync 4K faults on the host in the worst case
>>>> 
>>>> This is one of our concerns with virtio-pmem as well: moving I/O onto
>>>> the page-fault path can introduce performance trade-offs. The other
>>>> concern is the substantial struct page overhead for large images.
>>>> 
>>>> For now, we enable virtio-pmem only for moderately sized, frequently
>>>> used read-only images, where there is more opportunity to share the
>>>> same host page cache across sandboxes, as Gao pointed out.
>>>> 
>>>> Muchun's vmemmap work is also interesting to us. My understanding is
>>>> that it allocates private backing for struct page metadata on demand,
>>>> which could help reduce the upfront memory overhead for large images.
>>> 
>>> Although I haven't had a chance and time to look into that, the main
>>> concern from me is that mmap() access will call
>>> "dax_fault_iter->vmemmap_materialize_page()", and malicious sandbox
>>> workloads (or not malicious, just valid mmap workloads) can cause guest
>>> memory OOMs due to "struct page balloon" for large rootfs in the worst
>>> cases and cause the follow-up mmap access failure, because the guest
>>> memory size may not even fulfill "struct page" for large rootfs.
>> 
>> I agree that this is a real issue with v1.
>> 
>> One detail is that merely establishing the mapping does not materialize
>> the metadata. Materialization happens when a fault resolves to an
>> allocated DAX extent, before its PFN is inserted into a userspace
>> mapping. However, that distinction does not remove the problem.
>> 
>> In the worst case, a workload can fault enough of the pmem range to
>> restore the full vmemmap cost, about 1.56% of the pmem size. Since v1
>> does not dematerialize private vmemmap pages, even a one-time scan can
>> retain that cost until the device is removed.
>> 
>> The follow-up mentioned in the cover letter is intended to make the
>> optimization reversible. One possible direction would be to invalidate
>> clean DAX entries under memory pressure and zap their userspace
>> mappings. Once a DAX entry has been removed and the corresponding PFNs
>> have no remaining mappings, references, or pins that require private
>> metadata, the associated vmemmap backing could be remapped to the
>> shared read-only page. A later access would fault and materialize it
>> again.
> 
> BTW, it's impossible for shared DAX entries (like the current XFS DAX
> with reflink and EROFS will support this feature later too for chunk
> memory sharing), since you cannot just use mapping and index to get
> the VMA like page cache does unless you invent another new mechanism
> for this.

You're right. For the reflink scenario, reclamation is currently
difficult. If we want to reclaim, it would also be in three stages:
1) reclaim the struct page corresponding to PFNs that no longer have
any mapping; 2) reclaim the cases where mappings exist but are not
reflink; 3) reclaim the reflink scenario.

These three stages go from simple to difficult. Of course, I hadn't
thought this far ahead before. So in the v1 version, not even the
first stage was implemented. At the very least, before I act, I need
enough planning and thought.

> 
> Reclaiming page entry mechanism seems it can be used for or overlapped
> to another types of memory (in order to save struct page memory in
> general): I'm not sure if it needs wider discussion on reclaiming
> "struct page" in general first.

Of course, I don't think struct page saving is the focus of the discussion
here, so we can stop discussing it.

> 
> Anyway, it'd be better to get some numbers with RL or agent workloads
> (especially the host memory is under reasonable pressure) before
> landing all these new infras upstream if proceeding in this way.

At least for now, as far as I'm concerned, I don't intend to land all the
features mentioned here. The first thing I want to address is on-demand
allocation of struct page.

Thanks,
Muchun

> 
> Thanks,
> Gao Xiang


