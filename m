Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404C346E57;
	Fri, 10 Apr 2026 23:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863952; cv=none; b=N3sr8ckXlbdGPdhnjDC8iJ8re8XuT9CGBIqKH/rCP76ITo81b747qmowThhtCp9CNhF3JbiHBW0tr6LXPgEUW4/Rfk5So85NvWv0i+8Sas60fozzac+RqUpukI8jUh9vwK2Lrax+fYAyt7Vr6sCVmt0qUr0Mlvfh1r4sxK3DxDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863952; c=relaxed/simple;
	bh=IV3mFcV+WfFE+K96xMEd38e94LBkkMv8FaH1PhoHLYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPZi0vG1yJ1j54y7iuXzRvKNtRkwbVDNL16giS8EnP5ca2psj4L/cGusQOr9BomMC9APkJDkyL+8x/sn7lM24UzU0MnKAUhVKzbLspyVuOldxVKor7rFlFZuXsz4tuPY6ktj1LX3AbTixQDR7qFBURJ9rhD2w5mp/fehRWMSM3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3Q+zmtD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3Q+zmtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8310C19421;
	Fri, 10 Apr 2026 23:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775863952;
	bh=IV3mFcV+WfFE+K96xMEd38e94LBkkMv8FaH1PhoHLYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E3Q+zmtDNgVMUah+YlSf9vBbWGR6tTqXsD9qISjT7L1McGuLeEU6YcOaYPV8E3vMo
	 5FxdvHcTC02fshJ9kTRpZ9KDik65jOwROJa8Lj44cTMExkR3yGGmIvX0WqE/Zxbfy0
	 frgu0+dy/0Wv0wNOEUGHD4G0xAT9Pqi1pGfSbfjDbavJZuWHd+VA+CYkULJDVYJeHn
	 eCwIKuwJWYdQ2mRc4+z7suDS8x+EMBt56MyoCTk21xa9uX82BVwmnLUdhUmLds2wHm
	 vIpnnSb1eXBQ2FtKcw4jb0+Z5uba9PAIvnrj3ZQZyIhohRKDQVPUtQVfXHT7nuhQw5
	 jbyPAC7ALE2Ig==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v5 01/11] mm/damon/core: handle <min_region_sz remaining quota as empty
Date: Fri, 10 Apr 2026 16:32:23 -0700
Message-ID: <20260410233223.88212-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410142034.83798-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: sashiko found a good finding that better to be done as a separate
cleanup work.  This patch still seems good to go as-is.

Forwarding sashiko review in a reply format with my inline
comments below, for details of my view and doing discussions
via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260410142034.83798-2-sj@kernel.org
> # start of sashiko.dev inline review
> commit 2ab7d52b1eb10efa95d43a8eee7c50fd9669d56d
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: handle <min_region_sz remaining quota as empty
> 
> This commit updates the core DAMOS logic to consider a quota fully charged
> if the remaining quota is less than the minimum region size. This prevents
> actions from being applied too frequently to specific memory areas.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 12544c60531d3..8dbc365bb8e97 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -2127,8 +2140,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
> >  			continue;
> >  
> >  		/* Check the quota */
> > -		if (damos_quota_is_set(quota) &&
> > -				quota->charged_sz >= quota->esz)
> > +		if (damos_quota_is_full(quota, c->min_region_sz))
> >  			continue;
> >  
> >  		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
> 
> With this new check skipping regions when the remaining quota is less than
> the minimum region size, does the truncation check in damos_apply_scheme()
> become unreachable?
> 
> Because damon_do_apply_schemes() will now only call damos_apply_scheme()
> when quota->esz - quota->charged_sz >= c->min_region_sz, the ALIGN_DOWN
> calculation:
> 
> damos_apply_scheme() {
>     ...
> 	if (c->ops.apply_scheme) {
> 		if (damos_quota_is_set(quota) &&
> 				quota->charged_sz + sz > quota->esz) {
> 			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
> 					c->min_region_sz);
> 			if (!sz)
> 				goto update_stat;
>     ...
> }
> 
> will always result in a value greater than or equal to c->min_region_sz.
> 
> Could the if (!sz) check and the corresponding goto update_stat be safely
> removed since sz can no longer evaluate to 0?

Good finding, but doing that would better to be a separate cleanup work.  I
will add that to my todo list, but keep this patch as is.

> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260410142034.83798-2-sj@kernel.org

Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260410142034.83798-2-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
