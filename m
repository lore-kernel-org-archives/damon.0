Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7872631E828;
	Wed, 11 Mar 2026 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239534; cv=none; b=pTpXM31zOCEOniN7CMVWSS5JspivjEvjRO+Lh+jEbwwDN+4HryPVHsl2b3E8l+xOkVN+aN5fuc1Qza8oUXnvaMPoKWsxydwnvS/l7merS89yFTNGRevL4/M8orVMuua+eNpL5HMx+SV8OsEuxDjD9NOJlGMZf9A/CEmwQacrsH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239534; c=relaxed/simple;
	bh=pAJnkE02U++SCDFnIRPdCudeLD7FWR/QDkiyqw4OeSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXIKKA7rG0XIgouYjWzg9YZcc3d8a685ZltUyd/Ky9JEQ5ezqy9mHHW8DlTzdYtLaiD9p4/dShXHjNxUVWtks15NRf1g98kR36mREa0XmO9dGNQBhdb6fHCrH9No+BbUBTvcY5LeZu8bdo3LyiBAhtxDRGcskrbtyDc4fH3lRtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSfKl12r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSfKl12r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F0BC4CEF7;
	Wed, 11 Mar 2026 14:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773239534;
	bh=pAJnkE02U++SCDFnIRPdCudeLD7FWR/QDkiyqw4OeSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JSfKl12rdKbyzdw1l2LDF1qw+RCEx1P7A0VJCwSeMZCBQ2nTD6Ioi5s/X1yCFhzCU
	 w7eboHQt3W5KjRMKLg71cjf6SKm8scbu084kgMTy2WFSERKVFJy+eKbnhjTgm0CoFi
	 fD4DF0liz/vqTD6ul4ZEH1FwCcS7+6DBtZ20uo4LtlNCG8msLiJmBBDu3Cjwf27VKS
	 1pT64VOzVvi8Gy1eSJ8sF8tKg0bK+DxmPRlwKdLptvma0DP9zyv+1Ztd+4uml24JEB
	 CksE6mSFSDJhYXK0HSGB3GyZ/2TUEHS1esNFUgEcTsVInI/62LCSR1jVe9E8SwjaZ8
	 ESrGnH5op5clw==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] mm/damon: New module with hot application detection
Date: Wed, 11 Mar 2026 07:32:06 -0700
Message-ID: <20260311143207.96707-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2895abe3-96f7-4428-8161-a8223ec758b7@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 11 Mar 2026 16:45:06 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 3/11/2026 7:11 AM, SeongJae Park wrote:
> > On Tue, 10 Mar 2026 16:24:19 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> > 
> > I'd like to discuss about this in a high level, but I'd like to do that on the
> > cover letter.  To this patch, I'm therefore adding comments for only details
> > that stand out immeadiately to me.
> 
> I will update the cover letter to add more details for the next version.
> 
> >>
> >> 1. It first launches a new kthread called damon_dynamic. This thread
> >> will behave as a supervisor, launching new kdamond threads for all
> >> the processes we want to montiored. The tasks are sorted
> >> by utime delta. For the top N tasks, a new kdamond thread will be
> >> launched.
> > 
> > If I read the cover letter and the code of this patch correctly, seems the last
> > two sentences of the above paragraph is outdated.  Please correct me if I'm
> > wrong.
> 
> Correct, I forgot to delete it.

Thank you for confirming that, and accepting my suggestions below.  Most of
your answers to my comments make sense, so I'm cutting most of the part except
places where I want to clarify my points or answer your questions below.

[...]
> >> +};
> >> +DEFINE_DAMON_MODULES_DAMOS_TIME_QUOTA(damon_hugepage_quota);
> >> +
> >> +static struct damos_watermarks damon_hugepage_wmarks = {
> >> +	.metric = DAMOS_WMARK_FREE_MEM_RATE,
> >> +	.interval = 5000000, /* 5 seconds */
> >> +	.high = 900, /* 90 percent */
> >> +	.mid = 800, /* 80 percent */
> >> +	.low = 50, /* 5 percent */
> >> +};
> >> +DEFINE_DAMON_MODULES_WMARKS_PARAMS(damon_hugepage_wmarks);
> > 
> > In the RFC v1 discussion, you also mentioned you will remove the above, but
> > seems it is forgotten?
> > 
> > Also, my understadning of your reply on the previous discussion was that you
> > don't really want to use watermarks in this module, and therefore you want to
> > remove it.  Am I correct?  If I'm not, maybe I'm still not understanding the
> > intention of the watermarks.  Can you please enlighten me?
> 
> Since I refactored heavily the previous code, I forgot to delete this bit.
> I will remove it now.

Thank you for clarifying this :)

> 
> >> +
> >> +static struct damon_attrs damon_hugepage_mon_attrs = {
> >> +	.sample_interval = 5000, /* 5 ms */
> >> +	.aggr_interval = 100000, /* 100 ms */
> >> +	.ops_update_interval = 0,
> > 
> > Is ops_update_interval = 0 really your intention?
> 
> I didn't think about it. I will set it to 60 seconds, as in other modules.

Sounds good.

When 'vaddr' operation set is used, for every ops_update_interval, 'vaddr'
updates monitoring target regions boundary to cover all virtual address
mappings.  If it is '0', it will do the update on every iteration of the
kdamond main loop.  It can result in unnecessary overhead.  So I was asking the
above question.  Setting it to 60 seconds sounds good to me.

[...]
> >> +	err = damon_modules_new_ctx_target(&param_ctx, &param_target,
> >> +					   DAMON_OPS_VADDR);
> >> +	if (err)
> >> +		return err;
> > 
> > You should deallocate param_ctx before returning the error.
> 
> Not sure about this. As far as I know, damon_modules_new_paddr_ctx_target
> will destroy the context in case there is an error. In fact, reclaim and 
> lru_sort modules just return error when damon_modules_new_paddr_ctx_target
> fails, no cleanup used.

You're correct, I was trying to comment only below, but somehow confused the
place.  Sorry for the confusion.

[...]
> >> +
> >> +		list_for_each_entry_safe(monitored_task, tmp, monitored_tasks, list) {
> > 
> > Please wrap lines for the 80 columns limit.
> 
> Interesting, when check it, i was less than 80 columns. Even if I copy this line
> and paste it into any text editor, I still get less than 80 characters.

Oh, you must be correct.  Maybe my mailing tool was showing it incorrectly.
Please keep it as is if it doesn't exceed 80 columns.

Thanks,
SJ

[...]
