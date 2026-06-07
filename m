Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902742E736F
	for <damon@lists.linux.dev>; Sun,  7 Jun 2026 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780853226; cv=none; b=KPhJVK9iI7kwT9HENX9jqR7i4LQjhz6CJBfT/X75YVKnxKDQb0H23+KlOfs44q48Ia89tS28yckAgH+cI+2CeZLOG8982DET8eC9jPKzKW+MX4hzRDB55ipOoIlVFryLxzOm5bcOGaOW9uwtkFovuPc/w6J91NBkwGA04nukbmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780853226; c=relaxed/simple;
	bh=K0JkAp95wyXBDjv7DQ4JaobTcXOIBzb2vxqOY149Pao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggVLBVi5JUjB8ltRvSDxh8uw3t6Am5gcaB5NevlD5w8VACKNcou3yThyXdaX2fAT9pORU25/V7eaFgU+hTjZ4OT48CPmHuj1WETU0HD2BbFOS86zr4+Pfo9IvmFRpmnQ/fvRkSbf+afnu7rcvsef5FtlmAOnPOrPyTGTFSbrvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFmabmBx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFmabmBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDBA1F00893;
	Sun,  7 Jun 2026 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780853224;
	bh=HYQYuYCkVt3kKQnzKIyf1WPC6IaqQ9oq7NlittoyVN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UFmabmBxmonBBsAWkD3jdW+GmDnG6wKk8q4QbjEZv7ILK+QfiPjlV4kT280moYmSi
	 8ITF7W1opa6xMMXfSolfXAUm37AU8M/qTuyzbCb1Q9XE3KrE+0wFA69RejiX3876+S
	 CIbuvJm/UC9SENF+fF8OanNGhZZTlhF/2iCJjdpm62EaazHK+rlENiWDghRbNsuVrl
	 AqCANvKsbA1n5Tj+ygwFHCthcjP/mATKbw3LJ+U/CTTLEBkbLgQ6MNNi13OqG0SIT6
	 YOR1Vnf5UF3FwxUVoHCm2lNYX+R2LprvkvphDu/tfdO5W5PkFcR7bIWq8RFwiuFafh
	 3b6Uyz7qR/erA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Cunlong Li" <shenxiaogll@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/vaddr: drop redundant mmap_read_lock from damon_va_three_regions
Date: Sun,  7 Jun 2026 10:26:49 -0700
Message-ID: <20260607172650.93719-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260607140017.191771F00893@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 07 Jun 2026 14:00:16 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Unsafe lockless VMA iteration exposes `SLAB_TYPESAFE_BY_RCU` freelist pointer corruption
> 
> Pre-existing issues:
> - [High] Missing `check_stable_address_space()` validation during external `mm_struct` VMA iteration
> --
> 
> commit fc1954fba1bc736b5f26aad51449f15c4774293c
> Author: Cunlong Li <shenxiaogll@gmail.com>
> 
> mm/damon/vaddr: drop redundant mmap_read_lock from damon_va_three_regions
> 
> __damon_va_three_regions() already walks VMAs under rcu_read_lock(), so
> the outer mmap_read_lock() is no longer needed.

Is this correct?  The rcu_read_lock() is for protecting only vma traversal.
mmap_read_lock() is required for reading the entire VMAs of the snapshot.  Am I
missing something?

> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index b069dbc7e3d25..27e34596c43b8 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -77,7 +77,7 @@ static int __damon_va_three_regions(struct mm_struct *mm,
> >  	struct damon_addr_range first_gap = {0}, second_gap = {0};
> >  	VMA_ITERATOR(vmi, mm, 0);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but is it safe to iterate over
> the VMAs of an external mm_struct here without first checking
> check_stable_address_space(mm)?
> 
> If the target address space becomes unstable (for example, due to an OOM
> reap or a failed dup_mmap()), the maple tree may contain XA_ZERO_ENTRY
> markers and the mm is flagged MMF_UNSTABLE.
> 
> Without validating the address space, could the maple tree iterator
> return XA_ZERO_ENTRY as a VMA pointer and lead to a kernel panic when
> vma->vm_start is dereferenced?

We hold mmap_read_lock(), so I believe it is safe.  Correct me if I'm wrong.

> 
> >  	struct vm_area_struct *vma, *prev = NULL;
> > -	unsigned long start;
> > +	unsigned long start = 0, last_vma_end = 0;
> >  
> >  	/*
> >  	 * Find the two biggest gaps so that first_gap > second_gap > others.
> 
> [ ... ]
> 
> > @@ -140,9 +141,7 @@ static int damon_va_three_regions(struct damon_target *t,
> >  	if (!mm)
> >  		return -EINVAL;
> >  
> > -	mmap_read_lock(mm);
> >  	rc = __damon_va_three_regions(mm, regions);
> > -	mmap_read_unlock(mm);
> 
> [Severity: High]
> Does removing this mmap_read_lock() expose the VMA iteration to
> SLAB_TYPESAFE_BY_RCU freelist pointer corruption?
> 
> Since the VMA slab cache is created with SLAB_TYPESAFE_BY_RCU, a VMA can
> be freed while an RCU reader is still accessing it. When this happens,
> the SLUB allocator overwrites the first word of the structure with its
> freelist pointer (vm_freeptr).
> 
> Because vm_freeptr is in a union with vm_start and vm_end, locklessly
> reading vma->vm_start from a recently freed VMA in
> __damon_va_three_regions() will yield an unvalidated kernel freelist
> pointer instead of a valid address.
> 
> Could subtracting prev->vm_end from this corrupted pointer cause massive
> arithmetic underflows, tricking DAMON into tracking bogus memory regions?

Sounds like making sense to me.  Cunlong, what do you think?


Thanks,
SJ

[...]
