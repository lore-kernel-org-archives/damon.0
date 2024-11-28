Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06711BD9D3;
	Thu, 28 Nov 2024 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732816249; cv=none; b=WaXZmrjiaHy/5dDemnTU58UlmjKmRBPMTUnWmqeYMY+Xk1jCq9AAAqg9hI0a54e6GFMtnPIb40hF8EErYMg/X1e7jyDmaSzgiAdNGdp148VYYaE/zj01Dq/OCnrxVWFjGcA+r4y8D56vOMmQLUdTvl69PTm8v23CK4q6cYdTNfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732816249; c=relaxed/simple;
	bh=4uzwBgLdANxp3xPDpK+HTjhj4ebgQrIW0HuWcaGrwCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VDaOznm35sN3y6MU8qEj65fxIKv5prX1c1A8kDJ+sd3QWvGq8OXPRUVaBiRUumPhHjnZWCwv4uk4p4k37bCXY4HZplLBsnGeLPwlG3P1WIDsVEp4vBx+r6iGwQNMFxAV/XQ0tYHd89fIFeFA03ylL5IYjc/sQm+QTa16swX5S0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEcYfti9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEcYfti9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D48C4CECE;
	Thu, 28 Nov 2024 17:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732816248;
	bh=4uzwBgLdANxp3xPDpK+HTjhj4ebgQrIW0HuWcaGrwCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AEcYfti9AGZip33OkET++gHH8tKanuXiv0orblAoXmZsAj8ADmsGKgA8bzzenrwnB
	 PecU1vHbb036NnrdlNCWubM8tZaXK+yLqiV9HkLJ++cCloSNCh3p+FuYph5yhgzwrk
	 i2iY/TxgZE4iNmMuMYE14I0fEUE9partQ1zbsn2oIDmj0E4A8C53KT7j40CZuq6PYx
	 HIgdzRBj+QYSu0V9QlRQknNu83q40OkM+R4NbMSyMCRbYj1tq0e/jPIsbl+ax+ld+e
	 7cEwybNXb+S2r2H85M5ZJCS3fwCHTJXyIHF3ZYgZnM13/msmEM5uQBMNKraj+YIf+N
	 cmKMh1hyY3MFw==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	kernel_team@skhynix.com
Subject: Re: [RFC PATCH] mm/damon: explain "effective quota" on kernel-doc comment
Date: Thu, 28 Nov 2024 09:50:46 -0800
Message-Id: <20241128175046.87869-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241128095357.1530-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 28 Nov 2024 18:53:55 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> On Tue, 26 Nov 2024 11:43:47 -0800 SeongJae Park <sj@kernel.org> wrote:
> > On Tue, 26 Nov 2024 17:24:33 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > 
> > > Hi SeongJae,
> > > 
> > > Thanks very much for the quick response.
> > 
> > No problem, all owing to your kind report!
> > 
> > > I think it looks great but I
> > > have some minor comments so please see my inline comments below.
> > > 
> > > Thanks,
> > > Honggyu
> > > 
> > > On Mon, 25 Nov 2024 16:29:21 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > The kernel-doc comment for 'struct damos_quota' describes how "effective
> > > > quota" is calculated, but does not explain what it is.  Actually there
> > > > was an input[1] about it.  Add the explanation on the comment.
> > > > 
> > > > [1] https://github.com/damonitor/damo/issues/17#issuecomment-2497525043
> > > > 
> > > > Cc: Yunjeong Mun <yunjeong.mun@sk.com>
> > > > Cc: Honggyu Kim <honggyu.kim@sk.com>
> > > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > > ---
> > > >  include/linux/damon.h | 10 +++++++---
> > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > > > index a67f2c4940e9..a01bfe2ff616 100644
> > > > --- a/include/linux/damon.h
> > > > +++ b/include/linux/damon.h
> > > > @@ -193,9 +193,13 @@ struct damos_quota_goal {
> > > >   * size quota is set, DAMON tries to apply the action only up to &sz bytes
> > > >   * within &reset_interval.
> > > >   *
> > > > - * Internally, the time quota is transformed to a size quota using estimated
> > > > - * throughput of the scheme's action.  DAMON then compares it against &sz and
> > > > - * uses smaller one as the effective quota.
> > > > + * To convince the different types of quotas and goals, DAMON internally
> > > > + * converts those into one single size quota called "effective quota".  DAMON
> > > 
> > > Could we use "effective size quota" instead of "effective quota"?
> > > IMHO, it will better give an idea this is related to "esz" in the code,
> > > which means effective size.
> > 
> > The above sentence is saying it as one single "size" quota, so calling it
> > "effective size quota" here feels like unnecessary duplicates of the word
> > ("size") to me.  I'd like to keep this sentence as is if you don't really mind.
> 
> Since the time or other goals are eventually transformed into a size
> quota, I thought the "effective size quota" makes sense but I won't
> stick to my term here.

I understand your concern.  But I want to make it not very strictly fixed and
well-defined term, but just somewhat understandable with common sense and given
context, for flexibility and conciseness.  So unless this is really makes it
difficult to understand what it means even with common senses and the context
I'd like to keep current form.

I believe your answer to the above question is "no" since you mentioned you
won't stick to your term.  Please let me know if I'm misreading you.

> 
> We originally asked this question about the term "effective" itself as
> we didn't find an explanation what "effective" means actually in the
> doc.  It'd be better to have more explicit explanation as well.

I think this patch makes the point pretty explicit, so my humble brain is bit
confused what "more explicit" really means.  Could you please clarify what
changes you want to be added?


Thanks,
SJ

[...]
