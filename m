Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2289548BD46;
	Fri, 25 Sep 2026 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331424; cv=none; b=Ufi1ZZp/5jXhnKfXQDpfVxXnSSXgF7hEXWP2wRzTvCU1r71aS3o6jHqRb9J3kys7ngrnDohVnyRtnKnOyU44TCExzgpBO5LNN0RBxdO6F9mVPRmTDjC1gNTbsiPIP6hf4uyUtPN5P/+otCjh1o3C8HmtFfom3afrC9TjyFRq4M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331424; c=relaxed/simple;
	bh=43+cDy52/ps+CBKBYQ21lLn2qm6ELx3ubxFjRL+evRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9LxFUkRtrkDIeFsBHyq/1l4BhhSdIGNJVoDCSfh6VaBlnfXzJKmPefKq9GVDYx4cgwAcaFBNUVNh0tKhyt+F7gBXvJUvcjSHYXrwIoTzoogKHK9kRiz4kqkjOz1tPOLcFGI5KU+ISvKhLNr4L30MnLDGmvSj7+nHW1F8ic9szg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtGYEP3N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtGYEP3N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12531F000FF;
	Fri, 25 Sep 2026 10:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790331422;
	bh=3FRgt93szZc+4T1rdPLugIec3JqcHLkBElvJ5G6NXcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AtGYEP3NP6z0cet+t6hAByQryQKCWbDouUCH0PeUQ2awHZkpi+6rIVCMldPWEVSKf
	 9+jSNbe0LOKUAzeRl6KKWc4zt6UY1eTVJStbRPyTDFHesMobiYC1YYyOKZKwZXiZe+
	 D1VAKSQJvXBQHghzF4BkwoqG9ndtKculXbPssvLsU2/ghxmVQdP5/wJk7cXW1HP37+
	 VtWtoJyYlpFBkKngpFsxGclsdb5Rkc11vHzMJOIH9evXPqUS31GAu0J+PaGN1cCUMQ
	 H901LLkjHyVZqFIAnLBWKvxAZbvknfgIrL0gZgQ1koz/76jmaDvFRym5uAYo1h/KT/
	 DPSUorNZqt2Mw==
Date: Fri, 25 Sep 2026 12:16:55 +0200
From: Gao Xiang <xiang@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: david@kernel.org, muchun.song@linux.dev, research@deepseek.com,
	sj@kernel.org, mst@redhat.com, damon@lists.linux.dev,
	linux-mm@kvack.org, virtualization@lists.linux.dev,
	ryncsn@gmail.com, kunwu.chan@gmail.com, lianux.mm@gmail.com,
	baohua@kernel.org, xueyuan.chen21@gmail.com
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Message-ID: <arZKFznn4Z2LvoJN@MacBookPro.fritz.box>
References: <9f63d60c-913e-4e79-9d28-890dd48ef713@kernel.org>
 <20260925081504.23569-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925081504.23569-1-lance.yang@linux.dev>

Hi,

On Fri, Sep 25, 2026 at 04:15:04PM +0800, Lance Yang wrote:
> +Cc DeepSeek and Muchun
> 
> On Fri, Sep 25, 2026 at 09:04:41AM +0200, David Hildenbrand (Arm) wrote:
> >On 9/25/26 07:44, Lance Yang wrote:
> >> Hi all,
> >> 
> >> I was reading DeepSeek's new DSec paper[1] and found a nice use of DAMON
> >> and virtio-balloon:
> >> 
> >> With this kind of workload, an agent may read a file once and never touch
> >> it again, while those pages remain in the guest page cache. Without memory
> >> pressure in the guest, they can stay cached even though the host would
> >> like that memory back ...
> >> 
> >> The trick is DAMON + virtio-balloon free-page reporting :) DAMON reclaims
> >
> >Heh, I read "virtio-balloon" and thought "balloon inflation/deflation, what year
> >is it?!". Free-page reporting makes much more sense.
> >
> >> cold file pages from the guest page cache; buddy gets a chance to coalesce
> >> them into reportable blocks, and virtio-balloon passes those blocks to
> >> Firecracker. Firecracker can then drop the host backing with MADV_DONTNEED.
> >
> >When I was at RH we were looking at this issue as well. virtio-pmem was one way
> >of avoiding the page cache in VM entirely. But it has its own limitations.
> 
> YES, they enable virtio-pmem with DAX for the read-only EROFS base-image
> and toolkit layers, while using DAMON with balloon free-page reporting to
> reclaim cold file pages from the guest page cache on larger writable disks.
> 
> They also point out that the guest must allocate struct page metadata for
> the entire pmem-backed address range. So virtio-pmem is not free either :)
> 
> BTW, Muchun recently posted a pretty cool series for exactly that:
> 
> https://lore.kernel.org/linux-mm/20260903122128.12264-1-songmuchun@bytedance.com/
> 
> (It shares vmemmap backing until a DAX fault needs private metadata,
> avoiding the full per-PFN cost up front.)
> 
> I have a feeling the DeepSeek team will be watching this one closely :P

There are several points virtio-pmem RW from my own viewpoints:

 - It makes the write async I/O synchronously, note that write I/Os are
   not quite the same as read I/Os (read I/Os are mostly sync). Storage
   also support multi-queues which can better leverage that, and that is
   why sometimes brd block device is not good at high-performance nvme
   for example.

 - Note that sandbox usually has a memory limit, but dax RW makes the
   whole rootfs addressable, e.g. if you have 128GiB rootfs, which means
   you could fault 128GiB on the host, instead of the sandbox memory
   size, so it might cause some security concern (as long as users
   shouldn't expect the host memory can be used up to 128GiB + memsize).

 - It can cause sync 4K faults on the host in the worst case (maybe
   large folios on the host can improve a bit yet not quite), in
   constant to the guest memory + THP usage. I don't know how the
   reclaim overhead is measured currently, but it seems the dsec paper
   also mentioned in this case.

 - The guest workload will still use mmap() for many sandbox apps, so
   `struct page` optimization is just for the optimized case, but not
   for the worst cases, the malicious VM sandboxes can still take
   much more `struct page` in the guest.

There would be better to have some benchmark here for typical RL
training RW virtio-pmem: but block storage semantics cannot already
be replaced with the memory semantics.

I think virtio-pmem RO is useful simply because it can reuse the same
page cache among multiple sandboxes on the host, which can even
warm-up other sandbox workloads, although it still has some security
concern but I guess for RL training it doesn't matter and read is
almost synchronous unlike writes.

Thanks,
Gao Xiang 

> 
> >Thanks for sharing!
> 
> Cheers!
