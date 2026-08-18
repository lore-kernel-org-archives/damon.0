Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5736655C;
	Tue, 18 Aug 2026 03:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787023287; cv=none; b=lUIdpKUBTj1BrOyZMRjFAuXZoDll625i1JfK3hKkqGnyBKhZuAD0eEi5sjNCJNhe8EaX4WwUwrFHgWiPLeViX7k1ZBKxuhEMqhzzHU8zQCFho7TU8VcsbY/NWa23wj4VLLJmMSLkBswHlHgR9DZ00ZMOGiZcbAgis0fbwuAizYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787023287; c=relaxed/simple;
	bh=XaEnS7wyGc2OVstJ9A/5iLwHHBFm0Mii7L/ZzZnzcfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHUCmuu8/gSTwSEHpbPQuS8hS/VuHrkBVJiNtN5vc0i9CHGLFKlcSGzwMtIELljW8YNS4RkLd1bj00fNapig6smukTMv73jNIK+BcdodYm137nauQna5JlItqYQL04zkGOXMKqNQ3HWfz+CshmDpPcUY3b3RQRfDd9/PsMvBwMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9Sot6Uh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9Sot6Uh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0341F000E9;
	Tue, 18 Aug 2026 03:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787023283;
	bh=r8ycGWTUx2Z6i4TYl2DorBvyB4i7PAtWRsvpykEZrpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y9Sot6UhFW31l4tekFskkY/DZIvzGQa68alZJQG6Xim+nEmdHpvBdCHgXd00Vd0/j
	 qTpZKWeOfXYZTJRmNCaxjIpmzvsU4GEliO8wBg3GRxmcGY3VrE/8ClxrwV4pZC+D4h
	 c74GxNA77tVI3zgGWUnL/k+gmugOn6FQplXxg68yJ2W0m2m+hbdx0kvDGzLa3eRQvV
	 hOXYZOQjdiIzAvi8yBuWIMSk3aPSQCFIHTcxn5VmM+zkmMvnbJlWra/fsyGVdb04xa
	 zIaQasnLSlPLDYshIw95JxXIVJZTaDP0BYtAFY1myXkaP4WMe+cADKUOpJk40T6GpV
	 to0fZwPUYYLsg==
From: SJ Park <sj@kernel.org>
To: dayou5941@163.com
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: Re: [PATCH v2] mm/damon/ops-common: factor out damon_putback_folio_list()
Date: Mon, 17 Aug 2026 20:21:20 -0700
Message-ID: <20260818032121.89231-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818020650.2844354-1-dayou5941@163.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 18 Aug 2026 10:06:50 +0800 dayou5941@163.com wrote:

> From: Li Youhong <liyouhong@kylinos.cn>
> 
> The putback loop is duplicated in damon_migrate_folio_list() and on the
> invalid-nid path of damon_migrate_pages().  Factor it into a small helper
> for readability.  No functional change.

Thank you for this nice cleanup.

> 
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term, I will ask mm.git maintainer (Andrew Morton) to pick
this.  So, no action from your side is needed for now.  Note that we are in the
middle of the merge window.  Andrew might not pick this until the end of the
merge window.  I will make the action only after the merge window is closed.
If it seems I also forgot doing that or you cannot wait for my action, please
feel free to directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
