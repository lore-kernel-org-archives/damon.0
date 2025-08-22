Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D3F2BDC23;
	Fri, 22 Aug 2025 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885805; cv=none; b=jLOInGS2b/Jg+IJMo7x7s4VODDCPgUrZXfI3cN3hLt2KaLGLm4M+6pVveTP7wKvJxYo+S9luCIfwTb3qgzRJZf3Wj6NjVaaV8XH1C66RzX3sBxDgp3rvfWvzQuNMk7vxgJ0SfGPtpAz8FAbwB1eNVhXZ6yu0SeR4J9fvOT4mD7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885805; c=relaxed/simple;
	bh=xob6THafiHnjeYW4E4LIe3j9rn0C9XUlMt5gpe6z5/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxYPxf62j20/JgvwGgwP7jRAWUmThBBanBTqKkckPdtMh5h98Cg0tE1b9E17QQkKE63dLhYCoT2JTA3d2baTG6KIkBxeFLamBI09iYNLMFZZi8Qjl6kxhEPZSnJ1og8+Rcqikef2Lx2F7ES/CPAdzG7PPv64LKJm7FkB7hc40b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdmUi0Li; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdmUi0Li"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D5CC4CEED;
	Fri, 22 Aug 2025 18:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755885804;
	bh=xob6THafiHnjeYW4E4LIe3j9rn0C9XUlMt5gpe6z5/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdmUi0Li249VOCRkvixm0n00rznR0YOsJAhfyJyKsxqa6NvT4NhEEOINaUF1FgsS2
	 01Lm/3DlKaPNnM/gpCaVC2P8P0HtxM3j3ptDNwZDtAEz2sJU1XtVtXQkJTsxlXaRxh
	 J7+9zufeGr8y6p4o/kUkj8RxqOX17SQVxV/8IeVA3AIht+5uYfqt+izS3HoCIEbx5u
	 IeSM7TSpAOq9mj1PdkX+suNwV8d+G1f12J/eaYuMz0JynAEs5YL58sObGL7grteSH6
	 t9vwSUySwXvl357WauwptuZ4nWPqgy6UUxwUh+6I9BoYzX7ZYCp5JHVNjfUXrpGea5
	 AzkM9LhPIGe4g==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH 11/11] mm/damon: add damon_ctx->min_region
Date: Fri, 22 Aug 2025 11:03:22 -0700
Message-Id: <20250822180322.47842-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <8b3f1571-6510-453f-96d4-f365eb10d02d@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 22 Aug 2025 09:29:04 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> 
> 在 2025/8/22 1:33, SeongJae Park 写道:
> > On Thu, 21 Aug 2025 18:51:59 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> >
> >> Adopting addr_unit would make DAMON_MINREGION 'addr_unit * 4096'
> >> bytes and cause data alignment issues[1].
> >>
> >> Add damon_ctx->min_region to change DAMON_MIN_REGION from a global
> > s/min_region/min_sz_region/ ?
> >
> >> macro value to per-context variable.
> >>
> >> [1] https://lore.kernel.org/all/527714dd-0e33-43ab-bbbd-d89670ba79e7@huawei.com
> >>
> >> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
> >> ---
> >>   include/linux/damon.h        |  4 ++-
> >>   mm/damon/core.c              | 67 ++++++++++++++++++++----------------
> >>   mm/damon/sysfs.c             |  8 +++--
> >>   mm/damon/tests/core-kunit.h  | 21 ++++++-----
> >>   mm/damon/tests/vaddr-kunit.h |  2 +-
> >>   mm/damon/vaddr.c             |  2 +-
> >>   6 files changed, 61 insertions(+), 43 deletions(-)
> > [...]
> >> @@ -1248,6 +1253,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
> >>   	}
> >>   	dst->ops = src->ops;
> >>   	dst->addr_unit = src->addr_unit;
> >> +	dst->min_sz_region = max(DAMON_MIN_REGION / src->addr_unit, 1);
> > Can't we set this as src->min_sz_region?
> >
> > I asked a same question[1] to the previous version but seems it was missed.
> 
> I apologize for the issues caused by my misunderstanding and carelessness.
> I will make adjustments and release the v2 version as soon as possible, and I
> will not make similar mistakes again in the future.

No worry, we all miss someething sometimes ;) I confirmed your change on v2.
Thank you for correctly making the change.


Thanks,
SJ

[...]
