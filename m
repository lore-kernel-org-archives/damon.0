Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA552D238A;
	Sun, 12 Apr 2026 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776017282; cv=none; b=qEBYAaV1+aNNYB0T0eDuf28qpqtRcDYinpPP+D4puJqixMSQA8M2jl2qFYIAXjBjlrUMzrzhbYjncmr9hL/xArVkxIxY1wDsWaHoTb0Ar81wLJ+aGBLt2wId6YFzuxsScUDYKhIC/kOGlwv0HRk3c/+qXn8/f2Et4dPSsXL9jO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776017282; c=relaxed/simple;
	bh=j9bCpUOAdgji1Ws6v3/WY+Lm96551bwnQK0kjzDhHR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igcn2H3+aZyXejx+6ESfneEhwey7/EDkHlmxUhnQFSgj5hVGXo+cZH+eZQZk9HiIPxpyDEkjuJiR/rk9tvscfe/JpLEM8WZQNTDbeMZNbLb4TeQTyjBu90e4rkltCr+2vXM0t3yAtxRvHv2q/BDSe331QvLy1g5BE7Jt2fXEutI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryq/R4sz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryq/R4sz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D782C19424;
	Sun, 12 Apr 2026 18:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776017281;
	bh=j9bCpUOAdgji1Ws6v3/WY+Lm96551bwnQK0kjzDhHR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ryq/R4szgV+5ALXTSVljN9yRPh/6sm8i28Xk+omd9JFIq6uriFlNzNbNnY694jDEL
	 r+ZZYGdmE4iAtn6PJo+gOt27mXt1xbiq7OpvSQhxn+DU5xJ5F8vJrjVaVE905jjCLx
	 NIUBFhTW9zmaCg+974bNluzu5vqbLTK+8CU9TMXxarX73HVQfjhaZd15XcMJeGuDsL
	 JydkGXKQ7fyxZJBESfJxMjRIsJSzZ5O8+4hEAuHRPtyUT/AsMu/3YP3scX77ajjS8h
	 xqLTHXcsA+R69QRD9et3YUF2jx91gX+xVIgQwPHlnIvz3d5yUOUeRKM0xlFhL4LPAw
	 RFL/PUYLVzFqA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v5.2 03/11] mm/damon/core: introduce failed region quota charge ratio
Date: Sun, 12 Apr 2026 11:07:53 -0700
Message-ID: <20260412180754.84182-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260412161957.82835-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: Sashiko found no blocker for this patch.  It is just asking a same
question that I decided to ignore.

Forwarding full sashiko review in a reply format with my inline comments below,
for sharing details of my view and doing followup discussions via mails if
needed.

> # review url: https://sashiko.dev/#/patchset/20260412161957.82835-4-sj@kernel.org
> # start of sashiko.dev inline review
> commit 45b2671ba02d19f0991caa536696cde623c0c081
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: introduce failed region quota charge ratio
> 
> This commit introduces a new DAMON core API for setting the charge ratio
> for action-failed memory. It allows specifying the ratio using a numerator
> and denominator to make charging fairer for successful vs failed actions.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2041,6 +2043,23 @@ static void damos_walk_cancel(struct damon_ctx *ctx)
> >  	mutex_unlock(&ctx->walk_control_lock);
> >  }
> >  
> > +static void damos_charge_quota(struct damos_quota *quota,
> > +		unsigned long sz_region, unsigned long sz_applied)
> > +{
> > +	/*
> > +	 * sz_applied could be bigger than sz_region, depending on ops
> > +	 * implementation of the action, e.g., damos_pa_pageout().  Charge only
> > +	 * the region size in the case.
> > +	 */
> > +	if (!quota->fail_charge_denom || sz_applied > sz_region)
> > +		quota->charged_sz += sz_region;
> > +	else
> > +		quota->charged_sz += sz_applied + mult_frac(
> > +				(sz_region - sz_applied),
> > +				quota->fail_charge_num,
> > +				quota->fail_charge_denom);
> 
> Can this calculation overflow during the mult_frac() expansion?
> 
> The mult_frac(x, numer, denom) macro evaluates to:
> (x / denom * numer) + ((x % denom * numer) / denom)
> 
> Since both sz_region and sz_applied are unsigned long, on 32-bit systems this
> is a 32-bit type. If fail_charge_num is large, couldn't the remainder
> multiplication (or even the quotient multiplication) overflow unsigned long
> and truncate the size added to quota->charged_sz?

A question that same to what raised previously.  I decided to keep this as is
in favor of code simplicity, unless other humans make some voices.

> 
> > +}
> > +
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260412161957.82835-4-sj@kernel.org

Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260412161957.82835-4-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
