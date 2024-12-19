Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B871A23AC;
	Thu, 19 Dec 2024 04:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581030; cv=none; b=vBKREnCTsYjr53Cocuekn7czv4I7Yl+29HYY5HLDhHj4IiHiq4bvjy9qp/0CkJaV3V13DnFuQCPG0xotxibZuEvbKwR/ixm3P2Bridg0YsdKTqQ5rbT80ZriX+GJHXlxJQXZohJCPMQKra6JN1lm5dcUvdqytv/cJ7S5x33OVK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581030; c=relaxed/simple;
	bh=NyHDQet0LRs2AoDvHZh43WUs/U9z0r8H5Ts9BS0wdXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uqZFmWuVcuTj9zUm3GfIwiIidsqKjTbEcpxXjyvx0V8olaP2yt0wBIX5k6HB1lRdjHhOwoDhYk/tyDVjKzl8B2Hwgxtfsp4N4iGNjgtNKy2OW3SzHuFVn1CVA0hE4QAQPMcXGaI3zatSN/5sGpq4NeJZ6HCMc1T2P/Nuj8Yl3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYwAX7Xr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYwAX7Xr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD6CC4CED4;
	Thu, 19 Dec 2024 04:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734581030;
	bh=NyHDQet0LRs2AoDvHZh43WUs/U9z0r8H5Ts9BS0wdXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYwAX7XrgZWFXmgmYy9RrbgMbpulDtXMa+kPOwJ3WYCEdKsREfTaO3PA3QNyjZLNL
	 4ljRYx1V8TP0l87I3/C6lTns2NsF4SroAfF1ZDghJLjJT7M/Wr1qs6fQpouwrDsH7i
	 3y6UtNk1IcZqc4RZh2H2QNbXXeuvV65MFz5Mx6bgaQhR3dkgNCcFd0GK/pN9XIq7Kb
	 FYU+VpgzN5ZImbV49cPC/n1UUW5C9e/26hjrvMam32dMsJFP80tNuYfnZi9UO2i9Nd
	 EB5qVlkBmK/Xo4f6TS3No1FiO7wrCJxkrKtyxE/v8ERGdhIiXzS77+wEdPXKawjFZs
	 GW5vGIbI3MovQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 10/18] Docs/mm/damon/design: document sz_ops_filter_passed
Date: Wed, 18 Dec 2024 20:03:19 -0800
Message-Id: <20241219040327.61902-11-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: <20241219040327.61902-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new per-scheme accumulated stat for total bytes that passed
the operations set layer-handled DAMOS filters on the design document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index e2666124e382..0620675a1e8d 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -552,6 +552,8 @@ scheme's execution.
 
 - ``nr_tried``: Total number of regions that the scheme is tried to be applied.
 - ``sz_trtied``: Total size of regions that the scheme is tried to be applied.
+- ``sz_ops_filter_passed``: Total bytes that passed operations set
+  layer-handled DAMOS filters.
 - ``nr_applied``: Total number of regions that the scheme is applied.
 - ``sz_applied``: Total size of regions that the scheme is applied.
 - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
-- 
2.39.5

