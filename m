Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A437B7473
	for <damon@lists.linux.dev>; Mon,  6 Mar 2023 21:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE034C433D2;
	Mon,  6 Mar 2023 21:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678138049;
	bh=HAyqRJPBWOYhe525mNCiGvfIZWlnvzCu67PTvEwxrx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+FgstKIsqpFyF8cCJ1tHZ8P2KfFgHyOC2aeedEKRm8Pl4ga1i/uZYxLXoN6wm9mi
	 2K0y04/Gizq8hYjyImUPZd+nby8pCQrrj10Sz/zacUwMteS10Dt6VuZLFDzfM9TPCR
	 yon0HovIsuKzq5uFzKjGSMoxJf95SiDv+1J3/qpAiKtT3ipsdATLwDAxFplyu85lpB
	 8olBSf4iMCiN3w0bWk7h/D4Go4XJDDPjHSIfEwPS5/0d8xOPOGL6GAnJ1RXPlsq+BJ
	 406mwdWhQxm6QuKXKZZTcA5yEzvgwU4++mtMQTvYyG6Q01/SLW0XFnktsTve+aA6+q
	 U2J/9K+4WANMQ==
From: SeongJae Park <sj@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH v2 2/3] mm/damon/paddr: minor refactor of damon_pa_young()
Date: Mon,  6 Mar 2023 21:27:27 +0000
Message-Id: <20230306212727.303846-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202ac11d-3692-69bf-3984-627c1b9f9d38@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kefeng,

On Mon, 6 Mar 2023 09:56:49 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> 
> 
> On 2023/3/6 9:10, Kefeng Wang wrote:
> > 
> > 
> > On 2023/3/4 2:39, SeongJae Park wrote:
> >> Hi Kefeng,
> >>
> >> On Fri, 3 Mar 2023 16:43:42 +0800 Kefeng Wang 
> >> <wangkefeng.wang@huawei.com> wrote:
> >>
> >>> Omit three lines by unified folio_put(), and make code more clear.
> >>>
> >>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >>> ---
> >>>   mm/damon/paddr.c | 11 ++++-------
> >>>   1 file changed, 4 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> >>> index 3fda00a0f786..2ef9db0189ca 100644
> >>> --- a/mm/damon/paddr.c
> >>> +++ b/mm/damon/paddr.c
> >>> @@ -130,24 +130,21 @@ static bool damon_pa_young(unsigned long paddr, 
> >>> unsigned long *folio_sz)
> >>>               accessed = false;
> >>>           else
> >>>               accessed = true;
> >>> -        folio_put(folio);
> >>>           goto out;
> >>
> >> Because you moved 'out' label to not include *folio_sz setting, 
> >> folio_sz will
> >> not set in this case.  It should be set.
> > oh, it should be fixed.
> >>
> >>>       }
> >>>       need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
> >>> -    if (need_lock && !folio_trylock(folio)) {
> >>> -        folio_put(folio);
> >>> -        return false;
> >>> -    }
> 
> Hi SJ,  apart from above issue, it looks that this branch need the 
> folio_size() setting, right?

folio_sz is effectively used by caller of damon_pa_young() only if this
function returns true, so this branch doesn't need to set folio_sz.


Thanks,
SJ

> 
> Thanks
> 
> >>> +    if (need_lock && !folio_trylock(folio))
> >>> +        goto out;
> >>>       rmap_walk(folio, &rwc);
> >>>       if (need_lock)
> >>>           folio_unlock(folio);
> >>> -    folio_put(folio);
> >>> -out:
> >>>       *folio_sz = folio_size(folio);
> >>> +out:
> >>> +    folio_put(folio);
> >>
> >> Before this change, folio_size() is called after folio_put().  
> >> Shouldn't it be
> >> called before folio_put()?  If so, could we make a separate fix for 
> >> that first,
> >> and then make this change on top of it, so that it can be easily 
> >> applied to
> >> relevant stable kernels?
> >>
> > Yes， I could separate it, after folio_put(), the folio could be 
> > re-allocated and the folio_size calculation is not right.
> >>
> >> Thanks,
> >> SJ
> >>
> >>>       return accessed;
> >>>   }
> >>> -- 
> >>> 2.35.3
> >>>
> >>>
> 
