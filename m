Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241472E2286;
	Thu,  2 Jul 2026 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783024405; cv=none; b=rPVtjuBs3vc1WneRzufNdOtUJod4RP20aEAosk+EaqyynINEGhpy/JGMdECwZLMld4jDR1+IUd597SA/Gt98ts6bEXJwKGgVCSdRmp8ME1J2ex6QKH3Ux326SClF9k+Do8xEi7cYvRcimURcV1+5bOhGMk9xVu/G8ZTMNAuClb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783024405; c=relaxed/simple;
	bh=CtDN9onV4E2wHKoFXKL6JeXuR3B/hVSAUL+XSMlweb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWNqN5oDePzHWBlWQetz+j50Su9MwkZnIjwgnYE3a3YvTAhlqKGRrET0aspGZGORxrgRJLSu/4hC17ZLt3xcigqBQXBrDremcJUtwI5LXasM0zalmbintdgFRKuwz6/qYUkHF+7CR+UeidCVgnru6KYsBK+UvGdL1ss368bEhvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiN6AJmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiN6AJmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911B41F000E9;
	Thu,  2 Jul 2026 20:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783024403;
	bh=1FuIOV38cvMRmE+tzQFc7VuKDySWog66SgpIkMC7W3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AiN6AJmxW3/s3cJU8IlsD4RhdhrIDtDb+v5KIm1E04CSrtWCpgSGJwoafB5YmVITl
	 ZMzezNtpvr+c9XC0WhaZ4g+ZGRe6/T3Ii5Uyw0T/CK3eORo9h08gTU7TtwhsSPsdWA
	 cZN6Wi/TPMklpIq+83PyZVUYrRiNMW2CV3OnYQrnTZ3e4gedS+XhkiQLSeqC/rSuSz
	 3K0fUSuQQSJQgNIfzhsbpYvj8FeYyIYIk3rSuFVXB4SUODfvwjaTZpI+lI+tUHvgJO
	 ls6yHIVeuGDGusv73x/wTZcKMXt5qlHE1d4bKjApPqui9KDUCH8W3stFLRsD/MWD27
	 2bCLvbnvz7Lig==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Lian Wang <lianux.mm@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	daichaobing@sangfor.com.cn,
	kunwu.chan@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v2 2/5] mm/khugepaged: add damon_collapse_folio_range() for external callers
Date: Thu,  2 Jul 2026 13:32:47 -0700
Message-ID: <20260702203248.92547-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702194353.91778-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 02 Jul 2026 12:43:59 -0700 SJ Park <sj@kernel.org> wrote:

> On Thu, 2 Jul 2026 12:07:01 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:
> 
> > (+cc missing people again)
> 
> Thank you for adding the recipients, and review, Lorenzo!
> 
> > 
> > Sorry but we're not going to accept anything that exports THP logic like this at
> > all.
> > 
> > And a damon wrapper in core mm code is just a non-starter, so you really need to
> > rethink your approach.
> > 
> > I think SJ already commented on this in your v1 from what I can see? I'd listen
> > to his advice on this :)
> 
> Lorenzo is right.  Not disrupting the world outside of mm/damon/ is the first
> principle of DAMON development.  Sometimes we may have to make some changes
> outside of mm/damon/, but we MUST make it not disruptive, small, and perfectly
> aligned with the developers of the area with respects.

The best option is just not doing this.  And that might be the case.

we already have pmd level DAMOS_COLLAPSE.  I find mTHP-supporting DAMOS_SPLIT
can be implemented without any changes on mm/damon/ external world.  If it is
true and there is no objection at doing that, mTHP collapse may not really
necessary.  That is, the users could collapse in pmd level first, and then
split in desired mTHP level to accomplish their goal.  I think that works for
common use cases, too.

It would be suboptimal to collapse in pmd level first and then split.  But the
efficiency is unclear.  I don't want to disrupt others for unclear gains.  We
can upstream split part first, measure the efficiency, and revisit mTHP
collapse if it turns out to be really needed.

What do you think, Lian?


Thanks,
SJ

[...]
