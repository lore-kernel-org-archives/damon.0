Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D418C15
	for <damon@lists.linux.dev>; Thu, 18 May 2023 17:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EF7C433EF;
	Thu, 18 May 2023 17:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684430533;
	bh=OZgSrTfO4ThuInBExHzNs7TMmFHDdgXi7iQ9bpEIZA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cu3GH6B/ShuAcPKltcQ4hxgZZVxbP8UZl0y4WcWeK3QhLDBZdN214TOVxev71vZXh
	 syOW2/1dCV1I17xeAO0gV3hQPb96EBSv5e+hpv3qDJrhW+mbidSxkWbQN+mIBMqx8N
	 Zkt/Md3dzX/R9AS2d84ruUZEuGhQ8UAbbfoeI1jfpbsSYbLsikeTr9oURt9a36ivMh
	 gVjCuNfypMRZ2xcVNnxJcRYBV1GVmv6AEeKREAuE159PbAzmhVNNPYlrgdlTmLv4oF
	 bHLVCqz/JTUBinIaYL0DJk2gya2wmJYMzG6O2h74U0rzHRO8lWENqTRSFW3eD2Isxd
	 mFhryDZ+wvqEQ==
From: SeongJae Park <sj@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 5/5] mm: ptep_deref() conversion
Date: Thu, 18 May 2023 17:22:11 +0000
Message-Id: <20230518172211.84101-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518110727.2106156-6-ryan.roberts@arm.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 May 2023 12:07:27 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> Convert all instances of direct pte_t* dereferencing to instead use
> ptep_deref() helper. By default, the helper does a direct dereference as
> before, but it can (and will) be overridden by the architecture to fully
> encapsulate the contents of the pte. Arch code is deliberately not
> converted, as the arch code knows best.
> 
> Conversion was done using Coccinelle:
> 
> ----
> 
> // $ make coccicheck \
> //          COCCI=ptepderef.cocci \
> //          SPFLAGS="--include-headers" \
> //          MODE=patch
> 
> virtual patch
> 
> @ depends on patch @
> pte_t *v;
> @@
> 
> - *v
> + ptep_deref(v)
> 
> ----
> 
> Then reviewed and hand-edited to avoid multiple unnecessary calls to
> ptep_deref(), instead opting to store the result of a single in a
> variable, where it is correct to do so. This will benefit arch-overrides
> that may be more complex than a simple (optimizable) pointer
> dereference.
> 
> Included is a fix for an issue in an earlier version of this patch that
> was pointed out by kernel test robot. The issue arose because config
> MMU=n elides definition of the ptep helper functions, including
> ptep_deref(). HUGETLB_PAGE=n configs still define a simple
> huge_ptep_clear_flush() for linking purposes, which dereferences the
> ptep. So when both configs are disabled, this caused a build error
> because ptep_deref() is not defined. Fix by continuing to do a direct
> dereference when MMU=n. This is safe because for this config the arch
> code cannot be trying to virtualize the ptes because none of the ptep
> helpers are defined.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202305120142.yXsNEo6H-lkp@intel.com/
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
[...]
>  mm/damon/ops-common.c                         |   2 +-
>  mm/damon/paddr.c                              |   2 +-
>  mm/damon/vaddr.c                              |  10 +-

For above mm/damon/ part,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

