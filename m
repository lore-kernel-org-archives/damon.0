Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE1F7F474
	for <damon@lists.linux.dev>; Tue,  9 Apr 2024 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654700; cv=none; b=AiRuoVHHenPaQ6xTfuFZ/eAilVgjM0AO4eQ7JkAi3lxjIbe9cTxaXK8xpTEkUN0pfdAka2PHLlKHfNKhfoDu9sHL4GqqJzZhU/ein1oXNF9VgqEb6ojR9ktgHAydSWPZT+8WsLMrL5omojdtQb0+hvK9cI0ZSFj1J194IFW51iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654700; c=relaxed/simple;
	bh=fVzMBpVHDCYnJyjVzpHAN3PRUyFt/fDMP73sAiKyMqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOx5SEqdoM35w3oGJ86dnHKH+/tqyjTMj7pLhsioEQsSRpBhtV9r5mHZvP/mgc75JONklJ6JMKNxF8M/PPZrM5XwF9Uu5Cwn7AiMrfsXWKZBONl0cFstaJdeEtfx8OPEhJpmEzow5w7WSK5z5AY6uZSGzFgVggmzOWr767QJL20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-7f-661509649d67
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] mm/damon: add a DAMOS filter type for page granularity access recheck
Date: Tue,  9 Apr 2024 18:24:31 +0900
Message-ID: <20240409092434.3031-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240311204545.47097-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsXC9ZZnoW4Kp2iaweJDZhZP/v9mtbi8aw6b
	xb01/1ktDn99w+TA4rFpVSebx6ZPk9g9XmyeyejxeZNcAEsUl01Kak5mWWqRvl0CV8aliX+Z
	ClYIVTRcPs7WwPiZr4uRk0NCwESi581Xti5GDjB78v4gkDCbgJrElZeTmEBsEQFFiXOPL7J2
	MXJxMAtMZ5TYeGIzK0hCWCBV4sbcPrAiFgFVid8v37CD2LwCZhLrp11lh5ivKfF4+08wm1PA
	WOL465NgvUICPBKvNuxnhKgXlDg58wkLiM0sIC/RvHU2M8gyCYEZbBKd698yQQySlDi44gbL
	BEb+WUh6ZiHpWcDItIpRKDOvLDcxM8dEL6MyL7NCLzk/dxMjMAyX1f6J3sH46ULwIUYBDkYl
	Hl6Lq8JpQqyJZcWVuYcYJTiYlUR4g00F04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxES
	SE8sSc1OTS1ILYLJMnFwSjUwTov7HcNzQTlqjxmne+ApsVcGnCEvhHxeB0UxOe+tsuDtnq3M
	pNRcPitlmrud5oGItJsvn6cFvMw7L/yWVXyOpIOI7hOTDXKOm57dvycRYHLkHbdQkIzi94tv
	rxjzfNFp23/yxJ4a3V0cOUdL4g2D7sydnCKp83ASG/ejwp4b65rCys38fwcqsRRnJBpqMRcV
	JwIAHN1XZT8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsXCNUNLTzeFUzTN4O42I4sn/3+zWnx+9prZ
	ovPJd0aLw3NPslpc3jWHzeLemv+sFoe/vmFyYPfYtKqTzWPTp0nsHi82z2T0+Hbbw2Pxiw9M
	Hp83yQWwRXHZpKTmZJalFunbJXBlXJr4l6lghVBFw+XjbA2Mn/m6GDk4JARMJCbvD+pi5ORg
	E1CTuPJyEhOILSKgKHHu8UXWLkYuDmaB6YwSG09sZgVJCAukStyY2wdWxCKgKvH75Rt2EJtX
	wExi/bSrYLaEgKbE4+0/wWxOAWOJ469PgvUKCfBIvNqwnxGiXlDi5MwnLCA2s4C8RPPW2cwT
	GHlmIUnNQpJawMi0ilEkM68sNzEzx1SvODujMi+zQi85P3cTIzDgltX+mbiD8ctl90OMAhyM
	Sjy8DneE04RYE8uKK3MPMUpwMCuJ8AabCqYJ8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00Q
	EkhPLEnNTk0tSC2CyTJxcEo1MOYLVq/J+B4XG6S5R8f8SNmatP3GMp0zlpmJNt+XtOZaIrz7
	aT97xs7C97fqA8xZD79miZ6UspaldXmFesKE69PvTrfa+HDnrQiOJNMrt0QmphmaHfKZ6WRR
	PXdfheOOUzGKJhKuxZ1b+D4ufnA5xHTbVu1pN/v+Tby3bYnXr+PH1srffW6bwabEUpyRaKjF
	XFScCAAwE2uBNAIAAA==
X-CFilter-Loop: Reflected

Hi SeongJae,

On Mon, 11 Mar 2024 13:45:41 -0700 SeongJae Park <sj@kernel.org> wrote:
> Changes from RFC v1
> (https://lore.kernel.org/r/20240307030013.47041-1-sj@kernel.org)
> - Rename __damon_pa_young() to damon_folio_young_one()
> - Mark the folio as old from the filter for the next check
> 
> DAMON allows users to specify desired ranges of overhead and accuracy of
> the monitoring, and do its best effort to make most lightweight and
> accurate results.  A recent discussion for tiered memory management
> support from DAMON[1] revealed that the best effort accuracy may not
> suffice in some use cases, while increasing the minimum accuracy can
> incur too high overhead.  The discussion further concluded finding
> memory regions of specific access pattern via DAMON first, and then
> double checking the access of the region again in finer granularity
> could help increasing the accuracy while keeping the low overhead.
> 
> Add a new type of DAMOS filter, namely YOUNG for such a case.  Like anon
> and memcg, the type of filter is applied to each page of the memory
> region of DAMOS target memory region, and check if the page is accessed
> since the last check.  Because this is a filter type that applied in
> page granularity, the support depends on DAMON operations set.  Because
> there are expected usages of this filter for physical address space
> based DAMOS usage[1], implement the support for only DAMON operations
> set for the physical address space, paddr.
> 
> [1] https://lore.kernel.org/r/20240227235121.153277-1-sj@kernel.org
> 
> 
> SeongJae Park (4):
>   mm/damon/paddr: implement damon_folio_young()
>   mm/damon/paddr: implement damon_folio_mkold()
>   mm/damon: add DAMOS filter type YOUNG
>   mm/damon/paddr: support DAMOS filter type YOUNG

I have tested your patches for evaluation of [1] and it all works fine.
Thanks very much for doing this work!

Tested-by: Honggyu Kim <honggyu.kim@sk.com>

[1] https://lore.kernel.org/damon/20240405060858.2818-1-honggyu.kim@sk.com

>  include/linux/damon.h    |  2 ++
>  mm/damon/paddr.c         | 64 +++++++++++++++++++++++++---------------
>  mm/damon/sysfs-schemes.c |  1 +
>  3 files changed, 43 insertions(+), 24 deletions(-)
> 
> 
> base-commit: 13043cde46a19e72d37965b67b74e564623f65e7
> -- 
> 2.39.2
> 
