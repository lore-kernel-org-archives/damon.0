Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB02151FCD9;
	Tue, 29 Sep 2026 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685724; cv=none; b=pQnfVhe7frgWf5bQ+4h/DHywkgCxJKyIEoV2lBV1vqyhkftgAk3UPvwqyRtBQ8BpVTlAEkfQIrk6uNzt1+W9KlXLyVULRbgQ5D9qzpLBc0cQcJ+3b1uZD4oA8zYMNiORHexuq6W2R60N0GH4i60Eei3eSkUWiKttbCLtYlh8U1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685724; c=relaxed/simple;
	bh=1F5y9F8ZtAvyl4zU7S+U+msRQUUQAOITzgLbY/EdT10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FglFwrL9rnpeMxGOjiLITyjUsyCpVnu8pKj0iHBMYbmjinl/yL2FSGNWIxJOHNXkZQf6zgr937tHXEwqHj14LFMN7K3dLsPnUm7LgHJQtXaCOH+bG1BOP2v4xaFgFjSWib6j2xiOabgMXTD98GjYd11iVxD3GceCbpc4HFTMRUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCS/AK5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCS/AK5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAF51F000FF;
	Tue, 29 Sep 2026 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685722;
	bh=+5qKJBvL/vGEVpTlmAaiJVS2DeSeFABrj9kSripxmHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lCS/AK5KZzNI93Rs6dsarMtPm/dSSopx9xP+oI1XF63w2ZX6aGxPaa85OYa2488QB
	 IJoB5BbUPQudDT4crDX5YMO8dIA0x7qgxBgC6hv62yyG5ehq1X7L5o6BSf53uCAd7S
	 Mtj/09anZZbpdFSSbTjxONc0I6o0IQUl7TvIc++zYGXnAbk0PKD2ZNTX1SGlWPHpYm
	 lzvGkzIdvB+KXdPSTcqYS9FJD/SSElF7kZYINGXULAyRPCBVxClYpOvlDIxU1UlJlo
	 g2FwQ5GH0x6BIBTsIYS0LYdxdKSFiX/dv3EiQGQHMF4kgl9yzKUiYm4DJD0fXwmE7c
	 5r+BUWzyc1gEQ==
Date: Tue, 29 Sep 2026 14:41:56 +0200
From: Gao Xiang <xiang@kernel.org>
To: Jialiang Huang <huang-jl@deepseek.com>
Cc: lance.yang@linux.dev, baohua@kernel.org, damon@lists.linux.dev,
	david@kernel.org, kunwu.chan@gmail.com, lianux.mm@gmail.com,
	linux-mm@kvack.org, mst@redhat.com, ryncsn@gmail.com, sj@kernel.org,
	virtualization@lists.linux.dev, xueyuan.chen21@gmail.com,
	xiang@kernel.org
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Message-ID: <aruyFPzEe3pS_Qzx@XiangdeMacBook-Pro.local>
References: <20260925054408.10431-1-lance.yang@linux.dev>
 <20260929123241.1408414-1-huang-jl@deepseek.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929123241.1408414-1-huang-jl@deepseek.com>

On Tue, Sep 29, 2026 at 08:32:41PM +0800, Jialiang Huang wrote:
> Hi all,
> 
> I'm an engineer at DeepSeek. Thanks for the discussion, and thanks
> to everyone working on DAMON and virtio-balloon free-page reporting.
> They have been very useful for our workloads.
> 
> Gao Xiang wrote:
> > It can cause sync 4K faults on the host in the worst case
> 
> This is one of our concerns with virtio-pmem as well: moving I/O onto
> the page-fault path can introduce performance trade-offs. The other
> concern is the substantial struct page overhead for large images.
> 
> For now, we enable virtio-pmem only for moderately sized, frequently
> used read-only images, where there is more opportunity to share the
> same host page cache across sandboxes, as Gao pointed out.
> 
> Muchun's vmemmap work is also interesting to us. My understanding is
> that it allocates private backing for struct page metadata on demand,
> which could help reduce the upfront memory overhead for large images.

Although I haven't had a chance and time to look into that, the main
concern from me is that mmap() access will call
"dax_fault_iter->vmemmap_materialize_page()", and malicious sandbox
workloads (or not malicious, just valid mmap workloads) can cause guest
memory OOMs due to "struct page balloon" for large rootfs in the worst
cases and cause the follow-up mmap access failure, because the guest
memory size may not even fulfill "struct page" for large rootfs.

Thanks,
Gao Xiang

> 
> For disks without virtio-pmem, DAMON with virtio-balloon free-page
> reporting lets us reclaim cold guest page-cache pages and return
> the memory to the host, without those virtio-pmem-specific issues.
> The two approaches complement each other in our setup.
> 
> We have not yet fully explored how best to tune the DAMON and free-page
> reporting parameters for our workloads. For example, the kernel's default
> free-page reporting granularity is 2 MiB, which is fairly coarse:
> reclaiming cold pages does not necessarily produce free blocks of that
> size. We still need to evaluate how finer reporting granularity and
> different DAMON settings affect memory savings and workload performance.
> 
> Best,
> Jialiang Huang
