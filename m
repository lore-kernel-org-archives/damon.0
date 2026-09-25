Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E4490BE3;
	Fri, 25 Sep 2026 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790332038; cv=none; b=IGp+3N2yA8mn6FBf1MEG2EmWQb5d47PVaGxqHtzCgSvu21rEMsBXMfCJOQQ75rJugZbGNTHhkMeOsKWpUNZXkVANpukfe9ANV9mc94ODd71wHeVrJlZsC/7QXAI9CDJRWVt8pBnrOJGm7VotH/G1j01ccEdmcwkjv7aRAlhgJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790332038; c=relaxed/simple;
	bh=hczxtAvSpbWRQqK9o04gIPmruCgRPZido/AqE3QYN+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9vX/WYRIBGPc9VnIkR6U1bKyDooRR1VDjN4+SC///z+gMaD6Ep7DTjgf0plgQeOo89Yv6avHHsAF8Eq+f55SV0ZhP/3zCsSjuIfoeYD93TOsJL7cLHZPlHS3oxpIdNYKzX1+2RmptTYuH5+SIJxEzrDHte52T8PLOP/0eqY0XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw16QUas; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw16QUas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170E31F00893;
	Fri, 25 Sep 2026 10:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790332036;
	bh=xV0zw0Q7IQMSkiU/SQQ9pgJXpKqIp+csK9nbXVynRnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lw16QUasMrbf2ehZFmi/n2e+YyVirGoNCDt9qIoppC/EWnzsSrHZgpJf2Dzi3G0Bg
	 fTF8dg50qvxsnfqwj5isv9/9OQ26pBGFlgGTX2c3tjWfAkZlYr+ibV9lL7t2PymrUw
	 Sbs7vJIewjmd/FjZ6TZcBgkSMpfxCdwIhFLKfY3dMTwCkvedERJrb9vOS+CHBTlmxR
	 XEv4e6qb72JXg7VGfhu2mwDTIJK/h981twA3GD9JfzlE7fT0nvVe5vIOkfYLgYE+NT
	 yp3K6kUQPW4JiyRvKAYUpSBarAxKimWhIdgo0s++JA75szeJjRB+8Iw4AMHvIxOb5d
	 4GOfhapgqlDfg==
Date: Fri, 25 Sep 2026 12:27:09 +0200
From: Gao Xiang <xiang@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: Gao Xiang <xiang@kernel.org>, david@kernel.org, muchun.song@linux.dev,
	research@deepseek.com, sj@kernel.org, mst@redhat.com,
	damon@lists.linux.dev, linux-mm@kvack.org,
	virtualization@lists.linux.dev, ryncsn@gmail.com,
	kunwu.chan@gmail.com, lianux.mm@gmail.com, baohua@kernel.org,
	xueyuan.chen21@gmail.com
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Message-ID: <arZMfTVu4t4hdHKD@MacBookPro.fritz.box>
References: <9f63d60c-913e-4e79-9d28-890dd48ef713@kernel.org>
 <20260925081504.23569-1-lance.yang@linux.dev>
 <arZKFznn4Z2LvoJN@MacBookPro.fritz.box>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arZKFznn4Z2LvoJN@MacBookPro.fritz.box>

On Fri, Sep 25, 2026 at 12:16:55PM +0200, Gao Xiang wrote:
> Hi,
> 
> On Fri, Sep 25, 2026 at 04:15:04PM +0800, Lance Yang wrote:
> > +Cc DeepSeek and Muchun
> > 
> > On Fri, Sep 25, 2026 at 09:04:41AM +0200, David Hildenbrand (Arm) wrote:
> > >On 9/25/26 07:44, Lance Yang wrote:
> > >> Hi all,
> > >> 
> > >> I was reading DeepSeek's new DSec paper[1] and found a nice use of DAMON
> > >> and virtio-balloon:
> > >> 
> > >> With this kind of workload, an agent may read a file once and never touch
> > >> it again, while those pages remain in the guest page cache. Without memory
> > >> pressure in the guest, they can stay cached even though the host would
> > >> like that memory back ...
> > >> 
> > >> The trick is DAMON + virtio-balloon free-page reporting :) DAMON reclaims
> > >
> > >Heh, I read "virtio-balloon" and thought "balloon inflation/deflation, what year
> > >is it?!". Free-page reporting makes much more sense.
> > >
> > >> cold file pages from the guest page cache; buddy gets a chance to coalesce
> > >> them into reportable blocks, and virtio-balloon passes those blocks to
> > >> Firecracker. Firecracker can then drop the host backing with MADV_DONTNEED.
> > >
> > >When I was at RH we were looking at this issue as well. virtio-pmem was one way
> > >of avoiding the page cache in VM entirely. But it has its own limitations.
> > 
> > YES, they enable virtio-pmem with DAX for the read-only EROFS base-image
> > and toolkit layers, while using DAMON with balloon free-page reporting to
> > reclaim cold file pages from the guest page cache on larger writable disks.
> > 
> > They also point out that the guest must allocate struct page metadata for
> > the entire pmem-backed address range. So virtio-pmem is not free either :)
> > 
> > BTW, Muchun recently posted a pretty cool series for exactly that:
> > 
> > https://lore.kernel.org/linux-mm/20260903122128.12264-1-songmuchun@bytedance.com/
> > 
> > (It shares vmemmap backing until a DAX fault needs private metadata,
> > avoiding the full per-PFN cost up front.)
> > 
> > I have a feeling the DeepSeek team will be watching this one closely :P
> 
> There are several points virtio-pmem RW from my own viewpoints:
> 
>  - It makes the write async I/O synchronously, note that write I/Os are
>    not quite the same as read I/Os (read I/Os are mostly sync). Storage
>    also support multi-queues which can better leverage that, and that is
>    why sometimes brd block device is not good at high-performance nvme
>    for example.
> 
>  - Note that sandbox usually has a memory limit, but dax RW makes the
>    whole rootfs addressable, e.g. if you have 128GiB rootfs, which means
>    you could fault 128GiB on the host, instead of the sandbox memory
>    size, so it might cause some security concern (as long as users
>    shouldn't expect the host memory can be used up to 128GiB + memsize).
> 
>  - It can cause sync 4K faults on the host in the worst case (maybe
>    large folios on the host can improve a bit yet not quite), in
>    constant to the guest memory + THP usage. I don't know how the
>    reclaim overhead is measured currently, but it seems the dsec paper
>    also mentioned in this case.
> 
>  - The guest workload will still use mmap() for many sandbox apps, so
>    `struct page` optimization is just for the optimized case, but not
>    for the worst cases, the malicious VM sandboxes can still take
>    much more `struct page` in the guest.
> 
> There would be better to have some benchmark here for typical RL
> training RW virtio-pmem: but block storage semantics cannot already
> be replaced with the memory semantics.
> 
> I think virtio-pmem RO is useful simply because it can reuse the same
> page cache among multiple sandboxes on the host, which can even
> warm-up other sandbox workloads, although it still has some security
> concern but I guess for RL training it doesn't matter and read is
> almost synchronous unlike writes.

BTW, I've thought about the sandbox writable layers for a while, maybe
EROFS could have its own dedicated efficient writable layers as a
optional feature at some time, but I need to think carefully first
and look forward to get more numbers before landing a premature
implementation to the upstream (memory semantics, storage semantics
or just a overlay + hybrid approaches); also there are some
non-technical points to move forward in this direction.

There are some other important features which are more like low-hanging
fruits, so I'm more in a wait-and-see mode until I get a sensible
direction on this sandboxing scenario.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang 
> 
> > 
> > >Thanks for sharing!
> > 
> > Cheers!
> 
