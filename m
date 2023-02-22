Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3EE8F59
	for <damon@lists.linux.dev>; Wed, 22 Feb 2023 18:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424DBC433EF;
	Wed, 22 Feb 2023 18:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677090416;
	bh=xBFAtQy7H9IEzhN6tiCIgW4YKmQxOgfi228DV4+IAOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyy8EWcwUoDh5Qjanib5yUoXbwdJ3E933glFTOrgDTICp8tQxuZZkdBWdCGE3GP5L
	 IxTfwN+Fh1JdZsKTXuH3jKRJEB9zy2LO/NH1jbTZ7E/EOY4q1FNVRzyJjAoBxvmdDu
	 MVV+eDn0AMPxdnL8Q0FRbrW2+coXXNG5QDtWh3vppgE5oVBaBvMuflomt+yJYgElsD
	 MlPWYQGEs//RgjLSUiJywp5dwIEHNFErsiKFuvoqUa/G+n4gVnIs1G6MkBP917I6I1
	 Ekzw/9EtI+E+SdRK5UvkWyfFnnXBWppvc+L5Lm48S6NxOuPYko2N/twjqZwm5QpX26
	 VmfP0U9PyOClQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	wsd_upstream@mediatek.com,
	casper.li@mediatek.com,
	"andrew . yang" <andrew.yang@mediatek.com>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] mm/damon/paddr: fix missing folio_put()
Date: Wed, 22 Feb 2023 18:26:53 +0000
Message-Id: <20230222182653.156921-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230222064223.6735-1-andrew.yang@mediatek.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,


Thank you for revising this patch!

> From: "andrew.yang" <andrew.yang@mediatek.com>
> 
> damon_get_folio() would always increase folio _refcount and
> folio_isolate_lru() would increase folio _refcount if the folio's lru
> flag is set.
> 
> If an unevictable folio isolated successfully, there will be two more
> _refcount. The one from folio_isolate_lru() will be decreased in
> folio_puback_lru(), but the other one from damon_get_folio() will be
> left behind. This causes a pin page.
> 
> Whatever the case, the _refcount from damon_get_folio() should be
> decreased.
> 
> Signed-off-by: andrew.yang <andrew.yang@mediatek.com>
> Fixes: 57223ac29584 ("mm/damon/paddr: support the pageout scheme")
> Cc: <stable@vger.kernel.org> # 5.16.x

Reviewed-by: SeongJae Park <sj@kernel.org>

This may not cleanly applicable on 6.1.y and 6.2.y.  I would post backports
once this is merged in the mainline, unless others do earlier than me.


Thanks,
SJ

> ---
> v3:
>   add fixes tag and cc stable
> v2:
>   according to David's suggestion
>     1. revise subject
>   according to SeongJae's suggestions
>     1. rebase to mm-unstable tree 
>     2. remove braces for th single statements
> ---
>  mm/damon/paddr.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 607bb69e526c..6c655d9b5639 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -250,12 +250,11 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
>  			folio_put(folio);
>  			continue;
>  		}
> -		if (folio_test_unevictable(folio)) {
> +		if (folio_test_unevictable(folio))
>  			folio_putback_lru(folio);
> -		} else {
> +		else
>  			list_add(&folio->lru, &folio_list);
> -			folio_put(folio);
> -		}
> +		folio_put(folio);
>  	}
>  	applied = reclaim_pages(&folio_list);
>  	cond_resched();
> -- 
> 2.18.0
> 
> 
