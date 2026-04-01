Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A2223DFF;
	Wed,  1 Apr 2026 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775004846; cv=none; b=KPB7AYN8UJYMO1e3s7NtObAEd/2L4wW/4bu6GSd5zOoeWOedgWsjnyCjkkMmo9Cp5FjN4Gwxt1tQ2kZzDyp+UhNaS2sYT3HnSUr0QwoBPVny+K412dOTB5CZKxBsvlQRVjP83jVPTBraE+IcUJTqd1r1hujM8nUzPbBVHqM4Tvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775004846; c=relaxed/simple;
	bh=+f4CmOUNnvSl0uArFt9iOybOcimttiG3VaErO1gsD8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1d+4STZ6446XavsQTm65xSaoiIDB5cLbfJidGaVxpnnh4xzYM17UyvK3YfnvTwjWt4nUHvdj+hddSVcnem8fq+XA0XIZ7k5po26GN8hDWT7xjqG9ASd58zD8vGg2W28InOV7SiGRbd1dtg9eMrjBTSKpIMxQzL8qT4ZVKVBcZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul8G+PLu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul8G+PLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7D4C19423;
	Wed,  1 Apr 2026 00:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775004845;
	bh=+f4CmOUNnvSl0uArFt9iOybOcimttiG3VaErO1gsD8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ul8G+PLuHQzMqCcaTBmaiVFddbBPa6py0orboYcGagVbnzKGnPy11HZwDVoGQQ8p7
	 IgYkupOTJvpTkm/deSnZBZVDLf3+Hk3Ob5G9n4lvtPGzGvbQRGCPr9cyFC/vE5eDdH
	 lrtsAVzHiOaq5+OmZo7JUmBlLNQZtnkHw8sQ+V3ae4Tr3bXUJSDJYcRDNVv6S7N8yw
	 JK+J8nldKfrWDzdcZvz2bZBYOH1J4YLdiY85RItTeOpR1eMSTlmJBnp6YP3Msq5srF
	 AM4378+2ZEdWxI7uVq/pvIy1+kZ46OauU5HpVwilRewwR0BxN5NtxUPL9AFVKpT1ZN
	 Wb80PuYgS9kYw==
From: SeongJae Park <sj@kernel.org>
To: Stepanov Anatoly <stepanov.anatoly@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	gutierrez.asier@huawei-partners.com,
	artem.kuzin@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme action
Date: Tue, 31 Mar 2026 17:54:01 -0700
Message-ID: <20260401005402.85833-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <716989f5-78d3-4e78-98ae-2bf3caa447a9@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 31 Mar 2026 13:50:21 +0300 Stepanov Anatoly <stepanov.anatoly@huawei.com> wrote:

> On 3/31/2026 1:46 PM, Stepanov Anatoly wrote:
> > On 3/31/2026 4:31 AM, SeongJae Park wrote:
> >> Hello Asier,
> >>
> >> On Mon, 30 Mar 2026 14:57:58 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> >>
> >>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>>
> >>> This patch set introces a new action:  DAMOS_COLLAPSE.
> >>>
> >>> For DAMOS_HUGEPAGE and DAMOS_NOHUGEPAGE to work, khugepaged should be
> >>> working, since it relies on hugepage_madvise to add a new slot. This
> >>> slot should be picked up by khugepaged and eventually collapse (or
> >>> not, if we are using DAMOS_NOHUGEPAGE) the pages. If THP is not
> >>> enabled, khugepaged will not be working, and therefore no collapse
> >>> will happen.
> >>
> >> I should raised this in a previous version, sorry.  But, that is only a half of
> >> the picture.  That is, khugepaged is not the single THP allocator for
> >> MADV_HUGEPAGE.  IIUC, MADV_HUGEPAGE-applied region also allocates huge pages in
> >> page fault time.  According to the man page,
> >>
> >>     The kernel will regularly scan the areas marked as huge page  candidates
> >>     to replace  them with huge pages.  The kernel will also allocate huge pages
> >>     directly when the region is naturally aligned to the huge page size (see
> >>     posix_memalign(2)).
> >>
> > I think key difference between DAMOS_HUGEPAGE and DAMOS_COLLAPSE is the granularity.
> > 
> > In DAMOS_HUGEPAGE case, the granularity is always VMA, even if the hot region is narrow.
> > It's true for both page-fault based collapse and khugepaged collapse.
> *page-fault THP allocation, not collapse of course.

Good point.  I think this difference can also help answering why DAMOS_COLLAPSE
was making less huge pages in the test.

> 
> > 
> > With DAMOS_COLLAPSE we can cover cases, when there's large VMA, for example,
> > which contains some hot VA region inside, so we can collapse just that region, not the whole VMA.

This also makes sense to me.  Also I think this aligns to what we discussed for
MADV_COLLAPSE intro.


Thanks,
SJ

[...]
