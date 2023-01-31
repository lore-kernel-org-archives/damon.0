Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADFBA94F
	for <damon@lists.linux.dev>; Tue, 31 Jan 2023 21:05:30 +0000 (UTC)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9284331A;
	Tue, 31 Jan 2023 20:58:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9284331A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1675198719; bh=ngzwZKeyeucWdvAvNfEisH7lx0LN8VaqU02iN98mpyQ=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=ib2sIu1sOsB/h+FGHRH0uClxSUn8V8Eok7BqGZdx1FDfXlZPQ0G2x7lUeGYYnRHwH
	 PGEFqJTKIQsvG4NF/BcVuQmLZyDrn3K3a7+yj+x4jUAV77JapnfMIBGhPz4A3DNFL4
	 tQWeYV2sHRN61aHsPIMhJn6HpVPHc/EUIpQsHF5+N/sthTlgvEQvzHuK0CSxXNKf0K
	 6cTnL88h3VJ1pUkgmSVdScx1bkz8e6oWXFo7DMST405y5xOK3DJlt6nHWbMdfySZF1
	 e+Q76+HCx85mIuZvd6M7UwCPeHHIH1b/nyZIVASMtm0AcoTgc75ER0v7VK3TyPYJ0M
	 2T1ftH7taIRWQ==
From: Jonathan Corbet <corbet@lwn.net>
To: Hui Su <suhui_kernel@163.com>, sj@kernel.org, alexs@kernel.org,
 siyanteng@loongson.cn, rppt@kernel.org, bobwxc@email.cn,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Doc/damon: fix the data path error
In-Reply-To: <Y9Tm1FiKBPKA2Tcx@localhost.localdomain>
References: <Y9Tm1FiKBPKA2Tcx@localhost.localdomain>
Date: Tue, 31 Jan 2023 13:58:38 -0700
Message-ID: <87h6w62zgh.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hui Su <suhui_kernel@163.com> writes:

> %s/modules/module/
>
> Signed-off-by: Hui Su <suhui_kernel@163.com>
> ---
>  Documentation/admin-guide/mm/damon/lru_sort.rst               | 4 ++--
>  Documentation/admin-guide/mm/damon/reclaim.rst                | 4 ++--
>  .../translations/zh_CN/admin-guide/mm/damon/reclaim.rst       | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

jon
