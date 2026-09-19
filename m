Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7298A2F6562;
	Sat, 19 Sep 2026 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789833232; cv=none; b=b+AEho3msUjTYkve6uADF4o8jxPnGLGAOoBtNSxfaLKOKYs51vHxUcYjmVV3mPTo2OLp4r6bRTiejZrT0X0ObdUr9K1acMeJhBpUWg+uqF34p8/3gYgr0lr5JnYny1hlX6b2foAUoDdM6RPpFw/9ew6w5sVg5D8hme7KsySt50A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789833232; c=relaxed/simple;
	bh=TuB8MHyrxAOCzn7Y/px8CN8uozVWxe8hrGP17bOcswo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCpIaXDxjF0wvz4zxm0ykP40gtB4PT7LAY0nfC4rzEn/zCKnrgpxPb05gVtIh1+/InXVnXeiKbN63FEA5n24RWX/CZCSJkWejeL5eZ3u8lYaIKDTZ2vZf1T0QfO919iZx6DH98m5Z1w0FhXGIJJlDWesh6JNmAj15MO7vt7xSjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTIX4ZY1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTIX4ZY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226951F000FF;
	Sat, 19 Sep 2026 15:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789833229;
	bh=i/uBEdJPm1aQswNq4LdASQ6ufGvoxHbey0sIvh1PP5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iTIX4ZY1UjG0u1Zijb/Prirq3sF+j0Y0tqKsLQ1PigyMCQNg8c0mDUATHMU/NO4xq
	 6gGUsAFfRMEv8ttEzoNmOr2oYHgxLKR9ttRGg1U3259Ts8Zf2p8f/dilzHKhN19wx5
	 ji2RWjLuZC2b07j1knyz5qze7vla3heqSBwT0VuzYQYZHyT1vxdYGwVtPNfrp7Xrc1
	 f2dQoh6/ZDQvDv8yKGjZP2KIj8ju7DsGK3cVC+ILV3JIVHGTnuf4h3ACIXxI7HRFcS
	 F5EC4+lp9wKpFGO8ev1jEIZY6jQFaxemzW5IbpGUiu24EjYcUPEl3X3XWAzhME+8d4
	 0oes1c7tWCfNg==
From: SJ Park <sj@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: score an unmeasured PSI goal as not achieved for the temporal tuner
Date: Sat, 19 Sep 2026 08:53:41 -0700
Message-ID: <20260919155342.85699-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aq4g5W58PgWLqJ8p@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 19 Sep 2026 07:44:11 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:

> On Tue, Sep 15, 2026 at 05:13:11PM +0100, SJ Park wrote:
> > So I'd still prefer to just making no effect this round.  And my commit was
> > failed at doing that, because it didn't aware of temporal tuner.  Maybe we
> > could show whether the goal was achieved or not, using esz and let the tuner
> > show same achieveness?  What about something like below?
> > 
> 
> Thanks for explaining the two concerns. I am still new to the DAMON
> code, so I may be missing something, but your suggestion looks good
> to me and it is simpler than what I had. I have prepared a v2 this
> way and will wait for your comments before I send it.

Thank you for accepting my humble suggestion, please feel free to send it when
you are ready!

> 
> One note on the first concern: as far as I can see last_psi_total is
> updated in every tuning round, so commits in between would not make
> the measured time longer than the reset interval. But I am fine with
> your approach either way.

last_psi_total is updated in every tuning round, as you mentioned.  But the
tuning round comes if both the scheme apply interval and the quota reset
interval are passed.  damos_adjust_quota() has the quota reset interval check.
kdamond_apply_schemes() has the apply interval check before calling
damos_adjust_quota().

'''
static void kdamond_apply_schemes(struct damon_ctx *c)
{
[...]
        damon_for_each_scheme(s, c) {
                if (time_before(c->passed_sample_intervals, s->next_apply_sis))
                        continue;
[...]
                damos_adjust_quota(c, s);
'''

'''
static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
{
[...]
        /* New charge window starts */
        if (!time_in_range_open(jiffies, quota->charged_from,
                                quota->charged_from +
                                msecs_to_jiffies(quota->reset_interval))) {
[...]
                damos_set_effective_quota(c, s);
'''

And the apply interval (or, next_apply_sis) is extended for each commit, in
damon_set_attrs().  Hence, the problem can still happen.

> 
> I would also move the last_psi_total update into the new helper, so
> that the helper is the only place that touches the field and the
> unit test can check it.

Sounds good!

> 
> While testing this with damo I found a second problem. A full
> "damo tune" still gave a zero quota for one window, on the unpatched
> kernel too. damon_new_scheme() runs damos_quota_init() on the quota
> of the caller, and since b90408ef1163 damon_commit_ctx() passes the
> quota of each running scheme to it for the test context. So every
> full commit zeroes esz, esz_bp and the charge state of the running
> schemes. Please correct me if I read this wrong. I can send a
> separate patch for that.

I don't really understand the problem.  Could you please further elaborate?

> 
> In a quick QEMU test with your suggestion and that change, the quota
> stays at 1 MiB over "damo tune" and "damo tune --quota_goals_only".

Sounds good.  Looking forward to your next patch!


Thanks,
SJ 

[...]
