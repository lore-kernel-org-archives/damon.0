Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BFD19523
	for <damon@lists.linux.dev>; Wed, 24 May 2023 19:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7309C433D2;
	Wed, 24 May 2023 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684955200;
	bh=GVRc+Sp9w/3xXlBsQVu0Gt2t8xcE/XUdcs2PrknnrIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KhQs1INe6kCzvHfogk+XSvMboZSn/7JsnDgsYzrpLC3uzaY72fqtCGJBwbZ6kgOwy
	 KdiYU3k3pkgjkBvtBVB+6ZfojBBijCQZ1lPQLAJlreF6ZMhcE6ISQFwTGb2jRIB4k3
	 YrSNvcq+s2fga2YfhBwK9vdmdOK6lugfX0rovb2NfPhSYUB0b8slU7RKVKAx7kP+cd
	 6MTvp8O0W/K5mUfNhaI07Hr2eLyYU6CANtyTsmTP+Cdo6xVR2FmrsjZHIt9jZgzC9I
	 NGWZWvaLg3pkzzRqa1mxCaB7kw4Z5GR70fCd53RJUtgYXsQu/6nwGtiKpBtqBnL1AG
	 3PQ58WowleodQ==
Date: Wed, 24 May 2023 22:06:18 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	damon@lists.linux.dev
Subject: Re: [PATCH v2 4/5] mm: Add new ptep_deref() helper to fully
 encapsulate pte_t
Message-ID: <20230524190618.GR4967@kernel.org>
References: <20230518110727.2106156-1-ryan.roberts@arm.com>
 <20230518110727.2106156-5-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518110727.2106156-5-ryan.roberts@arm.com>

On Thu, May 18, 2023 at 12:07:26PM +0100, Ryan Roberts wrote:
> There are many call sites that directly dereference a pte_t pointer.
> This makes it very difficult to properly encapsulate a page table in the
> arch code without having to allocate shadow page tables. ptep_deref()
> aims to solve this by replacing all direct dereferences with a call to
> this function.
> 
> The default implementation continues to just dereference the pointer
> (*ptep), so generated code should be exactly the same. However, it is
> possible for the architecture to override the default with their own
> implementation, that can (e.g.) hide certain bits from the core code, or
> determine young/dirty status by mixing in state from another source.
> 
> While ptep_get() and ptep_get_lockless() already exist, these are
> implemented as atomic accesses (e.g. READ_ONCE() in the default case).
> So rather than using ptep_get() and risking performance regressions,
> introduce an new variant.
> 
> Call sites will be converted to use the accessor in future commits.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/pgtable.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index c5a51481bbb9..1161beab2492 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -204,6 +204,13 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  #endif
>  
> +#ifndef ptep_deref
> +static inline pte_t ptep_deref(pte_t *ptep)
> +{
> +	return *(pte_t *)ptep;

Why do you need the casting here?

> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>  static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>  					    unsigned long address,
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.
