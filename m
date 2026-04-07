Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A654632;
	Tue,  7 Apr 2026 00:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775520799; cv=none; b=LoCBknDY0DAaNkv9RNQsABgKk1/g1dirJvXCWtCk68Va8HQ/lljcx94V7JClkhhNuqMAwFkc8GT4OWFacBN/lqefZnR1oUbrw3VZfAD/S1AJAmSHNYEw5N4fiTMVSrjEsfFgycQyNkOzL8OHNkrSlnTckUSvATPBDW9hKoiXvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775520799; c=relaxed/simple;
	bh=BGK91Zud1kj/tvt7oieAdbvvJZc26dEc8R4BMeClsPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNweija9rczgWBXQJLbg/rv0mbmc9LdYYsbNP7t5taylVIO69gIZsGhGgbfS9Qy45B4WBuvA9lfZbT5q2YhdDep7xvjGz0rBB5j4wOgVo6pvt9mBv8/acfFeCzgfXrRsLkWamqVy3Sdfa3bsQluo4RnYBqdb4fnRo6j6+DhRbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tm6l9d4j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tm6l9d4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68043C4CEF7;
	Tue,  7 Apr 2026 00:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775520798;
	bh=BGK91Zud1kj/tvt7oieAdbvvJZc26dEc8R4BMeClsPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tm6l9d4jQGiEtsxOMCMp//3292RFdMDB9vsyy6kw4WZSXcXUtHVOWBnL8S6YHCyh0
	 vW/zwlr/O/+PpP2TNA/v6zkE8Zl5TwoTpy1q4zJ4dZVcNyeVdAVI2CC/nfvCEh1JBg
	 MME4m0eAbWKFMzapwCXTk+fvMtRbhTYPCwzh3Uk+S395vQnLRybEZ689TYeSAgOT2W
	 X0JHiM+PFMIAc4E+JUkzmWwKSz2upRMgSrtxKFHTab8qyyU/zBdgif44TAihuFJHFD
	 Ofg7ChEtq4Fnq0SLQ5FBs5C9qMUzxsSzTNPNpnuFFpRs1z39tZcofKb19K/xh08Ttl
	 dDeuk3T4oQzpw==
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
Subject: Re: (sashiko review) [PATCH v6 1/1] mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
Date: Mon,  6 Apr 2026 17:13:08 -0700
Message-ID: <20260407001310.78557-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y14oWqu5+DbkENy7GgBjc=dCbFTaoOCr1i4=9CN-ZNRgEA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 6 Apr 2026 12:47:56 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> On Sun, Apr 5, 2026 at 3:45 PM SeongJae Park <sj@kernel.org> wrote:
> >
> >
> > Ravi, thank you for reposting this patch after the rebase.  This time sashiko
> > was able to review this, and found good points including things that deserve
> > another revision of this patch.
> >
> > Forwarding full sashiko review in a reply format with my inline comments below,
> > for sharing details of my view and doing followup discussions via mails.  Ravi,
> > could you please reply?
> >
> 
> Thanks SJ, providing your comments on top of sashiko's review is very helpful.

I'm glad to hear that it is working for you :)

[...]
> > > +static unsigned long damos_calc_eligible_bytes(struct damon_ctx *c,
> > > > +           struct damos *s, int nid, unsigned long *total)
> > > > +{
[...]
> > > > +                           struct folio *folio;
> > > > +                           unsigned long folio_sz, counted;
> > > > +
> > > > +                           folio = damon_get_folio(PHYS_PFN(addr));
> > >
> > > What happens if this metric is assigned to a DAMON context configured for
> > > virtual address space monitoring? If the context uses DAMON_OPS_VADDR,
> > > passing a user-space virtual address to PHYS_PFN() might cause invalid
> > > memory accesses or out-of-bounds page struct reads. Should this code
> > > explicitly verify the operations type first?
> >
> > Good finding.  We intend to support only paddr ops.  But there is no guard for
> > using this on vaddr ops configuration.  Ravi, could we add underlying ops
> > check?  I think damon_commit_ctx() is a good place to add that.  The check
> > could be something like below?
> >
> 
> I plan to add the ops type check directly in the metric functions
> (damos_get_node_eligible_mem_bp and its counterpart) rather than in
> damon_commit_ctx(). The functions will return 0 early
> if c->ops.id != DAMON_OPS_PADDR.
> 
> That said, if you prefer the damon_commit_ctx() validation approach to
> reject the configuration outright, I can implement it that way instead.
> Please let me know your preference.

I'd prefer damon_commit_ctx() validation approach since it would give users
more clear message of the failure.

> 
> > '''
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1515,10 +1515,23 @@ static int damon_commit_sample_control(
> >  int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
> >  {
> >         int err;
> > +       struct damos *scheme;
> > +       struct damos_quota_goal *goal;
> >
> >         dst->maybe_corrupted = true;
> >         if (!is_power_of_2(src->min_region_sz))
> >                 return -EINVAL;
> > +       if (src->ops.id != DAMON_OPS_PADDR) {
> > +               damon_for_each_scheme(scheme, src) {
> > +                       damos_for_each_quota_goal(goal, &scheme->quota) {
> > +                               switch (goal->metric) {
> > +                               case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
> > +                               case DAMOS_QUOTA_NODE_INELIGIBLE_MEMPBP:
> > +                                       return -EINVAL;
> > +                               }
> > +                       }
> > +               }
> > +       }
> >
> >         err = damon_commit_schemes(dst, src);
> >         if (err)
> > '''
[...]
> > > > +   /* Compute ineligible ratio directly: 10000 - eligible_bp */
> > > > +   return 10000 - mult_frac(node_eligible, 10000, total_eligible);
> > > > +}
> > >
> > > Does this return value match the documented metric? The formula computes the
> > > percentage of the system's eligible memory located on other NUMA nodes,
> > > rather than the amount of actual ineligible (filtered out) memory residing
> > > on the target node. Could this semantic mismatch cause confusion when
> > > configuring quota policies?
> >
> > Nice catch.  The name and the documentation are confusing.  We actually
> > confused a few times in previous revisions, and I'm again confused now.  IIUC,
> > the current implementation is the intended and right one for the given use
> > case, though.  If my understanding is correct, how about renaming
> > DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP to
> > DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP_COMPLEMENT, and updating the documentation
> > together?  Ravi, what do you think?
> >
> 
> Agreed, the current name is confusing. How about
> DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP_OFFNODE?
> 
> The rationale is that this metric measures "eligible memory that is off
> this node" (i.e., on other nodes).
> 
>  I think "offnode" conveys the physical meaning more directly than "complement".
> That said, I'm happy to go with "complement" if you prefer.
> both are clearer than "ineligible".

Thank you for the nice suggestion.  I like "offnode" term.  But I think having
"node" twice on the name is not really efficient for people who print code on
papers.  What about DAMOS_QUOTA_OFFNODE_ELIGIBLE_MEM_BP?

But...  Maybe more importantly...  Now I realize this means that
offnode_eligible_mem_bp with target nid 0 is just same to node_eligible_mem_bp
with target nid 1, on your test setup.  Maybe we don't really need
offnode_eligible_mem_bp?  That is, your test setup could be like below.

'''
For maintaining hot memory on DRAM (node 0) and CXL (node 1) in a 7:3
ratio:

    PUSH scheme: migrate_hot from node 0 -> node 1
      goal: node_eligible_mem_bp, nid=1, target=3000
      "Move hot pages from DRAM to CXL if less thatn 30% of hot data is
       in CXL"

    PULL scheme: migrate_hot from node 1 -> node 0
      goal: node_eligible_mem_bp, nid=0, target=7000
      "Move hot pages from CXL to DRAM if less than 70% of hot data is
       in DRAM"
'''

And the schemes are more easy to read and understand for me.  This seems even
straightforward to scale for >2 nodes.  For example, if we want hot memory
distribution of 5:3:2 to nodes 0:1:2,

	Two schemes for migrating hot pages out of node 0
	- migrate_hot from node 0 -> node 1
	  - goal: node_eligible_mem_bp, nid=1, target=3000
	- migrate_hot from node 0 -> node 2
	  - goal: node_eligible_mem_bp, nid=2, target=2000

	Two schemes for migrating hot pages out of node 1
	- migrate_hot from node 1 -> node 0
	  - goal: node_eligible_mem_bp, nid=0, target=5000
	- migrate_hot from node 1 -> node 2
	  - goal: node_eligible_mem_bp, nid=2, target=2000

	Two schemes for migrating hot pages out of node 2
	- migrate_hot from node 2 -> node 0
	  - goal: node_eligible_mem_bp, nid=0, target=5000
	- migrate_hot from node 2 -> node 1
	  - goal: node_eligible_mem_bp, nid=1, target=3000

Do you think this makes sense?  If it makes sense and works for your use case,
what about dropping the offnode goal type?


Thanks,
SJ

[...]
