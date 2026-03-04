Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6AC341ADD;
	Wed,  4 Mar 2026 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636615; cv=none; b=V2TwnQHoDjQoQaOKnxt5dyKXlMEtL9ux8agK/wu0UqNnKU/oDwqcvm90MRmLvsc1KFnm1u56dVXvklJr+n+jZWAD9ehsOYoSQ9arTfvRESQr5XQig3ESOysagU7ygTHF0dwZW6buIvKtcf2D/nyHeCrtcdXUE73Db6nu2OCZleA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636615; c=relaxed/simple;
	bh=mE040friD/D8vUlGR6SF6lCV5t9rYG9oPgW77/JY5bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qr9pN6nIcMdTCTr13xT9w/XlHm0ozhnbjJpOgYLP0X7fY/TmHVNoD9MY6/QTETSJc3vzo+wU1szn5soyqPl/ET2gMtrmPqMx4i4LRIpsE6GUnL9eZkeEyyJ2255+J/8wTsoy1QKGn2lora7Fetpyiyvmr7fLqczrZ9THj34HNPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJAqghuQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJAqghuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAB9C4CEF7;
	Wed,  4 Mar 2026 15:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772636614;
	bh=mE040friD/D8vUlGR6SF6lCV5t9rYG9oPgW77/JY5bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJAqghuQ0TJn+SKiqRfKLM05J6MzDxoz3ubM1FnAUsKVkhZKV/rlhFG8jkc6FrLBQ
	 rVBxbihRWUo+j/hmjHxVYVU/PyIyG/lsNEyi1T4yWbleHpa1RJct0xyZ6VqTsKK8xM
	 /NtKB1W0z4N67tvUK8suaSegffaOU3yBHYGtuqI4f4x8DlVzQMT3CIUf0Ww7n3e5qo
	 MBLukmLDkYuLAHHCsdj3dHmTa0uHdqgjPUJ2K8JZjrHxGstCpXGlDftEIXBE8oNTF+
	 PAxbThpYqfTUBZSw03Qz2N96iHdBeWUf8bAfHtWR5YO8fcTq2VRcP/pD1gUKbq/05h
	 GcbgPiA8Z63jQ==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 00/10] mm/damon: support multiple goal-based quota tuning algorithms
Date: Wed,  4 Mar 2026 07:03:26 -0800
Message-ID: <20260304150327.172442-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <3c9449c1-95c7-4770-8e06-1ee50e263db8@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 4 Mar 2026 13:15:29 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SeongJae!
> 
> Nice idea for dynamic environments.

Thank you :)

> 
> On 3/4/2026 7:41 AM, SeongJae Park wrote:
> > Aim-oriented DAMOS quota auto-tuning uses a single tuning algorithm.
> > The algorithm is designed to find a quota value that should be
> > consistently kept for achieving the aimed goal for long term.  It is
> > useful and reliable at automatically operating systems that have dynamic
> > environments in the long term.
> > 
> > As always, however, no single algorithm fits all.  When the environment
> > has static characteristics or there are control towers in not only the
> > kernel space but also the user space, the algorithm shows some
> > limitations.  In such environments, users want kernel work in a more
> > short term deterministic way.  Actually there were at least two reports
> > [1,2] of such cases.
> > 
> > Extend DAMOS quotas goal to support multiple quota tuning algorithms
> > that users can select.  Keep the current algorithm as the default one,
> > to not break the old users.  Also give it a name, "consist", as it is
> > designed to "consistently" apply the DAMOS action.  And introduce a new
> > tuning algorithm, namely "temporal".  It is designed to apply the DAMOS
> > action only temporally, in a deterministic way.  In more detail, as long
> > as the goal is under-achieved, it uses the maximum quota available.
> > Once the goal is over-achieved, it sets the quota zero.
> 
> I'm not sure "temporal" is the best name for this type of behaviour.

I agree there could be a better name.

> 
> How about "by_score?". For example, "damos_goal_tune_esz_bp_by_score" and
> DAMOS_QUOTA_GOAL_TUNER_BY_SCORE.

And thank you for the suggestion!

But... I don't think "by_score" is much better, because all tuners are assumed
to, and actually do the tuning of the quota based on the score.  Or, maybe you
mean it makes non-zero quota only until the score becomes the goal?  That makes
sense, but again, in a sense, that's same for "consistent" tuner.

Naming is difficult...

I was also thinking about a few more names, but my conclusion after the self
discussion was that some of ambitious names are inevitable here.  Otherwise,
the name will be too long.  I therefore picked the shortest and simplest ones
on my list, which at least contrasts the current two tuners.  I agree that
could still be difficult to understand.  But as long as there is a good
documentation, I think difficult-to-understnd names that encourage users to
read the document is ok and might even be better in some cases.

I'm of course open to other suggestions.


Thanks,
SJ

[...]
