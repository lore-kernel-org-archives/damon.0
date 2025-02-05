Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AEE23CE
	for <damon@lists.linux.dev>; Wed,  5 Feb 2025 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791867; cv=none; b=VAvv9vXYkKkc8Q8N02Q5nfdCQXytD6b4gdBGb/JzVdvXUMXOqBtg+iyBS/+T24yZFFTZFoJ8H9FU1uuGJgcrLRe3D0n27OAR0XWIpBE4eQiFt2djRXScPhZm5KFHLifeNMKKBC5Y5X8lFIDgcuvVM4lyOrG6AAWE+tHKb6NigdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791867; c=relaxed/simple;
	bh=zwpk8ivjbp2tDW2TdfvJlWP4WNbGXDP645Klw4KbNb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhwy6AU3qqS83AlgCTl/Xxl9aPzR0AvUc33fvozQHuyOGl1t9UzAOdANb/+G0qTKlTzzr6M4SSsUpSIqTT7Aut/jqCwMP2/FXc2t0k+mP4kgvQ3AiWK/VvI0os+4eM7ddHbgI20UK7vS3S/F61Y9iiYpoDoVM0Ov2IQNV9TVN1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGUoq9+s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGUoq9+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0DCC4CED1;
	Wed,  5 Feb 2025 21:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738791867;
	bh=zwpk8ivjbp2tDW2TdfvJlWP4WNbGXDP645Klw4KbNb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CGUoq9+sIAI+u9/4OP9OTh70labvdLs/JrqZTEz99zRswo+wGsQyW4JIerlDovphc
	 /TZpSTYo/m9w6lLBOxlqhNsPg4xteiZQHCO4PGJMGIWc8TH/RTrU0apoYMtRs7UmyX
	 OMbU0AGKIBHtNvTL5QUHVg8uUlsosfvz/HpK5a7wL/atui3eGIeDD7pGtrdOPoCLOe
	 pgywiQw8kVKWyWplilfZBA9uToPmUFzUeVZ4sDo/6uzC/5GtlrZxrHkbUqYLWkX1sz
	 Gpw/qv2kNrp7kAmXPb6ykoKXasJiYVf8Ict6xrdgXIt6foq+5LlvvRvaMgR7xKI2Be
	 4kFzbsJEkT35A==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 3/6] mm/damon/sysfs-schemes: add files for setting damos_filter->folio_size
Date: Wed,  5 Feb 2025 13:44:22 -0800
Message-Id: <20250205214422.60201-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <591085b2-4566-429e-9ee4-991be41062f7@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 5 Feb 2025 13:57:05 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> 
> 
> On 04/02/2025 23:10, SeongJae Park wrote:
> > On Mon,  3 Feb 2025 22:55:30 +0000 Usama Arif <usamaarif642@gmail.com> wrote:
> > 
> >> Add min and max files for damon filters to let the userspace decide
> >> the min/max folio size to operate on. This will be needed to decide
> >> what folio sizes to give pa_stat for.
> > 
> > I'd prefer implementing the logic with API interface first, and then
> > implementing sysfs interface on top of the API.
> > 
> >>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> ---
[...]
> >> @@ -1953,6 +1999,13 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
> >>  			filter->addr_range = sysfs_filter->addr_range;
> >>  		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
> >>  			filter->target_idx = sysfs_filter->target_idx;
> >> +		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE) {
> >> +			if (sysfs_filter->folio_size.min >
> >> +					sysfs_filter->folio_size.max) {
> >> +				damos_destroy_filter(filter);
> >> +				return -EINVAL;
> >> +			}
> > 
> > I don't think letting users set invalid min/max is a real problem, as long as
> > the implementation will handle the case (no memory matches the filter).  Let's
> > just allow it, like addr_range case.  If we really need to disallow this, it
> > would better to do that from damos_commit_filter() like central point.
> > 
> 
> hmm, does addr_range allow it? it addr_range.end < addr_range.start it returns an error.
> I did it in a similar fashion for hugepage filter if min > max it returns an error.

Oh you're right...  Maybe I was just out of mind, sorry.  Please keep this part
as is your version to be consistent with the address range code.


Thanks,
SJ

> 
> 
> Full code of damon_sysfs_add_scheme_filters below:
> 
> 		} else if (filter->type == DAMOS_FILTER_TYPE_ADDR) {
> 			if (sysfs_filter->addr_range.end <
> 					sysfs_filter->addr_range.start) {
> 				damos_destroy_filter(filter);
> 				return -EINVAL;
> 			}
> 			filter->addr_range = sysfs_filter->addr_range;
> 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
> 			filter->target_idx = sysfs_filter->target_idx;
> 		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE) {
> 			if (sysfs_filter->folio_size.min >
> 					sysfs_filter->folio_size.max) {
> 				damos_destroy_filter(filter);
> 				return -EINVAL;
> 			}
> 			filter->folio_size = sysfs_filter->folio_size;
> 		}
> 
> 
> 
> >> +			filter->folio_size = sysfs_filter->folio_size;
> >>  		}
> >>  
> >>  		damos_add_filter(scheme, filter);
> >> -- 
> >> 2.43.5
> > 
> > 
> > Thanks,
> > SJ
