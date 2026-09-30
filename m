Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C764941D22A;
	Wed, 30 Sep 2026 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753086; cv=none; b=PgsPNPzai6X0eBLG5+B7FsjR7dz5ss7lVoErH9sbbZcw5C+elgwK2/C54KGywJ3Okf9D2w71uMIifa7OjSwZkmdudeiryhTHTADZ/MftFxkYtqp++n+cYhit6u3F0n4q/NoxRtws4OvPqcGcW1Xql/gZYdvJdARxmnp1qCERYi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753086; c=relaxed/simple;
	bh=qE3CWG0GgMClsN6LmsiKQJijbuFbmLqtvhK40Dz2ETc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNHApv0gOgOOPnaIluB0SgOdrLjAvNMubIieUqfZpwbtRrLZ/BsifuF26UhfzzGX0cd+OZbNkns6bF4o/zwt3k1NgBkwrmKvtIhSkIghYEuhZzsr6iNcHj9MmZbK13OeujELl1z65oLm/Fc2cLHn+OANgVn3e47W/HWRsQxHyxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULRyPEr4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULRyPEr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D021F000FF;
	Wed, 30 Sep 2026 07:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790753085;
	bh=KgebVyA2f8bKZ8A2l8IyTzYkpOfpYnsZpljHgtWB0X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ULRyPEr4Z7KeKV5X8kL/73Bw64SH3O5BQ0fdHMp9zZssoAuINO2fBRC6Mx8ezHtdi
	 st/YQSKBYBwvV7pNTM5biueFwqbhYF14uMmqDItKJR8EM/g7SJaunGrFBMcGuCNErp
	 W5jXoriHg1IIqnrfaKtfuzIt7kGWykpzcDFH+C031fuVwaBSXE61NxQ28pS85BeT6f
	 EmcWVaAJwy0vEkmHKKUkOygq45gQHO2WNYH2AjJtJRNVaiy3I/zVzuhMxtCyh43IFA
	 vi4ICUYZigtim8IWF6Q2FVOEeH82CtLFbduYp/qc1uyG9gMpYHC3OQKRluRKzB1cNv
	 DJcSR95vOoPVw==
Date: Wed, 30 Sep 2026 09:24:38 +0200
From: Gao Xiang <xiang@kernel.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: Gao Xiang <xiang@kernel.org>, Jialiang Huang <huang-jl@deepseek.com>,
	lance.yang@linux.dev, baohua@kernel.org, damon@lists.linux.dev,
	david@kernel.org, kunwu.chan@gmail.com, lianux.mm@gmail.com,
	linux-mm@kvack.org, mst@redhat.com, ryncsn@gmail.com, sj@kernel.org,
	virtualization@lists.linux.dev, xueyuan.chen21@gmail.com
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Message-ID: <ary5Nn9le4xG7_-N@MacBookPro>
References: <20260925054408.10431-1-lance.yang@linux.dev>
 <20260929123241.1408414-1-huang-jl@deepseek.com>
 <aruyFPzEe3pS_Qzx@XiangdeMacBook-Pro.local>
 <AA71E56E-F29A-44B2-B5A0-7806CD684B21@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AA71E56E-F29A-44B2-B5A0-7806CD684B21@linux.dev>

On Wed, Sep 30, 2026 at 11:36:23AM +0800, Muchun Song wrote:
> 
> 
> > On Sep 29, 2026, at 20:41, Gao Xiang <xiang@kernel.org> wrote:
> > 
> > On Tue, Sep 29, 2026 at 08:32:41PM +0800, Jialiang Huang wrote:
> >> Hi all,
> >> 
> >> I'm an engineer at DeepSeek. Thanks for the discussion, and thanks
> >> to everyone working on DAMON and virtio-balloon free-page reporting.
> >> They have been very useful for our workloads.
> >> 
> >> Gao Xiang wrote:
> >>> It can cause sync 4K faults on the host in the worst case
> >> 
> >> This is one of our concerns with virtio-pmem as well: moving I/O onto
> >> the page-fault path can introduce performance trade-offs. The other
> >> concern is the substantial struct page overhead for large images.
> >> 
> >> For now, we enable virtio-pmem only for moderately sized, frequently
> >> used read-only images, where there is more opportunity to share the
> >> same host page cache across sandboxes, as Gao pointed out.
> >> 
> >> Muchun's vmemmap work is also interesting to us. My understanding is
> >> that it allocates private backing for struct page metadata on demand,
> >> which could help reduce the upfront memory overhead for large images.
> > 
> > Although I haven't had a chance and time to look into that, the main
> > concern from me is that mmap() access will call
> > "dax_fault_iter->vmemmap_materialize_page()", and malicious sandbox
> > workloads (or not malicious, just valid mmap workloads) can cause guest
> > memory OOMs due to "struct page balloon" for large rootfs in the worst
> > cases and cause the follow-up mmap access failure, because the guest
> > memory size may not even fulfill "struct page" for large rootfs.
> 
> I agree that this is a real issue with v1.
> 
> One detail is that merely establishing the mapping does not materialize
> the metadata. Materialization happens when a fault resolves to an
> allocated DAX extent, before its PFN is inserted into a userspace
> mapping. However, that distinction does not remove the problem.
> 
> In the worst case, a workload can fault enough of the pmem range to
> restore the full vmemmap cost, about 1.56% of the pmem size. Since v1
> does not dematerialize private vmemmap pages, even a one-time scan can
> retain that cost until the device is removed.
> 
> The follow-up mentioned in the cover letter is intended to make the
> optimization reversible. One possible direction would be to invalidate
> clean DAX entries under memory pressure and zap their userspace
> mappings. Once a DAX entry has been removed and the corresponding PFNs
> have no remaining mappings, references, or pins that require private
> metadata, the associated vmemmap backing could be remapped to the
> shared read-only page. A later access would fault and materialize it
> again.

BTW, it's impossible for shared DAX entries (like the current XFS DAX
with reflink and EROFS will support this feature later too for chunk
memory sharing), since you cannot just use mapping and index to get
the VMA like page cache does unless you invent another new mechanism
for this.

Reclaiming page entry mechanism seems it can be used for or overlapped
to another types of memory (in order to save struct page memory in
general): I'm not sure if it needs wider discussion on reclaiming
"struct page" in general first.

Anyway, it'd be better to get some numbers with RL or agent workloads
(especially the host memory is under reasonable pressure) before
landing all these new infras upstream if proceeding in this way.

Thanks,
Gao Xiang
