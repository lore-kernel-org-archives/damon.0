Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D839A35898;
	Sat, 14 Mar 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773507124; cv=none; b=XizhIW/tBSJrZtQ7T6FSTC4a0qdRlL2gGF3Mo6C3ZoxaLvjT5YPEX5h+GX02hz9nnGfQYUI95oDJnLJsrynK7MfN906zXDaakIk5BKiDdYZqPC+XPHvodEoHyqHaZQ6yooVN+q4JUKSC00f4q8V88VFaqQGb5ZrdV5uCDkmflDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773507124; c=relaxed/simple;
	bh=1471jLWOVZSrytB0F0IZoWYqDTHN7f7eGn8EP41SErM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEDZwWn5XlCGfOmChQbTgY79pc0g3Y+6GEtEVNRMRrGqvaYTJpUBKwRqx9Vlcss1XJ/wePMFvIWbHhr61fBK2yaamxErrB8ZV0DO6jRmbcmqTSzuNiEHHRti8vM14ZARQzduDkjBWwinwV9kYJITY+Tk32gCD03kpEdHMV/dzfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnXToGGR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnXToGGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35980C116C6;
	Sat, 14 Mar 2026 16:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773507124;
	bh=1471jLWOVZSrytB0F0IZoWYqDTHN7f7eGn8EP41SErM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XnXToGGRBghGk8QXZ5uceCRea0ly29YIpSx7ha2B+5ePTL9ebpNTeVkpNdaKQqDb6
	 i5lSJ5MPX+mhTnnOmuxpGjxCzfZrc5xHXOabOq2rWtaVi7Ch5aqoMYmqIoNXztOpxZ
	 Z/r2AAscSLPW8nGDuJi6OvQxJpge7H2BpW+wxb7v8Bh/sjY2gv1zKLBK6N84RBB+lJ
	 P6FvUakr84i76y7UvuewFUQxqjRgI0C9gXqlm1048c13uN2gJrGm6iNUoVD/R8IZEs
	 2/XyRI9JrxeFbBE1At38Md9Y0CWTrXT8FjZAHGXXFIjGal7uUBXscyakEfxtxFfm+i
	 UqQ8/tvHCHZAw==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/damon: guard THP-specific DAMOS actions with CONFIG_TRANSPARENT_HUGEPAGE
Date: Sat, 14 Mar 2026 09:51:55 -0700
Message-ID: <20260314165156.86647-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260314093813.1359737-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Asier,

On Sat, 14 Mar 2026 09:38:12 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> MADV_HUGEPAGE and MADV_NOHUGEPAGE are guarded and they are not
> available when compiling the kernel without TRANSPARENT_HUGEPAGE
> option. Therefore, DAMOS_HUGEPAGE and DAMOS_NOHUGEPAGE shouldn't be
> available to the user either.

That makes many sense to me.  But, I'd prefer having ifdef as minimum as
possible because ifdef increases amount of code that I need to maintain per
different configurations.  I understand use of ifdef can make the resulting
kernel image more optimized.  But, unless the benefit of optimization is
obviously big enough, I'd prefer simplicity of the code in general.

When TRASPARENT_HUGEPAGE is off, DAMOS_[NO]HUGEPAGE will just silently fail.  I
think that's not a bad user experience if the silently fail is kindly informed.
How about updating document for that, but keeping the code as is?

> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> ---
>  Documentation/mm/damon/design.rst | 6 ++++--
>  include/linux/damon.h             | 2 ++
>  mm/damon/sysfs-schemes.c          | 2 ++
>  mm/damon/vaddr.c                  | 2 ++
>  4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index 29fff20b3c2a..207219ee10d4 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -460,9 +460,11 @@ that supports each action are as below.
>   - ``pageout``: Reclaim the region.
>     Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
>   - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``.
> -   Supported by ``vaddr`` and ``fvaddr`` operations set.
> +   Supported by ``vaddr`` and ``fvaddr`` operations set when
> +   TRANSPARENT_HUGEPAGE is enabled.
>   - ``nohugepage``: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``.
> -   Supported by ``vaddr`` and ``fvaddr`` operations set.
> +   Supported by ``vaddr`` and ``fvaddr`` operations set when
> +   TRANSPARENT_HUGEPAGE is enabled.

I like the above change.  I'd suggest make it just describe the current
behavior in a better way.  E.g., "Supported by vaddr and fvaddr.  When
CONFIG_TRANSPARENT_HUGEPAG is disabled, however, the application of the action
will just fail always.

>   - ``lru_prio``: Prioritize the region on its LRU lists.
>     Supported by ``paddr`` operations set.
>   - ``lru_deprio``: Deprioritize the region on its LRU lists.
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 3a441fbca170..b3fcbe84b5d7 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -138,8 +138,10 @@ enum damos_action {
>  	DAMOS_WILLNEED,
>  	DAMOS_COLD,
>  	DAMOS_PAGEOUT,
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	DAMOS_HUGEPAGE,
>  	DAMOS_NOHUGEPAGE,
> +#endif
>  	DAMOS_LRU_PRIO,
>  	DAMOS_LRU_DEPRIO,
>  	DAMOS_MIGRATE_HOT,

Also, sashiko.dev commented [1] some conrens as below:

'''
Does adding this #ifdef shift the integer values of subsequent actions like
DAMOS_STAT when CONFIG_TRANSPARENT_HUGEPAGE is disabled?
The kernel selftest tools/testing/selftests/damon/sysfs.py uses drgn to read
the internal damos->action enum value and expects hardcoded integer values
(such as 'stat': 9).
Additionally, modifying enum layouts based on kernel configuration can break
BPF and drgn tracing tools that rely on stable DWARF/BTF types.
'''

There is no selftest using DAMOS action that defined after DAMOS_HUGEPAGE, so
this change should be _safe_.  But the code does have a hard-coded mapping of
DAMOS action to value, in sysfs.py file under the DAMON selftests directory.
Maintaining it correctly with future tests for different configuration may be
challenging.

So I'd again prefer not adding ifdef.

[...]

To summarize again, how about fixing the document but keeping the code as is?

[1] https://sashiko.dev/#/patchset/20260314093813.1359737-1-gutierrez.asier%40huawei-partners.com


Thanks,
SJ
