Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A452F33
	for <damon@lists.linux.dev>; Fri,  2 Jun 2023 21:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753E0C433D2;
	Fri,  2 Jun 2023 21:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685742230;
	bh=dqPx4FOL2k0vRoOh1SeNQzO8jYCMtTwE1Ahz/eh3gWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T52eh37fLsuybop6dfq6Nc8yKoSXXOHxovVdxoFd9k8e2VfWvAUB4A4hiv7Jv8CNe
	 zH+LUIgfbwxbQgIkLmqV3x2P4RGiSSUUmzQisCmroRZAMYxMVt2MpfLkIAJbC7BotO
	 9rVVBlFEjzaaszmESNpP7VuA7nbl/8vajzWsWwgDVioznI2T69IqqO6PwP6mWK4iOs
	 LZaFc1VbjNFI8IS7mYO6ya8ylT7Igt2vFCKAEdBKweypt0OW5/ZZ2LNa8GVvXej30K
	 fZ5naFmS+rOfoytDwnjxUDA1Klx2325hWNtnB2nHoRVTy+raNQe/0q+qmrC7tRoVdV
	 79L1lsAnA0wUQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev
Subject: Re: [PATCH v3 2/4] mm/damon/ops-common: atomically test and clear young on ptes and pmds
Date: Fri,  2 Jun 2023 21:43:47 +0000
Message-Id: <20230602214347.85694-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602191501.85553-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 2 Jun 2023 19:15:01 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi Ryan,
> 
> On Fri, 2 Jun 2023 18:14:25 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
> > On 02/06/2023 17:35, Yu Zhao wrote:
> > > On Fri, Jun 2, 2023 at 3:30 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
> > >>
> > >> It is racy to non-atomically read a pte, then clear the young bit, then
> > >> write it back as this could discard dirty information. Further, it is
> > >> bad practice to directly set a pte entry within a table. Instead
> > >> clearing young must go through the arch-provided helper,
> > >> ptep_test_and_clear_young() to ensure it is modified atomically and to
> > >> give the arch code visibility and allow it to check (and potentially
> > >> modify) the operation.
> > >>
> > >> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces").
> > > 
> > > Just to double check: was "Cc: stable@vger.kernel.org" overlooked or
> > > deemed unnecessary?
> > 
> > It was overlooked - incompetance strikes again! I was intending to cc the
> > whole series.
> 
> Not the whole patches in this series but only this patch is intended to be
> merged in stable series, right?  If I'm not wrong, you could add
> 'Cc: <stable@vger.kernel.org>' tag here[1] when resending, to let stable kernel
> maintainers easily understand exactly what patches should be merged in the
> stable kernels.  So, you wouldn't need to touch coverletter or cc whole series
> but only this one.
> 
> [1] https://www.kernel.org/doc/html/v4.10/process/stable-kernel-rules.html

And I just found Andrew added the tag while adding this to the -mm queue.
Thank you, Andrew!

[1] https://lore.kernel.org/mm-commits/20230602205509.9DFBDC433D2@smtp.kernel.org/


Thanks,
SJ

> 
> 
> Thanks,
> SJ
> 
