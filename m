Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6D5375ADD;
	Tue, 22 Sep 2026 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078931; cv=none; b=K8Un7RE9Hr/9SxZA3fA0V1l6Hov63Igqfcik65eIQZVCn5Elut8Wqz94BNfgQoQs0lydBd+1U9TyzpQTpAWZb3R0MAww56n8n+Jwral/yWNmFymaaYHuq+FxSQo4F84HO4WcJt4Zuyx3Qu88Y2McI8I6ue5IXn+50pKEuqeOT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078931; c=relaxed/simple;
	bh=Vjt+g7Xzasz723axhPTuNVzFKkdg4sQ6vitGnW6TTeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNIFfbXVM9aH8j5T0bzYcScYJT7P5Zh+LltPa7rg9XjN48RMaAm4OBXPM4IRF180G35utAwjDNCTVPRAS5Vfo4mz53zy2+kHccEqebqzQfporq2R15VolI3d2vACYCPP1w7nIxZbPholB6VGcq/pYfJKceOPbysnGGhnpa1Pkpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBmK4h4l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBmK4h4l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE741F000FF;
	Tue, 22 Sep 2026 12:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790078929;
	bh=lq/wHdaSQa/z2s8nS/PetepYnkUErjugT93n4BkcV9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aBmK4h4lv074Tbs7davGM/gGOn1tHm/rDVnAuFCAPjfC+IsjX1ePCgSAo2QpdvvVV
	 4ISfCrc27gfBne3DCyk/AHODwXJBHIURepOZyTluOEhE2SWagb1WeFEb8lgZgNVjEZ
	 uYpTIEQ/4iiumdSl5gbjRqmbaBmhLkwkebDklTJB/f72STau2droEilZlsp3/JE/4z
	 5GEDGnE0Tm2SVNE8m/ersTxjC7Zxq+jh5YNDwmoEUj9tcdRIsz7+1CZXAvaN4Ju6vv
	 7JbwvmeHLnQvyMXT+QSAKTA35T0aMySRYhOUdOszJ5Xg784AIBEKT8PWtwXL93//ut
	 9+wZRV22Uni8g==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: preserve the caller's quota in damon_new_scheme()
Date: Tue, 22 Sep 2026 05:08:44 -0700
Message-ID: <20260922120845.44460-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921171155.3359-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Sep 2026 10:11:54 -0700 SJ Park <sj@kernel.org> wrote:

> On Mon, 21 Sep 2026 02:30:46 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:
> 
> > damon_new_scheme() calls damos_quota_init() on the caller's quota before
> > copying it to the new scheme. This clears the caller's effective quota,
> > feedback input and charging state as a side effect.
> 
> Apparently the above paragraph assumes it is called under damon_commit_ctx().
> Lack of the context makes this quite confusing.  Could you please rewrite?

To calrify my opinion more, "caller's quota" feels unclear to me.  I hope it to
be more clear that it means "the quota that is passed as a parameter to the
function".

> 
> > 
> > damon_commit_ctx() first copies the running context into a temporary
> > context for validating the proposed parameters.

I'd prefer using the term, 'commit' instead of 'copies' for clarity.

> > When
> > damon_commit_schemes() creates the temporary schemes, it passes the quota
> > of each running scheme to damon_new_scheme(). The quota pointer therefore
> > refers to the running scheme, and damos_quota_init() clears that scheme's
> > state before it is copied to the temporary scheme. Even an update
> > rejected with -EINVAL loses the running quota state.
> > 
> > For a size quota, this discards the bytes already charged and allows the
> > scheme to use a fresh quota before the reset interval has elapsed. For a
> > goal-driven quota, the consist tuner loses its accumulated input and
> > restarts from its minimum input. A time quota loses its throughput
> > estimate and falls back to the initial estimate.
> > 
> > The constructor side effect was introduced by commit 70e0c1d1bf94
> > ("mm/damon/core: factor out 'damos_quota' private fileds initialization").
> > Commit 60bd24f272d0 ("mm/damon/sysfs: test commit input against realistic
> > destination"), merged in v6.19, exposed it when
> > validating sysfs updates against a copy of the running context. Commit
> > b90408ef1163 ("mm/damon/core: safely validate src on damon_commit_ctx()")
> > later moved that validation into the core API.

I overlooked this part in the previous reply, sorry.  And thank you for adding
this detailed context.

> > 
> > Sashiko reported the same side effect [1] on the RFC of the core API
> > change.

Nice catch, I misunderstood Sashiko's point.  Thank you for catching this,
Karl.

> > 
> > Copy the quota to the new scheme first, then initialize that copy. Make
> > damos_quota_init() return void, since its return value is no longer needed.
> > 
> > Fixes: 70e0c1d1bf94 ("mm/damon/core: factor out 'damos_quota' private fileds initialization")
> > Cc: <stable@vger.kernel.org> # 6.19.x
> 
> The Fixes commit was introduced in 6.1.  So the comment on Cc: stable@ line
> should be fixed.  Also, at the time of the commit, validation purpose running
> ctx committing didn't exist.  So, the issue you are explaining cannot happen on
> the commit.  Or, am I missing something?  If I'm not incorrect, could you
> please find the proper Fixes: commit and fix it?
> 
> Also, are you using LLM for Fixes...?  If so, the LLM seems not good at that.
> Your previous patch also made a similar mistake.  Please manually work on
> Fixes: tag or double check LLM's output.

Now I understand you added the comment for commit 60bd24f272d0.  I think Fixes:
should also be 60bd24f272d0.


Thanks,
SJ

[...]
