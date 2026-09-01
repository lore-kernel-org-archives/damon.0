Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB176233955;
	Tue,  1 Sep 2026 00:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223641; cv=none; b=Mf2Gseh0wXFnMcpXaRfWLstQLKUgRPgbrabnStm6pD4kkm7N8lDKmjNt6dGp/OeAJCXQMKVFq0qn7Xh9ZxbSKvCGbkTtByMsP+lmfvx0R4yOIHlhMMIGf0Zp29jVsSg76x3Nb7tV376swGAgE8WwhrFAlaLPOuOGLLK6R+c7TTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223641; c=relaxed/simple;
	bh=RDROc2CqtO/BFFYiNs4coZag/nP0r2uiVlubBK868gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPaiYAWur7GgACj7+YBRqSufQpDs8J+/HagJ4FCjXja66snDEvG40aw4XFpESYjXsn4NlYyArWeePoMDfn2n8XMFXvX1bfcC4Lw0szxlPmyRO01Q7F5rFjl8sCHH/Trt0JuCS7FsqF6o8dQfA8jb39DFHnb4myh8Jp7H4btKZIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMFJw5GD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMFJw5GD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0112D1F000E9;
	Tue,  1 Sep 2026 00:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223639;
	bh=LXWsMKMXC2X8nJTY0s4XiZNYUo4FSqt+7Ykdy8yx0Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dMFJw5GDOK1LB/kthZUOEnAAk5yFHCpRNEXKwFWe0eTxnlnOlwLPa3YCrwpIhFsHq
	 AZU1yChW2iRMUoqy6emQhhL1HcXbYi4vQS+HEsm3bQnll0mx7E654PEKh9wQhK32HT
	 8I21k7vMrAcbErslUCMzEPRID7+x0DTB1sAqR04EM2ytotQM/oj1Z+oPKiVnkCKRhi
	 H+t4LhO4IUfDQnUF0jSi70J3kX06dwGYXEwSOOGPfAGF6CgWzjRfquJ6Zml7WZDUrM
	 GlVw9AP/7sBk58FlJVCULgBNlaoKs9vQ4947f8FCFGA7jOAoRqkBRIBuUXiHkqJjz3
	 HZN2hkvu8S5NQ==
From: SJ Park <sj@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: Re: [PATCH v4 3/3] Docs/mm/damon/design: Document hugepage_mem_bp target metric
Date: Mon, 31 Aug 2026 17:47:11 -0700
Message-ID: <20260901004712.89669-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <107dc6ba-697e-4b25-ba3e-8ce2499cac9a@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 13:00:26 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> 
> 
> On 8/31/26 8:45 AM, Randy Dunlap wrote:
> > Hi,
> > 
> > On 8/31/26 7:47 AM, SJ Park wrote:
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>
> >> Document hugepage_mem_bp metric exposed by sysfs.
> >>
> >> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >> Reviewed-by: SJ Park <sj@kernel.org>
> >> Signed-off-by: SJ Park <sj@kernel.org>
> >> ---
> >>  Documentation/mm/damon/design.rst | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> >> index aed6cb1cf4831..a8c163475ef2b 100644
> >> --- a/Documentation/mm/damon/design.rst
> >> +++ b/Documentation/mm/damon/design.rst
> >> @@ -713,6 +713,8 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
> >>    bp (1/10,000).
> >>  - ``node_eligible_mem_bp``: Scheme target access pattern-eligible memory ratio
> >>    of a node in bp (1/10,000).
> >> +- ``hugepage_mem_bp``: Total huge page to total used memory ratio in bp
> >> +  (1/10,000).
> >>  
> >>  ``nid`` is optionally required for ``node_mem_used_bp``, ``node_mem_free_bp``,
> >>  ``node_memcg_used_bp``, ``node_memcg_free_bp`` and ``node_eligible_mem_bp`` to
> > 
> > I've looked thru the entire design.rst file and cannot find anything telling
> > me (or anyone) what "bp" means.  Explain??
> 
> OK, I found it on the internet. I still think that it would be a
> good idea to say "basis point" one time (the first time that it is used).

You are right, and I agree.  I will add that clarification before the next
merge window.

> 
> 
> -- 
> ~Randy


Thanks,
SJ
