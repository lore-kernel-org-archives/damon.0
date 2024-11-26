Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066011DAC8A;
	Tue, 26 Nov 2024 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732650231; cv=none; b=iaDdX9bcvU905fbsT1nIjNOS1Kr732V10Ukcs91l29oVz0/uaUu8pHQilv/NjFQafimkRWF1fS2o120htv1Ru+vnDgmliuAyoHgVWnXYHqlV00sGYhghUySZfVDIDlPK4dX2EyH4+VToryzYrKZM4Vod9wI74kF21wyZzl10FxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732650231; c=relaxed/simple;
	bh=hUEJ2mm62pyewmPyILbKuAM0dRAk+OMEv4YUZmgG9k0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ho2mzbRN5ZP9Hdeifzp/uZmEtzfdFz70vtVLs/Iba3qVTadTg8N9K/pjHHO1arZXzcTwJ4R/9vLJonV66s7OFBMN8DqfvxHrHJDCUYB6mgZHioE+eWsZAdphD7X8M7zTAze/NeLoGTiS2qElyPT7T49xOyEF7IKtqKZcvmNdTTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXMb1yMj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXMb1yMj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3ADC4CECF;
	Tue, 26 Nov 2024 19:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732650230;
	bh=hUEJ2mm62pyewmPyILbKuAM0dRAk+OMEv4YUZmgG9k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JXMb1yMjnE200+j2SCCTKsA8wAY3MsS9Rehl6V8oDpy9FmJ4WYUiYHc7O5IQreKef
	 Ydsk9IHy6cBId+mF5kGmpzS1WhWkZcF2uYt+6/V8X4ksgPSoTEXTMFI976We6Bs5sz
	 9I/OT09XyrCsjZ0Wjck0SHOoVt/n4AiBqX2VifVxg3Aeg+eFVdHFid5prsPlILmtKn
	 9Hh48gxKa+2vyY6YTJNky65u4QAx2XkCfvqj2NO9gQIiuBzeyVmf9RKgCrWQ/cO456
	 +7pVxPGs3zw2lDvwqJmFKiJsntbxBXP58PwJIhfTAqxn08pQnpYikraXW+fuXr+RX4
	 cg/GA4nqjI/yA==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	kernel_team@skhynix.com
Subject: Re: [RFC PATCH] mm/damon: explain "effective quota" on kernel-doc comment
Date: Tue, 26 Nov 2024 11:43:47 -0800
Message-Id: <20241126194347.58155-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241126082436.1491-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 Nov 2024 17:24:33 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> Thanks very much for the quick response.

No problem, all owing to your kind report!

> I think it looks great but I
> have some minor comments so please see my inline comments below.
> 
> Thanks,
> Honggyu
> 
> On Mon, 25 Nov 2024 16:29:21 -0800 SeongJae Park <sj@kernel.org> wrote:
> > The kernel-doc comment for 'struct damos_quota' describes how "effective
> > quota" is calculated, but does not explain what it is.  Actually there
> > was an input[1] about it.  Add the explanation on the comment.
> > 
> > [1] https://github.com/damonitor/damo/issues/17#issuecomment-2497525043
> > 
> > Cc: Yunjeong Mun <yunjeong.mun@sk.com>
> > Cc: Honggyu Kim <honggyu.kim@sk.com>
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  include/linux/damon.h | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index a67f2c4940e9..a01bfe2ff616 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -193,9 +193,13 @@ struct damos_quota_goal {
> >   * size quota is set, DAMON tries to apply the action only up to &sz bytes
> >   * within &reset_interval.
> >   *
> > - * Internally, the time quota is transformed to a size quota using estimated
> > - * throughput of the scheme's action.  DAMON then compares it against &sz and
> > - * uses smaller one as the effective quota.
> > + * To convince the different types of quotas and goals, DAMON internally
> > + * converts those into one single size quota called "effective quota".  DAMON
> 
> Could we use "effective size quota" instead of "effective quota"?
> IMHO, it will better give an idea this is related to "esz" in the code,
> which means effective size.

The above sentence is saying it as one single "size" quota, so calling it
"effective size quota" here feels like unnecessary duplicates of the word
("size") to me.  I'd like to keep this sentence as is if you don't really mind.

> 
> > + * internally uses it as only one real quota.  The convert is made as follows.
> 
> (nit) "as only one" can be "as the only one".
> (another nit) "The convert is made" can be "The conversion is made".

Nice eyes!  I will fix those.

> 
> > + *
> > + * The time quota is transformed to a size quota using estimated throughput of
> > + * the scheme's action.  DAMON then compares it against &sz and uses smaller
> > + * one as the effective quota.
> >   *
> >   * If @goals is not empt, DAMON calculates yet another size quota based on the
> 
> We better fix "empt" to "empty" together.

Nice catch!  I will fix so.

> 
> >   * goals using its internal feedback loop algorithm, for every @reset_interval.
> > -- 
> > 2.39.5
> >


Thanks,
SJ
