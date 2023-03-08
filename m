Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A78462
	for <damon@lists.linux.dev>; Wed,  8 Mar 2023 18:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9319BC433EF;
	Wed,  8 Mar 2023 18:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678299439;
	bh=WSCK4EjboqTykWYFTwfbIgSgksqAobdYHV2zBrtxayQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fm9Tp+jDqiNJLqPdubQL+sEqoF7WZwjzbyVuKq+9MWn9ysbdCt5ZNPU6JbsKRN9Zg
	 JkNLuMwYtPX2w/9tvhKaBqMIj07vlY3iYlZlBEYZJPY9ZMIejpGFpG1QswMMXHZAP5
	 YNk/VSlUjOYLNxMQknxZksyrIkd43L/P54M3dWwVGmuGZuqoyVE94rUkuy0/CjfH7C
	 9xk+6GsVbcc/U3HEIPRscOwUkG2+2HIyUaaP8ISTMxMUgD+3f/BkZjqMgaeq03nomF
	 Sm74VuBfnURUVXRNZbd1apZCYyTbaV/1QwjQfG33+M+J5fNwGfJNRZ0xXRDIhX6jBF
	 /ibogoPIXwq4A==
From: SeongJae Park <sj@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH v3 0/3] mm/damon/paddr: minor code improvement
Date: Wed,  8 Mar 2023 18:17:17 +0000
Message-Id: <20230308181717.46186-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308083311.120951-1-wangkefeng.wang@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kefeng,

On Wed, 8 Mar 2023 16:33:08 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Unify folio_put() to make code more clear, and also fix minor issue in
> damon_pa_young().
> 
> v3: 
> - as SJ split the bugfix from v2, and it has merged[1], only do code
>   improvement
> - fix a missing folio_sz update in damon_pa_young()
> - add RB from SJ
> - rebase on next-20230308
> 
> [1] https://lkml.kernel.org/r/20230304193949.296391-1-sj@kernel.org
> 
> v2: 
> - use goto lable in damon_pa_pageout() and refact too more functions
> 
> Kefeng Wang (3):
>   mm/damon/paddr: minor refactor of damon_pa_pageout()
>   mm/damon/paddr: minor refactor of
>     damon_pa_mark_accessed_or_deactivate()
>   mm/damon/paddr: fix missing folio_sz update in damon_pa_young()
> 
>  mm/damon/paddr.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)

For the series,

Reviewed-by: SeongJae Park <sj@kernel.org>

Thank you for your efforts on this, Kefeng!


Thanks,
SJ

> 
> -- 
> 2.35.3
> 
