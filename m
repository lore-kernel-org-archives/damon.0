Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812817D6;
	Thu, 26 Feb 2026 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772067278; cv=none; b=QhA3LNe3irR0gjaAIlREm6SiiZM5nuIgRxrdOVqakv13KEC82l98I878yIngZ/OcxqaBYhQQ+T791Ot7lkcfJdZwyFwUa6tiTFjpeaXS7DuKL5wUz2XMqQbOWZ0tXaRIZQ+e9PiJdGUEHCyiYspQ4q0JkvwBPAPZ6NVNmcogQ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772067278; c=relaxed/simple;
	bh=N92T+3E8LhZQO5VlmuG98fMnfwS5aJm8dE5mN5TOOPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z21/LuO8/oCR7NFbt3/X06qzLsWGZbsO47rJQC0/smiklkXkvCMOBVk5LR/uazo/w9avhji27eOaKziIPwmLKGy2rTLanILIuMCa73+/YrH38cnf9ohdw27OjaiiIsdoDc4WZ3TzxfI0Wku/jGCL9yPu5LVskz+XGXKhaFm0oJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GreAoEyx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GreAoEyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5F5C116D0;
	Thu, 26 Feb 2026 00:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772067277;
	bh=N92T+3E8LhZQO5VlmuG98fMnfwS5aJm8dE5mN5TOOPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GreAoEyxNF1eCY+CIwrbtaTJSy8AV5QsujAvVhjp7m7ngK8yWSr9tyhAOIP7jbLqg
	 FHKjWE3mTCyROdAbSdDehqcSGc7iDgX0sE0iAWIDHeNWn0EM3tEac8t1nQxuwpbwUH
	 SNy8bLmX5q5ZnTKUDMBIckIMitO7xkRNF6GM4z9Ze66Wa/Wc87gnkaG0EYHC0kQ69P
	 5ar1/ljiF1kT6uhBEQ3e8yJXk+REgpcy2VP1wue02mKeKsqmXmeV07HAHNea5xlADN
	 7JS6b05uPvt1YReO3pRWF7S7gWeGu111D4xLAT/V2O5K0UeJ3uzPJJbH7u9SxwZZ7l
	 sYweuYj21WS1g==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH v3 2/4] mm/damon: fix esz=0 quota bypass allowing unlimited migration
Date: Wed, 25 Feb 2026 16:54:34 -0800
Message-ID: <20260226005435.7720-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y15BbvgKttRRxrNrr38y3Pt4A+MP8tfQZZ7LVyoUS+_0fQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 25 Feb 2026 10:28:30 -0800 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> On Mon, Feb 23, 2026 at 5:54 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Mon, 23 Feb 2026 12:32:30 +0000 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
> >
> > > When the TEMPORAL goal tuner sets esz_bp=0 to signal that a goal has
> > > been achieved, the quota check was not actually stopping migration.
> > >
> > > The condition:
> > >     if (quota->esz && quota->charged_sz >= quota->esz)
> > >
> > > When esz=0, this evaluates to (false && ...) = false, so the continue
> > > is never executed and migration proceeds without limit.
> >
> > Nice finding, thank you for sharing this!
> 
> Thanks!
> 
> >
> > >
> > > Change the logic to:
> > >     if (!quota->esz || quota->charged_sz >= quota->esz)
> > >
> > > Now when esz=0, (!0 = true) causes the continue to execute, properly
> > > stopping migration when the goal is achieved.
> >
> > But this code is written in the way because the current code assumes zero 'esz'
> > means it is not being used and therefore be ignored.  This change should be ok
> > for your use case, but could introduce an unexpected behavioral change for
> > other users.
> >
> > One easy workaround would be setting esz_bp with a value smaller than 40960000
> > instead of 0.  That is, esz_bp is the bytes in bp, so setting it smaller than
> > 40960000 will result in making it effectively zero, e.g., like below.
> >
> > '''
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2623,7 +2623,7 @@ static void damos_goal_tune_esz_bp_temporal(struct damos_quota *quota)
> >         unsigned long score = damos_quota_score(quota);
> >
> >         if (score >= 10000)
> > -               quota->esz_bp = 0;
> > +               quota->esz_bp = 10000;
> >         else if (quota->sz)
> >                 quota->esz_bp = quota->sz * 10000;
> >         else
> > '''
> >
> > But maybe there is a better way to cleanly fix this.  Let me take a time to
> > think more...
> >
> 
> I understand. Please take your time. I'm happy to test whatever approach
> you come up with.

Thank you for being flexible, I will do!


Thanks,
SJ

[...]
