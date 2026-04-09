Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE729430;
	Thu,  9 Apr 2026 00:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775692845; cv=none; b=Vf5nCfWqJ+c7ia1qtN2ZW6anUcu3ExLVOGkoZS5TbY5ifEH3wuQB8rQGJO8NtIn9OqScM6ppLFEOCv5lwOMjVX9DIOmHOsJ5Oq3q2m0rMw+BIcmfojKQDSm4nOdF1Co2EUiHuT+fL0oIu5+ptLtA+8WAIHtS1OxvxHCuotoC6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775692845; c=relaxed/simple;
	bh=qppp/68yL1FBDErK+oJASXFD51sGuVpQH4bDIkn6sd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smevstitVsCeoP16fd7gGX3jq/p35SX3h1pXfLbP8cM2Ij26qTlNtobaLO9MRh4JAoLyjxj0mfO6U3p1ynQFdyJxOZo0Hxje+/idLS0vsPseC1fVK5WkKePD70yurwa0LtYJK/9Ovh0SoQVXqKLMwLyCGLXctvVOwRbXOL06pDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n04EEiiR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n04EEiiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA1AC19421;
	Thu,  9 Apr 2026 00:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775692844;
	bh=qppp/68yL1FBDErK+oJASXFD51sGuVpQH4bDIkn6sd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n04EEiiRelmZ/SxG+FaURhv7uQcCIcGYP3/75s3NiC605Ngr69+aovYWbEwoH9NL1
	 yv4Xr9QeT2jBYiIIqk79Yj0PnEAaxmenTnicD0vVUJ2E/G1o+Q4HBV9EDvj+xAe4mC
	 LQRPF2G7satvRydNnV6IU0kpjz7z7my+VTNB/wVx8dt09yzYgiH+kH8S4o9koNhf1R
	 sK6YGvl4jitOVXt+b8jQQkEIWVLf9RiD+LM6JfkTNkKzwDaZ+GIe53rlkRPlku+kcl
	 2Fcy18YfoqTtqaHCs/Xj9Dn30F9fwUr1a8fhf9wszeQXe0h4dv/DoWtiqApmxw22Pb
	 6q4tylb2cHW9A==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
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
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v3 00/10] mm/damon: introduce DAMOS failed region quota charge ratio
Date: Wed,  8 Apr 2026 17:00:34 -0700
Message-ID: <20260409000035.93742-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260408165001.8473-1-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  8 Apr 2026 11:48:27 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> On Mon,  6 Apr 2026 18:05:22 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> Hi SJ,
> 
> > TL; DR: Let users set different DAMOS quota charge ratios for DAMOS
> > action failed regions, for deterministic and consistent DAMOS action
> > progress.
> > 
> > Common Reports: Unexpectedly Slow DAMOS
> > =======================================
> > 
> > One common issue report that we get from DAMON users is that DAMOS
> > action applying progress speed is sometimes much slower than expected.
> > And one common root cause is that the DAMOS quota is exceeded by the
> > action applying failed memory regions.
> > 
> > For example, a group of users tried to run DAMOS-based proactive memory
> > reclamation (DAMON_RECLAIM) with 100 MiB per second DAMOS quota.  They
> > ran it on a system having no active workload which means all memory of
> > the system is cold.  The expectation was that the system will show 100
> > MiB per second reclamation until (nearly) all memory is reclaimed. But
> > what they found is that the speed is quite inconsistent and sometimes it
> > becomes very slower than the expectation, sometimes even no reclamation
> > at all for about tens of seconds.  The upper limit of the speed (100 MiB
> > per second) was being kept as expected, though.
> > 
> > By monitoring the qt_exceeds (number of DAMOS quota exceed events) DAMOS
> > stat, we found DAMOS quota is always exceeded when the speed is slow. By
> > monitoring sz_tried and sz_applied (the total amount of DAMOS action
> > tried memory and succeeded memory) DAMOS stats together, we found the
> > reclamation attempts nearly always failed when the speed is slow.
> > 
> > DAMOS quota charges DAMOS action tried regions regardless of the
> > successfulness of the try.  Hence in the example reported case, there
> > was unreclaimable memory spread around the system memory.  Sometimes
> > nearly 100 MiB of memory that DAMOS tried to reclaim in the given quota
> > interval was reclaimable, and therefore showed nearly 100 MiB per second
> > speed.  Sometimes nearly 99 MiB of memory that DAMOS was trying to
> > reclaim in the given quota interval was unreclaimable, and therefore
> > showing only about 1 MiB per second reclaim speed.
> > 
> > We explained it is an expected behavior of the feature rather than a
> > bug, as DAMOS quota is there for only the upper-limit of the speed.  The
> > users agreed and later reported a huge win from the adoption of
> > DAMON_RECLAIM on their products.
> 
> Thanks for this series. This is a problem I have come across and am looking
> forward to seeing this land.

Thank you for acknowledging.  I'm hoping this to land on 7.2-rc1.

[...]
> > DAMOS Action Failed Region Quota Charge Ratio
> > =============================================
> > 
> > Let users set the charge ratio for the action-failed memory, for more
> > optimal and deterministic use of DAMOS.  It allows users to specify the
> > numerator and the denominator of the ratio for flexible setup.  For
> > example, let's suppose the numerator and the denominator are set to 1
> > and 4,096, respectively.  The ratio is 1 / 4,096.  A DAMOS scheme action
> > is applied to 5 GiB memory.  For 1 GiB of the memory, the action is
> > succeeded.  For the rest (4 GiB), the action is failed.  Then, only 1
> > GiB and 1 MiB quota is charged.
> > 
> > The optimal charge ratio will depend on the use case and
> > system/workload.  I'd recommend starting from setting the nominator as 1
> > and the denominator as PAGE_SIZE and tune based on the results, because
> > many DAMOS actions are applied at page level.
> 
> This makes sense, but the quota is also considered when setting the minimum
> allowable score in damos_adjust_quota(), which, to my understanding, assumes
> that all of the all of a region's data will by applied. If an action fails for
> a significant amount of the memory, a lower score than what was calculated in
> damos_adjust_quota() could be valid. If that's the case, the scheme would be
> applied to fewer regions than strictly necessary.

Good point, you are right.

> 
> As you mention above, this is not a correctness issue because the quota only
> guarantees an upper limit on the amount of data the scheme is applied to.

I agree.

> Additionally, it may very well be true that what I listed above would not be
> very noticeable in practice.

I guess it is hopefully true, for following reason.

The score for each region is calculated as a weigted sum of the access
frequency and the age of the region.  To avoid DAMOS action is repeatedly
applied to only a few regions, we reset age of regions after a DAMOS action is
applied to the region, regardless of the action failure.  So, periodically the
score of the regions having the action unapplicable region will get low, make
no big impact to the minimum score threshold calculation.

But real data could say something different.  I will be happy to be proven
wrong my real data. :)

> I just thought this was worth pointing out as
> something to think about.

Indeed.  Thank you for pointing out.  Nonetheless this is not a new issue that
introduced by this patch series.  And the impact is not clear at the moment.  I
will be happy to revisit this in parallel to this patch series.


Thanks,
SJ

[...]
