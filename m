Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F37157487;
	Fri, 28 Feb 2025 04:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718129; cv=none; b=dYqblHT5vthgjuS7Snak151L3m48tbEJIp2075Q0oCbGOepQJWOmBxloisbr1oOKWDgGxgdkRw7xbSg8N2ZvzlPyFyAJ0f/zN5u76ApFHcjObod0LbabtWKRkoeIL7dYNgw/2baHftyAexigXv+VXhYCFc6qEy48cMijPlQ5RJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718129; c=relaxed/simple;
	bh=owXeyU0H6ZW3/VpDdEje1Z6EvdsqqKiXBOUx5xhzvlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s6DIqr21oVvXEpDEvZ5VNp1w+naEmW1oN1GKetiLVyi+ggMeR1KH3w+ARt8d9TXuUitPBBChE/+6nruBEzx0EUDfL0QKDTxceZMs1wf4Bbs2rJuX3k7SVbrjCmAdOO3HVvLao5UEfYeAX0rKsHoxM8DSyfMAKOlpQDbtYAXgNUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyIe18NJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyIe18NJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92904C4CED6;
	Fri, 28 Feb 2025 04:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740718128;
	bh=owXeyU0H6ZW3/VpDdEje1Z6EvdsqqKiXBOUx5xhzvlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GyIe18NJc6+txFIeuJWX2mynlTQH8hr01zGXWZxq3dTPU7PbaxZ51z15OMDtdQkoA
	 6vRfM6UCr7xpHVEerWkCH64kToVfSKe3pwaCu8/fBUFHlO4PjhOKH52zDD7AiEHYnA
	 W89BsmojPYAhvhvyYzO9kNeC6mwtxXd6kCkRDsSDKB4KZ2PvBLvyXHAljwn1teBbGx
	 H5NlOb6VH37VF5mpLetMC/eD5Uwomvuab9Fecv8DvIDVhkWi1dEkMtm2xh7gVEjeGe
	 CMy2tm6o2T3h1fkQ+vxuH0cnLS/vGs832pxGqS9yZfR80p7z1vsL/5h5QgMbck9PxZ
	 dGnK+0PC1knHQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 7/9] mm/damon/core: set damos_filter default allowance behavior based on installed filters
Date: Thu, 27 Feb 2025 20:48:45 -0800
Message-Id: <20250228044845.37918-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227055054.22813-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 26 Feb 2025 21:50:54 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Wed, 26 Feb 2025 17:57:52 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
> > Decide whether to allow or reject by default on core and opertions layer
> > handled filters evaluation stages.  It is decided as the opposite of the
> > last installed filter's behavior.  If there is no filter at all, allow
> > by default.  If there is any operations layer handled filters, core
> > layer's filtering stage sets allowing as the default behavior regardless
> > of the last filter of core layer-handling ones, since the last filter of
> > core layer handled filters in the case is not really the last filter of
> > the entire filtering stage.
> 
> This is not sufficient enough.  Even with this change, core-handled allow
> filters after core-handled reject filters are still meaningless.
> 
> If a region is matched to a core layer handled filter, the allow/reject
> decision should be respected while ignoring all remaining filters, regardless
> of on what layer those are handled.  It works in the way for reect filters,
> since core layer-rejected regions are not passed to the ops layer at all.  In
> case of allow filter, however, the region is passed to ops layer without the
> information about whether it has passed to the ops layer because it was
> allowed, or just not matched to any filter.  Hence, all ops filters can be
> applied to the region.
> 
> We can implement this missing part by storing the core layer filtering stage
> decision somewhere and let ops filter filtering stage repsect it.  Changes like
> attached diff at the end of this mail may work.  I will add such changes to
> next version of this patch series.

I now realize this is not a missing part of this improvement patch series, but
a sole fix for the allow filter behavior.  The current behavior is not matching
with the documented one, and this change will fix it.  I will post a patch for
this fix separately from this patch series.


Thanks,
SJ

[...]
