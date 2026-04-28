Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F008E3AEF20;
	Tue, 28 Apr 2026 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389876; cv=none; b=Qjbn5RuNxHV0aJ4kGvnnaYu2cseNdhEe+qNn1y9ewaQQDh8fEWRfwgxa05cFpRyW/EMTKnSB4Hwo5zaeU4YB/Gj3QTa/w4igUj5HwlWbawA0/L1uJvJF5e7LnHfaxbPD0CzK+5FWAbxTEihVwIctStvpBQjqY+a9VXHpvstIdDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389876; c=relaxed/simple;
	bh=fr/tHmzNTkk/OXH8pUHVXJSnE5ydLpCRkC0pcGdssWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8VU2ETBJYg+Hq1fhWgShjQuLlsHCDqJwffhPnI8CY2Y1TGOYpgX6r79fHayiBMQKXEQk3nhkdagultECyU1n8kHc8DNNSsLvWagvC31ODA+F9oZTBfjQYIrR75OjyHKltWhyHwO1w8WQ4TQJfY0rDc2rrn5xy51ZM+N/9LAv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSMNQjLt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSMNQjLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ABCC2BCAF;
	Tue, 28 Apr 2026 15:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777389875;
	bh=fr/tHmzNTkk/OXH8pUHVXJSnE5ydLpCRkC0pcGdssWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tSMNQjLtSoXFNyCgm2wvc8eGNOP4NeBV9NZcV/XrVIib6Z9f8/tfJffjfvB8sKFYd
	 STyJPHytDTqo1Bt/xjBXWzeAZji45aqvCmQn5M56VtflBesWmRin5y6bnruoqXyoEy
	 JJ1k8sMu0B56WF7UhBV6Z01OcL1blMBFkEskJFuf1d0T4cTRwmbrp9/TPb51BrDLy3
	 tsyH2PsD6PmXnuEGfX5L1Wg08A9dgX55HtjWkyynMyrURPWbUvvLi7/V0MeEdwgL/P
	 TdBR581p0YYiVJFnF7NPa85gd59pXY9iy+HtLNi4WRNn8ZvU57TxmoeDYzVIsXTcgI
	 q5k9YALgCwVWA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: Re: [PATCH 00/11] mm/damon: introduce DAMOS failed region quota charge ratio
Date: Tue, 28 Apr 2026 08:24:24 -0700
Message-ID: <20260428152424.125760-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428074837.5fb02e0210ebabf160506a80@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Andrew,

On Tue, 28 Apr 2026 07:48:37 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 27 Apr 2026 18:33:49 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > TL; DR: Let users set different DAMOS quota charge ratios for DAMOS
> > action failed regions, for deterministic and consistent DAMOS action
> > progress.
> 
> Add, thanks.
> 
> As mentioned provately, Sashiko claims to have found things which it
> didn't see in the RFC.
> 
> 	https://sashiko.dev/#/patchset/20260428013402.115171-1-sj@kernel.org

TL; DR: I find no blocker for this patch series from the Sashiko reviews.

Now sashiko replies its reviews for DAMON patches to authors and
damon@lists.linux.dev.  So I replied [1,2,3] my review of the reviews to those
on damon@lists.linux.dev mailing list.  As I mentioned on the TL;DR, I find no
blocker for this series.

And I think you didn't see those because those are sent to only authors and
damon@lists.linux.dev.

I nowadays reply-all to original recipients only if Sashiko found a blocker.  I
will also add short notice for non-RFC patches if Sashiko found zero issue.
Let me know if you want a different approach.

If it helps, maybe I can also ask Sashiko to send the DAMON patch review mails
to you together.  Let me know if you want that.

[1] https://lore.kernel.org/20260428032324.115663-1-sj@kernel.org
[2] https://lore.kernel.org/20260428033833.115866-1-sj@kernel.org
[3] https://lore.kernel.org/20260428034139.115984-1-sj@kernel.org


Thanks,
SJ
