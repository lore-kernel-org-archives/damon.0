Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9319B356904;
	Tue, 26 Aug 2025 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218728; cv=none; b=SS/00oAiQJ/si1gBY6Whvi8Suf2ngfbW4uowghOilKtSgSBhNaapU7rGJCEf0NAVVKbvU10uoldVeZVWIo7oePb5BSY2oNGTjXqOc12KSc/vOXjMyT5+RhqwrXrG+XdBpT37wgtYzoiFgcPwCD/0RwOi/PyiaTQz1LCMB3ZdNGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218728; c=relaxed/simple;
	bh=3MNa7Fhsof0AmMz3/3fenqH4aTbi96cqmH77qoqlapE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lTnUGCXJFQz1D/sEcLHjMeuxJVDfRwB6SFxWyMKj9SyulNL5TCTnCAm1aj52dtbRYsjGsXmRPdnFLM6d+nhv4V29gNcOFn08y5EEdTIps1qPFWw27qehHNMPvaDFXBmgGPxHYI16MhaNM1sUEpssWJDaUmD2bWk7RXs+WLNW558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xkh6j6tt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xkh6j6tt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0D0C113D0;
	Tue, 26 Aug 2025 14:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756218728;
	bh=3MNa7Fhsof0AmMz3/3fenqH4aTbi96cqmH77qoqlapE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xkh6j6ttedgo6/EZhRJER6ZSlf+Etgzm8rUfceAnudpQ7/FVwQ8z8j+8FlE5SwOMT
	 sAeoHLRcN92EJf2pp9c4uylRJq5yYVwWUZFMuKpIE8q/pmbOetJ1WWkFDeza8QAMBF
	 Jp12+F4amyxmRLNkxHd0Ts5zl0jhb3aSlSiYW9E7lxKippW7unLhgeT3gKdXI8I1MI
	 VYawzcVOcrVrfmVADqYvZZ4GGzzYeMRPUSnRLfBSq4jXtrONikVaC6x3Bwlzhae9ms
	 L1PxNtZxlHLDPZ9ZvpZyqPqGUMQaNpheoEjt7iAlPt/7WLb9W/vB2iMm+GjEdin5oC
	 zjPYVZYLVmx+A==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH 1/2] mm/damon/lru_sort: avoid divide-by-zero in damon_lru_sort_apply_parameters()
Date: Tue, 26 Aug 2025 07:32:04 -0700
Message-Id: <20250826143204.54098-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250826033653.1208227-2-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 Aug 2025 11:36:52 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> During the calculation of 'hot_thres' and 'cold_thres', either
> 'sample_interval' or 'aggr_interval' is used as the divisor,
> which may lead to division-by-zero errors. Fix it by directly
> returning -EINVAL when such a case occurs. Additionally, since
> 'aggr_interval' is already required to be set no smaller than
> 'sample_interval' in damon_set_attrs(), only the case where
> 'sample_interval' is zero needs to be checked.

Nice catch and fix!

> 
> Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")

Let's add Cc: stable@

> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
