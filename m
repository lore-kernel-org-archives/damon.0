Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0147B1B425C
	for <damon@lists.linux.dev>; Mon, 22 Dec 2025 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416915; cv=none; b=VPaj/Hgh1X/QiD+kBC/3MO/cE1k94veUCOjsucDtyQTW5g7g8aD1DKEYo1aDav+jbY4jQaDPFMCgUgsS3OKd0d66XramyTlfi0ONzImKTf4NFQsu89HEkbUKxwi/1kZ16hS9bvAqW18mm1ETIKnyng49F6GUaWpeZPmyGL2Gq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416915; c=relaxed/simple;
	bh=p/o1StfdPmpdCYRBTasptwpEFdmjcQVICrxmpQdm+aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xu4sVNGbqBhZt40Hz2uXDI4Otp15gLGnmQKuvN8WXopK93g7abNPgXuHjZZyIUONSr0JPe19AiHnkoPgS4btHUexDE5dFq+HbVbWenkysDQm7fJoS8WSqhywSvnAGymgxVAa+9Tbxk0VU4mSvAqjqQnou+qdlZmRZdiIGyXv2gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpuhZYnD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpuhZYnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70806C4CEF1;
	Mon, 22 Dec 2025 15:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766416914;
	bh=p/o1StfdPmpdCYRBTasptwpEFdmjcQVICrxmpQdm+aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OpuhZYnDquRSj38GLzsReaiVJaQU5IHBeW1iG+A8TOdjqph8Dwu9NvK1fQ5pnI3oe
	 OSOZ/p97KA2vAR7qrL5+C08f4vq0gHhPT2LkeR5ESbsu+u8KsSH0k9nkMnLmyUTGmT
	 vqGnS5TzSXdX7RueTaoOzvh1Maoeh2YF5xsKym3Bqnzfw+lgN+GKrHhtF9HQO+DuMO
	 FQzIVom4s/arxMqXwGaTGw96EnhKPsrm/CgTSkbQnJC4x1GQsnAomBLU+eN9JLDkLK
	 hvcSCu5WuFEeZsPh60Y2qI3N8INFJ+4tGDMaAqAYIkW5urkyEK77zs//M9x+VapWBt
	 8dQImec/7NKSw==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH 0/2] mm/damon: export symbols and introduce prdm module
Date: Mon, 22 Dec 2025 07:21:45 -0800
Message-ID: <20251222152147.87398-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <638d4c03-f7c1-4ba9-801f-18c860960eeb@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 22 Dec 2025 15:08:01 +0800 Enze Li <lienze@kylinos.cn> wrote:

> Hi SJ,
> 
> I appreciate you taking the time to provide such a detailed reply.  I
> have a few more questions.  Please see below.
> 
> On 12/19/25 7:46 PM, SeongJae Park wrote:
> > On Thu, 18 Dec 2025 21:46:37 +0800 Enze Li <lienze@kylinos.cn> wrote:
> > 
> >> On 2025/12/16 07:16, SeongJae Park wrote:
> >>> Hello Enze,
> >>>
> >>> On Mon, 15 Dec 2025 22:20:55 +0800 Enze Li <lienze@kylinos.cn> wrote:
> >>>
> >>>> This patchset makes DAMON's advanced memory management accessible to a
> >>>> broader range of users through two complementary enhancements.  First,
> >>>> it exports the necessary DAMON core symbols to enable building loadable
> >>>> kernel modules.  Building on this foundation, it then introduces the
> >>>> 'prdm' module, which extends the concept from the DAMON sample code
> >>>> (prcl.c) into a production-ready, user-friendly tool.
> >>>>
> >>>> The key strength of this module is its out-of-the-box simplicity: by
> >>>> simply specifying the PIDs of target processes and enabling the module,
> >>>> users can concurrently monitor memory access patterns across multiple
> >>>> processes and trigger proactive reclamation automatically.  This
> >>>> significantly lowers the barrier to using DAMON, allowing system
> >>>> administrators and regular users without deep kernel expertise to easily
> >>>> apply sophisticated memory optimization.
> >>>
> 
> <...>
> 
> >>
> >> Before developing prdm, I had considered implementing the same
> >> functionality based on DAMON_RECLAIM.  However, I gradually realized
> >> this would make DAMON_RECLAIM overly complex and less
> >> user-friendly—especially given its existing module-specific exported
> >> interfaces, which could confuse users.  This approach would create
> >> significant barriers to promoting wider DAMON adoption.  Consequently,
> >> building upon the prcl sample became the preferred choice.
> > 
> > I agree DAMON_RECLAIM already have no small number of parameters, and adding
> > more may make it look even more complex.  But, users may use only parameters
> > that really need to be set for their real use case.
> > 
> > For example, if we implement virtual address spaces mode in DAMON_RECLAIM, I
> > think we can simply add target_pid parameter that works very same to that of
> > prdm.  If it is unset, DAMON_RECLAIM works in the physical address mode.  If it
> > is set, it works in the virtual address mode.  Adding just one more parameter
> > that doesn't break old usage doesn't seem that complex change to me, at least
> > in terms of the user experience.
> 
> This should be viable, though it will take a moderate amount of extra
> time to develop.
> 
> > 
> > As I mentioned above, yet another example would be using
> > DAMOS_FILTER_TYPE_MEMCG.  For this, we may be able to add a parameter for
> > describing the memcg of critical processes.  Again, adding just one more
> > parameter that doesn't affect old usages doesn't seem too complex changes to
> > me, at least in terms of the user experience.
> > 
> > Meanwhile, I agree adding a new simpler module could make it easy for new
> > users.  But, I concern if having two modules for DAMON-based reclamation will
> > make users get difficulty at finding the correct one for their usage, since
> > they may now need to compare two modules.
> 
> Indeed, you're right.  From an architectural perspective, having two
> modules forces users to spend time distinguishing between them, which
> can cause confusion.
> 
> <...>
> 
> >>>
> >>> And, even more importantly, why it should be a loadable module rather than a
> >>> static module?  Do you have a specific use case that requires it to be a
> >>> loadable module?
> >>
> >> Yes, loadability is crucial for operational flexibility in practical
> >> production environments.  Beyond some obvious advantages, I would like
> >> to highlight a key scenario: system administrators can load the prdm
> >> module upon detecting memory pressure and unload it immediately after
> >> reclamation is complete, thereby eliminating any overhead during normal
> >> operation.
> > 
> > I agree always having prdm in kernel is an overhead.  But, I think the
> > overhead is not meaningfully big.  Also, as I mentioned above, my intended use
> > cases of DAMON modules is for cases that willing to simply always use the
> > modules.  If runtime controls are essential, I think using DAMON sysfs
> > interface or DAMON user-space tool is a better choice.
> 
> The prdm was developed based on samples/damon/prcl.c.  Would it be an
> acceptable modification to port the multi-process support feature to
> prcl?  Does that make sense to you?

Yes, that makes sense.

Please note that the purpose of sample modules is not to be used in the real
world products, but just explaining people how DAMON API can be used.  In this
case, I think multi-process support feature can let people better understand
how they can use DAMON for multiple processes, so I think that's good to add.

> 
> > 
> > Someone might argue DAMON sysfs interface is unnecessarily big compared to
> > prdm.  But, I have to ask again in the case.  Does the overhead really
> > meaningfully big for a real world use case?
> > 
> >> Furthermore, it supports zero-downtime updates, meaning that
> >> improvements targeting prdm can be deployed via a simple module reload,
> >> avoiding costly system reboots.
> > 
> > So I'm not really convinced at needs of prdm module at the moment.  But I agree
> > your above point is a good example advantage of loadable modules.  Also there
> > were private requests to support loadable DAMON modules.  No one among those
> > were for real production use case, and I understand you are also doing this
> > work for imaginable use cases, not your real products.  Please correct me if
> > I'm wrong.  But as the request is repeated, if you willing to convert existing
> > DAMON modules to support loadable modules build and expose required DAMON
> > functions for that, at least I wouldn't oppose.
> 
> Thank you for your feedback.  I would like to try it out.

Looking forward!

Please note that there could be objection from others, though.  In the case,
unless you have real world usage of loadable DAMON modules, I may have to agree
to the others' concerns, like I had to do so [1] last time.

[1] https://lore.kernel.org/damon/20231205172307.2310-1-sj@kernel.org/


Thanks,
SJ

[...]
