Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461492FB2
	for <damon@lists.linux.dev>; Tue, 13 Dec 2022 19:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7ADC433D2;
	Tue, 13 Dec 2022 19:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670959596;
	bh=QK2oIpKFkW8Y+pz74LHORvAxoSG1SnUXy4S3zV/L44U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uT2x8oDPFQmOBhB06fHpXNUG8BIaSfysV1d0mSqOFUvwRfazhlQuGTCRhl/ICwcX3
	 atRzYdVQCI2MxWZGJ1fhvuz2tWgKyT8mgq9/hsMktCizQBril30G86ftXB/uZb8pF0
	 76nhXKgy3S1DoVKbelp+0TX6l9LPsW7tJwAtk6Iek7gBQ0SjSbZ3UBHB0gJpL47izZ
	 pdTzrj9cns4eE1fHszq2m+KhynY2QYJ9/omZdazrJSvek/492QSB63e7XoGfVNWc+L
	 ShQIINlai/aocSwdyFEL+yE/VsHVs9UD8/HtoIVHIlpH+HyTxC/Mi4ZPqmU0uKksKa
	 i0z/sQc+VdkaA==
From: SeongJae Park <sj@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	vishal.moola@gmail.com,
	willy@infradead.org
Subject: Re: [PATCH -next 8/8] mm: damon: remove unneed damon_get_page()
Date: Tue, 13 Dec 2022 19:26:33 +0000
Message-Id: <20221213192633.138774-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213092735.187924-9-wangkefeng.wang@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kefeng,

On Tue, 13 Dec 2022 17:27:35 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> After all damon_get_page() callers are converted to damon_get_folio(),
> remove unneed wrapper damon_get_page().
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/damon/ops-common.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
> index 4ee607813981..35a2e42a27da 100644
> --- a/mm/damon/ops-common.h
> +++ b/mm/damon/ops-common.h
> @@ -8,13 +8,6 @@
>  #include <linux/damon.h>
>  
>  struct folio *damon_get_folio(unsigned long pfn);
> -static inline struct page *damon_get_page(unsigned long pfn)
> -{
> -	struct folio *folio = damon_get_folio(pfn);
> -
> -	return &folio->page;
> -}
> -
>  void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);

Let's keep the one blank line before damon_ptep_mkold().

>  void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
>  
> -- 
> 2.35.3

Thanks,
SJ
