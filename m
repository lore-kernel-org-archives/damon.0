Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772FD79E0
	for <damon@lists.linux.dev>; Wed, 20 Sep 2023 07:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4550FC433C8;
	Wed, 20 Sep 2023 07:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695194391;
	bh=qFdKBzqTmmQ2nUPNK5GbW1ZYNZ25HnBX2G2O6O2qgtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JwJfNw/lMLXQffIjVCXrlngljneOT1KsD/CT/8dx3/6vAVvsTcZnnJ1wTHnCl3Dxw
	 XVGw5FQj7scOr7UQIxB8HR9uSOUorhtAo4kd+tgEtBXjsjQwzhQZTeXgnGNdUACt4D
	 9beTUeZFLL7xehCRZzEPLn3AjkYwxquqQBZrAlX/KlOr6EJk2yTeZxJou3Ako5IG/F
	 1OHIY7IxbA0ypJHv2yVoW99OewAZqs9frGUN7abb0dOwEiF7uLiMtu6fUpyGDmikuf
	 9dZalQI5eoc2NMridpMayTavc4YYmAiZhddH1DD9OfrB9wxzfL7NgtspXoHi358r6C
	 ps4EoiYlOWEkw==
From: SeongJae Park <sj@kernel.org>
To: Huan Yang <link@vivo.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v3] mm/damon/core: remove unnecessary si_meminfo invoke.
Date: Wed, 20 Sep 2023 07:19:49 +0000
Message-Id: <20230920071949.26063-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230920015727.4482-1-link@vivo.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Huan,

On Wed, 20 Sep 2023 09:57:27 +0800 Huan Yang <link@vivo.com> wrote:

> si_meminfo() will read and assign more info not just free/ram pages.
> For just DAMOS_WMARK_FREE_MEM_RATE use, only get free and ram pages
> is ok to save cpu.
> 
> Signed-off-by: Huan Yang <link@vivo.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
> Change from v1:
> v1 fold free mem rate logic into __damos_get_wmark_free_mem_rate and not
> invoke si_meminfo, just get free/ram_pages in global.
> v2 cancel this __damos_get_wmark_free_mem_rate and just calculate rate
> in damos_wmark_metric_value to keep it simple.
> v3 fix changelog format, fix code style.
> 
> 
>  mm/damon/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index bcd2bd9d6c10..6ceb52298904 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1280,12 +1280,10 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
>  
>  static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
>  {
> -	struct sysinfo i;
> -
>  	switch (metric) {
>  	case DAMOS_WMARK_FREE_MEM_RATE:
> -		si_meminfo(&i);
> -		return i.freeram * 1000 / i.totalram;
> +		return global_zone_page_state(NR_FREE_PAGES) * 1000 /
> +		       totalram_pages();
>  	default:
>  		break;
>  	}
> -- 
> 2.34.1
