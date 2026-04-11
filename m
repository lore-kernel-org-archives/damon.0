Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010001990C7;
	Sat, 11 Apr 2026 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775932234; cv=none; b=hQxzsjMIXsH6rK3bf0IMYzNjfe6xP7F8qwtbACeNxS08UTOzXpAWfFx6hyNkFHmrMPFm2Ey1nCrwJdNZ8Tp/dSOhdhKdfrsPw5Qsr3493NCtFVvsWdOL/RprDhdck59gyRTQ3t17mEqM3Mvgj6ivenXBD/Klive4GrG3Fy/SMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775932234; c=relaxed/simple;
	bh=mLSQWve9N/mlO5SXnAvX0HsuAFea8uaQZNXy0IbkfAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGMwACSmsWsj+1POEJoSPFDV+J8jw4hQNsXQwMzWu+W6HckbrBvDHodRUkiX/+rDB9n+Ze/c6YZ4/ev80DTbN7CC1OoBUwezmdlS4Mv+dBHMCSLCWVObwF5ps9JRhcQIlqbGjGaRzmdcGQLKzLWVHuUClny8lV+UA/MrU7PArMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke0O3GVp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke0O3GVp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11878C2BCAF;
	Sat, 11 Apr 2026 18:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775932233;
	bh=mLSQWve9N/mlO5SXnAvX0HsuAFea8uaQZNXy0IbkfAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ke0O3GVp6IITC+iJp7VtuYaRRbp5kTdF9bs6QqrRuNBD+9WtGzHy3Ila+/oZnRY+T
	 CNHhVVCP1kmx7qNxB+npWEipsjHZ4LHkf2xKGyn2CwxRvvPfeiTjjdvl7OJ+BtnWxL
	 kUunptxPOq/7r8HpuUUh8REh8p4PJqLTz9Rev0IMl0wdA93jbMhtlr6N39sFeoQf1O
	 HnN1dCtLSbv1FxH3tqv3VzhKt+r4NoViCXsAqvs4I6q/q7pU4ksuenXqx2pRJEN+tc
	 JnLyLxKoqN69mGwRE0uGc5leol7UFZRYwhpBA0cbN4VUPMgvNn+3j3rs8jZrFScM0n
	 suAgTcIkPyslA==
From: SeongJae Park <sj@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] Docs/mm/damon/maintainer-profile: add AI review usage guideline
Date: Sat, 11 Apr 2026 11:30:28 -0700
Message-ID: <20260411183029.81030-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20aa1471-5257-4913-ae46-7b40ca0aa128@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 11 Apr 2026 11:27:14 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> 
> 
> On 4/11/26 10:49 AM, SeongJae Park wrote:
> > DAMON is opted-in for DAMON patches scanning [1] and email delivery [2].
> > Clarify how that could be used on DAMON maintainer profile.
> > 
> > [1] https://github.com/sashiko-dev/sashiko/commit/ad9f4a98f958
> > [2] https://github.com/sashiko-dev/sashiko/commit/b554c7b6e733
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  Documentation/mm/damon/maintainer-profile.rst | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
> > index bcb9798a27a86..5c23b1281c50c 100644
> > --- a/Documentation/mm/damon/maintainer-profile.rst
> > +++ b/Documentation/mm/damon/maintainer-profile.rst
> > @@ -100,3 +100,24 @@ There is also a public Google `calendar
> >  <https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t>`_
> >  that has the events.  Anyone can subscribe to it.  DAMON maintainer will also
> >  provide periodic reminders to the mailing list (damon@lists.linux.dev).
> > +
> > +AI Review
> > +---------
> > +
> > +For patches that are publicly posted to DAMON mailing list
> > +(damon@lists.linux.dev), AI reviews of the patches will be available at
> > +sashiko.dev.  The reviews could also be sent as mails to the author of the
> > +patch.
> > +
> > +Patch authors are encouraged to check the AI reviews and share their opinions.
> > +The sharing could be done as a reply to the mail thread.  Consider reducing the
> > +recipients list for such sharing, since some people are not really interested
> > +in AI reviews.  As a rule of thumb, drop individuals except DAMON maintainer
> > +and stable@vger.kernel.org from the recipients list.
> > +
> > +`hkml` also provides a `feature
> > +<https://github.com/sjp38/hackermail/blob/master/USAGE.md#forwarding-sashikodev-statuscomments-to-mailing-list>`_
> > +for such sharing.  Please feel free to use the feature.
> > +
> > +It is only a non-mandastory recommendation.  DAMON maintainer could also ask
> 
>                 non-mandatory

Good eyes!  Thank you, Randy.  I use Google doc for typo checks, but seems the
use of "-" made Google doc not to complain this.

> or maybe
>   This is an optional recommendation.

Sounds better, I will respin with this, unless Andrew picks this patch with the
change.


Thanks,
SJ

[...]
