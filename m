Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B2229B02;
	Thu, 14 Aug 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187888; cv=none; b=KP35KhVDDj2Jfn+CGzKEMkWJS3nN8Iuxa/FGCyEDA5VgYZXhCa56T1yvNx0AXkW7YxKkxd6pUQ1gEFmM5ROG4rRUxr8x3miTxW6ZKaX000vpZWoPYlqXlpjoVld990ML5gyqLmjjJGJK/ET1hMp3yPSpLMtGG96shVrYC0sfLhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187888; c=relaxed/simple;
	bh=08/3DM8LoFIHR7/BNGxuLaxDxNLDuFb1zlEw9gyMNdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ja5fW4t8gV8d6zsgmqRgQLX78n8hEdr/0HWvmaAFqPKpWiykI1zeCmD04T1LBRMqrS9lQ3U9GsucY9zQyqm26gvkhMmsZWMnHy289nb1dacTedn0fz4sKVRAsRvvzz6eYmRiwbQjkc3eVg4iBteY4DljGTlCRY43A0PHVfP3elM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8K/QkvY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8K/QkvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AF8C4CEED;
	Thu, 14 Aug 2025 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755187887;
	bh=08/3DM8LoFIHR7/BNGxuLaxDxNLDuFb1zlEw9gyMNdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c8K/QkvYAZUSLTmYvCDdY7DHU0hbICvAA1weY6qGkXzn9FQYu+81sqYA0kcq6k+Cd
	 7rTBOYUMYpkj4Q0wTOKEYyGWuoeOqrcd4HvXijlEUjfWjl1xyKEvR8KypKfiPgOALi
	 9mKkTc6ed5mUsXA9CpT5Kg+Pq/eJANp2zzxfxXZmYTWZ7Nr7Po5CM6wa8Dnz6FQSWH
	 a02UeSlvlFOTpLTivuLE9sS6R4EgutHFLUzead5V+C+WwP6PxQC1gbWdvE5VkvoaJ2
	 R2u2E2xJYtcixHNVl/JOn63noKQOIt8U/1WZxE06cQVJY6ucikVlNHmyV7vaDbBdfe
	 a6rP/W2d5xcvg==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 11/16] mm/damon: add addr_unit for DAMON_RECLAIM and LRU_SORT
Date: Thu, 14 Aug 2025 09:11:25 -0700
Message-Id: <20250814161125.67602-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <39e07350-2510-49fe-ae4a-e5d10b69291c@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 14 Aug 2025 20:59:04 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> 
> 在 2025/8/14 0:36, SeongJae Park 写道:
> > On Wed, 13 Aug 2025 13:07:01 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> >
> >> In module DAMON_RECLAIM and DAMON_LRU_SORT, the damon_ctx is
> >> independent of the core, necessitating dedicated addr_unit
> >> integration for these features.
> >> Additionally, if the input monitor_region_start and monitor_region_end
> >> are both 0 while addr_unit is set to a non-zero valuethe default
> >> system RAM range should be divided by addr_unit.
> > Do you plan to, and need to use DAMON_RECLAIM and DAMON_LRU_SORT on LPAE-ARM32
> > environments?  Can't you use DAMON sysfs interface instead?  If need to use the
> > modules, this change looks good to me in high level.  But if not, I'd like to
> > skip this change, and wait until someone requests it.
> >
> > I'll review the code change in depth after the above question is answered.
> >
> Hi SJ,
> 
> Yes, we need to use these modules in an LPAE-ARM32 environment. The modular
> approach often provides more flexibility in our workflow, so we would greatly
> appreciate it if you could take some time to review the code!🙂

Thank you for clarifying.  Ok, I understand this change is really required.

However, I think reviewing and revising this part may take time.  Meanwhile,
seems this part is not an essential one of this patch series, and has no
problem at be separated and merged after the essential parts.

So, could we separate this part from this patch series?  That is, let's work on
the essential part first.  After the work on the essential part is done, you
could post this part as another patch series, and then we can work together
again on it.


Thanks,
SJ

[...]
