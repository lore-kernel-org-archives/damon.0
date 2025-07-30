Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3080D18B0F;
	Wed, 30 Jul 2025 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753849270; cv=none; b=bxOwRmsP9HAUhpsQnP70LwmjmjWiSf4g/5RtEcjzFNKJaCcxt8XIBWW62zDskBt8gf52/OLRlUoamMPSDD9hXO9oia5M01HzSXJpe1z8r909OGZ37zdk5NsIM7tUdpUHLLV13iYsR6dVJhdEibYHhPbO9DbnU/I7WmmmxrkwZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753849270; c=relaxed/simple;
	bh=k/8G8hyODNHd1MnxESyODVAtIvqlJqbAiUqU3GNVU9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hEnnJ8LLb1J4KTUw9osTBej8pLgk2jwLJYKbQ9urNg8/NB8t2HgN0IPS9155/+dywAHXM9lj5cpiOQ28W60npL/X2z17Eu/4BdV21pn1+9mbyG8VtEkMJHwS+sXNwIsvCn1ylJT9eILTy9rhY4b6WyQPtHIOkhN6uE2boCcxxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMfnaGa+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMfnaGa+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5ACC4CEE7;
	Wed, 30 Jul 2025 04:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753849269;
	bh=k/8G8hyODNHd1MnxESyODVAtIvqlJqbAiUqU3GNVU9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMfnaGa+CQK2SCh2aG8cBF1BxlKL67zP5Bb0V7EECsve3ZlcwQGiBjtw++2of2VCU
	 1f6pgkcCr97tmBUag60Cov86CkuhLnLzFgFRTn50SF99uZ225eKvUUh9BbM/bNPapg
	 Xu81K3LsGq7D6zNG599XqcbHJbnhvqjedYrGv1RseNFCCkxBJNXNehUmTiC0xPw1e/
	 vPjOOc+m4Nsh/P9r05aB6h1P4mvnv3jauAzxmBoL9r0A92OdVqj+EfO+relPCB4lRq
	 F3KuikQ9d6xEFLp2QnCKtT+lrP4jaW8yTwEK8FOCXZqb2Uat7iq4V8kCfIQMhY7oLu
	 vPrrDF3DYTuEw==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jann Horn <jannh@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC v2 5/7] mm/memory: implement MM_CP_DAMON
Date: Tue, 29 Jul 2025 21:21:06 -0700
Message-Id: <20250730042106.54750-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <5acc6af3-91da-4dd3-834c-e8923e5d3320@lucifer.local>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Jul 2025 10:40:11 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Mon, Jul 28, 2025 at 08:06:32PM -0700, SeongJae Park wrote:
> > On Mon, 28 Jul 2025 06:19:35 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >
> > > On Sun, Jul 27, 2025 at 01:18:11PM -0700, SeongJae Park wrote:
> > > > DAMON is using Accessed bits of page table entries as the major source
> > > > of the access information.  It lacks some additional information such as
> > > > which CPU was making the access.  Page faults could be another source of
> > > > information for such additional information.
> > > >
> > > > Implement another change_protection() flag for such use case, namely
> > > > MM_CP_DAMON.  DAMON will install PAGE_NONE protections using the flag.
> > > > To avoid interfering with NUMA_BALANCING, which is also using PAGE_NON
> > > > protection, pass the faults to DAMON only when NUMA_BALANCING is
> > > > disabled.
> > > >
> > > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > >
> > > This seems to not be an upstreamable series right now unless I'm missing
> > > something.
> > >
> > > Firstly, you're making a change in behaviour even when CONFIG_DAMON is not
> > > specified, and Linus already told you we can't have that default-on.
> > >
> > > I'm very very much not happy with us doing something for 'damon'
> > > unconditionaly when !CONFIG_DAMON on the assumption that an acessible
> > > mapping has PROT_NONE set.
> > >
> > > This change makes me nervous in general ANYWAY as you are now changing core
> > > mm and introducing a new faulting mechanism specifically for DAMON.
> > >
> > > And we are assuming that NUMA balancing being disabled is not racey in a
> > > way that will cause things to break.
> > >
> > > I really also dislike the idea of an _implicit_ assumption that we are good
> > > to use the NUMA balancing faulting mechanism to 'tack on' DAMON stuff.
> > >
> > > Is it really all that useful to provide a method that requires NUMA
> > > balancing to be diabled?
> > >
> > > Finally, you're making it so DAMON can mprotect() something to use the
> > > DAMON/NUMA balancing fault handler, which doesn't appaer to check to see if
> > > NUMA balacing is disabled, but anyway it could be re-enabled?
> > >
> > > And then now DAMON is making stuff fault as NUMA balancing faults
> > > incorrectly?
> > >
> > > This just seems broken.
> > >
> > > Unless there's really good justification I'm really not inclined for us to
> > > merge this as-is right now unfortunately.
> >
> > Thank you for review and comments, Lorenzo.  I fundamentally agree all your
> > points.  I don't aim to merge this as-is.  Actually this patch series is more
> > like POC, but apparently I was rushing.  I will try to adjust your concerns in
> > the next version.
> 
> Thanks.
> 
> I do wonder whether we really can have a whole new faulting mechanism just for
> DAMON. Because if in future, we wanted to change how this worked, we'd be
> constrained, and it is a very specific user.
> 
> The issue is you need the PTE to be restored to its previous state, just like
> NUMA balancing.
> 
> And I really really do not like this 'oh if you turn it off you can use it for
> DAMON' thing, it's just really odd and asking for trouble.
> 
> I think the only _workable_ version of this would be to convert the numa
> handling to a generic 'fault then restore' type mechanism that could be hooked
> in to by either NUMA or DAMON.

I agree, and this is my current plan for the next version of this patch.

> 
> But really I think you'd _need_ to not have significantly different behaviour
> between the two and _not_ constrain this to being only when NUMA balancing is
> disabled.

I agree all the points.  Especially the current interface is ambiguous and easy
to mistake.

> 
> But then you'd need to know _this_ PTE is for NUMA balancing vs. another is for
> this stuff.

Yes, this would be the ideal.  But, memorizing something in page level is ...
always an interesting challenge in my opinion, and I have no good idea to do
this for now :)

> 
> I'm not really sure there is an upstreamable version of this, but it'd need to
> be made generic like that if there were.
> 
> I think it might be worth taking some time to examine whether a version of this
> that can be sensibly generic (which could have hooks for things) is _possible_
> before sending a v2.

Agreed, I don't need to rush.  Let's take time and discuss sufficiently. :)

Nonetheless, I may post a followup version of this patch series that contains
this one, even before we get a conclusion about this specific one.  I think I
may have to do that, for sharing the future idea in a way easy to understand
and test.  I think it might also help us at understanding the real ROI of this
patch, and if there is another option to move forward.  In the case, I will of
course keep RFC tag and clearly note that this patch is still under the
discussion and not willing to be merged as is before the discussion is done.

> 
> > >
> > > Also are we 100% sure that there's no races here? When we disable numa
> > > balancing do we correctly ensure that absolutely no racing NUMA balancing
> > > faults can happen whatsever at this juncture?
> >
> > Enabling CONFIG_DAMON will not automatically invoke change_protection() with
> > MM_CP_DAMON.  Such invocations will be made only if the user disables NUMA
> > balancing and run DAMON in the reporting mode.
> >
> > So there can be two racy cases.
> >
> > If the user enables NUMA balancing and then disables it after a while, page
> > faults for MM_CP_PROT_NUMA can be handled by DAMON.  That could look odd, but
> > there should be no real problem in practice.  DAMON's fault handling will
> > cleanup the PAGE_NONE protection like NUMA balancing, and DAMON has no problem
> > at receiving such additional reports from MM_CP_PROT_NUMA-caused faults.  DAMON
> > may show a few more than expected accesses, but that's no problem for DAMON.
> >
> > Similarly, if the user starts DAMON in the report mode, stops DAMON, and then
> > enables NUMA balancing, faults for MM_CP_DAMON that installed while DAMON was
> > running in the report mode can be handled by NUMA balancing.  This should also
> > not make real problems in practice in my opinion.  NUMA balancing could see
> > more accesses and migrate pages little bit more than expected, but that should
> > be just for a moment.
> 
> I'm really concerned about these.
> 
> We're now introducing unexpected behaviour based on a race and allowing faults
> to be mis-handled.
> 
> I'm maybe not as confident as you are that everything will 'just work' and it
> seems like we're asking for obscure bugs in the future.
> 
> > > You really have to be 100% certain you're not going to wrongly handle NUMA
> > > page faults this way, on a potentially non-CONFIG_DAMON kernel to boot.
> >
> > I will ensure that never happens on CONFIG_DAMON disabled kernels, in the next
> > version.
> 
> Well, in the above you say that you can't help but do that when a race occurs?

I mean, I can't help when CONFIG_DAMON is enabled.

The race (or, handling faults that caused by other entity) can hppen if and
only if all below things happen.

1. CONFIG_DAMON is enbled.
2. CONFIG_NUMA_BALANCING is enabled.
3. The user repeatedly turns on and off NUMA balancing and fault-based mode
   DAMON in runtime.

If any of these are not true, the race can completely avoided.  I was saying
about the case that the first condition is not met.

> 
> >
> > >
> > > Keep in mind fault handling is verrrry racey (purposefully) and can be done
> > > under VMA read lock alone (and that's only very loosely a lock!).
> > >
> > > This is just, yeah, concerning.
> >
> > Thank you for the caution.  DAMON's fault handling code only saves the
> > information in its internal ring buffer.  It doesn't touch vmas.  So I think
> > there should be no such problems.  I will add the clarification on the next
> > version.
> 
> Right, I'm just saying that this all being super racey between NUMA
> enabled/disabled seems pretty unavoidable, but we covered above.
> 
> > >
> > > Secondly, somebody can disable/enable NUMA balancing, and thus you are now
> > > allowing this function to, when somebody specifies 'DAMON', get NUMA
> > > balancing fault handling??
> > >
> > > If you don't bother checking whether NUMA balancing is disabled when you
> > > set it, then boom - you've broken the faulting mechanism, but even if you
> > > _do_, somebody can just switch it on again...
> >
> > As I explained on the two racy cases aboe, faults that caused by DAMON or NUMA
> > balancing can be handled by the other's handling code, but only for a limited
> > time under the user's controls.  But to my understanding that should not cause
> > real problems in the practice, and users wouldn't be suggested to operate the
> > system in such a way.  I will add more documents and cautions about that in the
> > next version.
> 
> I really don't think a version of the code that results in the wrong handler
> being used is upstreamable, sorry.
> 
> I've not dug into the nitty gritty details on what would happen in both cases,
> but even if it were 100% fine _now_, this is _exactly_ the kind of thing that
> results in horrible hard-to-debug issues later, should something change.
> 
> Implicitly 'just having to know' that we might be in the wrong fault handler
> seems like asking for trouble, and the RoI on an optional profiling tool (this
> is not to take away from DAMON which is a _great_ utility, I'm saying it's
> simply not part of the _core_) isn't there.

I completely understand your concerns, thank you for nicely and patiently
keeping this discussion.  I don't need to upstream this in short term, and open
to every option.  So let's take sufficient time and discussions.

I will take more time to think about a few potential options to move forward,
and share those with a level of details that can help us easily further
discuss, hopefully in a few days.


Thanks,
SJ
