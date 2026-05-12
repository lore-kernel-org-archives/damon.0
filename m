Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D10737204C
	for <damon@lists.linux.dev>; Tue, 12 May 2026 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594947; cv=none; b=i0H1xMuUSooLt0naXUSenTHqLVr2F+aiiYhGazRthZeX9vsJ5sIJThhShESyLXAsm9Svy0Q50M58TQYo1z+Qz84eU6u7Dy/IxN2deMYhxYUjI3bU3flSmhgmLyXv7LdvXZh8dx/kFkQzNYrTDywK+JXSdeD6pBuA36Dq+cxkgsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594947; c=relaxed/simple;
	bh=M6X22T2O9RgYZBI/BkEj/v2QLQi0oYq5BYAoCkvxfuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKX/I4ZkV+bSR4mrNuQxL/8EMP+i/JOBuRDLjQyyycFKsqStfSVv73zxYZyT+mNzWtmWU1nY4NrLeOk8Fwmb+n5mmimGKkEErgb0SlGVovf18IUAfum9oYh7OeO3uS/NwhDsyHLfZ4iEs3aHygKhkxdxPE5u6FsCbLbu0RsP/v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkZe/WFS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkZe/WFS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F79C2BCB0;
	Tue, 12 May 2026 14:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594947;
	bh=M6X22T2O9RgYZBI/BkEj/v2QLQi0oYq5BYAoCkvxfuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkZe/WFSuj2qphIdEos+JKuocohvTsGiCAtNapnNm/aM0jFSc777+gDrDZV553DQ2
	 fIJjRYQVKFnKJ1Q5TEhtK6aysXdSRNU3OxXhGA9omEu+KbBRKX6fYeg7q3hgnEnGBq
	 gR4Dcf+YG/86EYn6GCQ6lxpFKjbMfxCo5fmq7QH4vn3x1TiD/7OiIIRNChkQCuAlNq
	 UEIhpfMVmUNy7yHfY8B8TO7bg8XA9hOh7gudXJCGxWgQT5DqpgL2GW/MPqB70+nRL5
	 miwmpdKHWHQJGVQ4ZMw0gTSdm9vX+iWdID4XuYTpDC6I0ybKFcvKZ+xY/xdiX3JioH
	 0ibk0HktNvOYQ==
From: SeongJae Park <sj@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	sunnanyong@huawei.com
Subject: Re: [PATCH] mm/damon/vaddr: attempt per-vma lock during page table walk
Date: Tue, 12 May 2026 07:08:52 -0700
Message-ID: <20260512140854.111278-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <618380f2-ea7b-4855-9dc5-d655dc30d5a7@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 12 May 2026 21:59:26 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> 
> 
> On 5/12/2026 9:31 AM, SeongJae Park wrote:
> > On Mon, 11 May 2026 21:25:46 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > 
> >> Currently, DAMON virtual address operations use mmap_read_lock
> >> during page table walks, which can cause unnecessary contention
> >> under high concurrency.
> >>
> >> Introduce damon_va_walk_page_range() to first attempt acquiring a
> >> per-vma lock. If the VMA is found and the range is fully contained
> >> within it, the page table walk proceeds with the per-vma lock
> >> instead of mmap_read_lock.
> >>
> >> This optimization is particularly effective for damon_va_young()
> >> and damon_va_mkold(), which are frequently called and typically
> >> operate within a single VMA.
> > 
> > Makes sense.  Do you have some measurements?
> 
> In fact, I do not have performance-related tests.
> 
> > 
> >>
> >> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > 
> > Looks good to me.  Nonetheless, because I'm not familiar with per-vma locking,
> > I'd like to wait for Sashiko review.
> > 
> 
> Sashiko review reports a issue about handling VMAs with the VM_PFNMAP
> flag inconsistently[1]，

For other readers who may want to read the Sashiko review and might want to
commeent, it is also available [1] at lore.

> We indeed do not need to handle the vma of
> VM_PFNMAP for damon, so a quick fix is as follows,
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index eed2ae132a58..d27147603564 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -251,8 +251,11 @@ static void damon_va_walk_page_range(struct 
> mm_struct *mm, unsigned long start,
>                  goto lock_mmap;
>          }
> 
> -       ops->walk_lock = PGWALK_VMA_RDLOCK_VERIFY;
> -       walk_page_range_vma(vma, start, end, ops, private);
> +       if (!(vma->vm_flags & VM_PFNMAP)) {
> +               ops->walk_lock = PGWALK_VMA_RDLOCK_VERIFY;
> +               walk_page_range_vma(vma, start, end, ops, private);
> +       }
> +
>          vma_end_read(vma);
>          return;
> 
> Any more comments?

Looks good to me, thank you!  Could you send v2 with this change?

> 
> Thanks.
> 
> [1] 
> https://sashiko.dev/#/patchset/20260511132546.1973270-1-wangkefeng.wang@huawei.com?part=1

[1] https://lore.kernel.org/20260512052628.83798C2BCC7@smtp.kernel.org


Thanks,
SJ

[...]
