Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F09350D7C;
	Tue, 26 Aug 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218846; cv=none; b=J59QgojAllw1R2mOZNN+anVO86zZdHWscSGk++ZiKcPiAAkyYG7id7LpIYaXUfP7FrWPPjMgrQTMdIDzDYnug2YKt2Kc36K2yaHQs1JbNLUM2DTx1wGxJtDiCZaQHiPLJnV6WXCRVnf3tJu+YAU7EMWpZ3He2Igq4UFI6vUnPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218846; c=relaxed/simple;
	bh=3CPQkzt4NICb75OBiOuTfVapvMeLDLHP2WG42NRv1Ss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iCygx/0K8EelewEl8TbbAW7IReqcH1OD1kCFaj07kUe68DY/EfA/8702s5W5bRvY1EmkvRuTJIIHjDFycVXqq4iZ0BbWFck5ZLc+HKpbYEgxLI0WSR3QtYTvoHRAkIqDxAhpCaYncmcjRe8vhYUEUScW6aykLj6sZXW7YZ9NLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnPlZeT1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnPlZeT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0F5C116B1;
	Tue, 26 Aug 2025 14:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756218846;
	bh=3CPQkzt4NICb75OBiOuTfVapvMeLDLHP2WG42NRv1Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gnPlZeT12A7JO4iiikyj8vx8JpEqez55iewEUUeoZjdP3ViwMVcOe3tqzcuUThY68
	 3it7q5IAggDs98ad26LHx5dIuIr4Dix6yvQzFIrPcKFi5D/Tkhhc8uZoaJBTdRgXFt
	 RX8nLImLMLg8xltiyiXVh70WmflcOyxmn1ntXwGqO3wzmalTMSntpZMJz2OqmzmDkp
	 +kOxCsQ2vfEOVNr3QPJvg0VFobm3GaJX7dudktQMMa2dQt42n6YrLqPObXij8Cm+Ui
	 uNgi/pMakahoBRCqxmaDaE9bTilG7A+5vHDzbvPmIE+La//I/655cqt8cuRmWIBcq7
	 UqWDBmL0w7V9g==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH 2/2] mm/damon/reclaim: avoid divide-by-zero in damon_reclaim_apply_parameters()
Date: Tue, 26 Aug 2025 07:34:03 -0700
Message-Id: <20250826143404.54232-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250826033653.1208227-3-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 Aug 2025 11:36:53 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> When creating a new scheme of DAMON_RECLAIM, the calculation
> of 'min_age_region' uses 'aggr_interval' as the divisor, which
> may lead to division-by-zero errors. Fix it by directly returning
> -EINVAL when such a case occurs.

Nice catch, thank you for this patch!

> 
> Fixes: f5a79d7c0c87 ("mm/damon: introduce struct damos_access_pattern")

Let's add Cc: stable@

> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
