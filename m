Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB3636A030;
	Sat, 31 Jan 2026 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769888511; cv=none; b=AC4ySM7EgBP2yrEAe4hgMPBlMXyNnP62OhQ4fk/cfJe0F/4gApKBH17LuXXka6F+DXaTK9ObSn0xF2YMgCtUnqCSQAFkx+manP+VK2o8zqo10v/jBSENSerohz98dYw24HvurUpm+Hio1wbvt7/GQW1PPK8SW8ks0240/ODU1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769888511; c=relaxed/simple;
	bh=Lni0/9CHbjEMqtpfuZwpe7kNBiN1clVWOsovCwhBxjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y7FgB/22ku6z7e6JeE4SXbPCohynWExlRE2jfuS8EG3TBZ1D3uWuUnhnX5bzeSwQlsrKt/MOGsOgCUbN+2xH2J47XcSpIJxgWFNNdpSjn7hs+Llx9zJd/j3AiUG+Pm84QlWeGIKq/a7kaherLCwowtdeVGswJ71g19hKzRvR/G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA7wXFxe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA7wXFxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EE8C4CEF1;
	Sat, 31 Jan 2026 19:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769888510;
	bh=Lni0/9CHbjEMqtpfuZwpe7kNBiN1clVWOsovCwhBxjQ=;
	h=From:To:Cc:Subject:Date:From;
	b=LA7wXFxe4H6NpXWZXW19T7QuVddWQh/1KQZfPkOcngYhzqAJgib5hqcQ/WpZTeBLS
	 rHrzj8264fZocWwS8Xm9A/M8j8UMHBw9UmcMTGcO8Cp6XznEfVBFyNRCADxKJZo+Ov
	 LhyVTiIAghQqBJadr6a9Mluyk6lB6/O0GZSf/rfnyu7f1if1/9ZSPsFOP/2GJdpIof
	 +hFMqutJPTOkctSZnQtrEEBY6obeEXik16eIirkj271Aco1br/dCx5DU3oXVHMSp9P
	 qr9qYal/agW/obRuv4Dcttajw5+8p81+2BhVQnbAfGcZkFL7kC6T5tMJxXRvnCkvbZ
	 CH3q2Et+JnDCw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/2] mm/damon/core: improve DAMOS quota efficiency for core layer filters
Date: Sat, 31 Jan 2026 11:41:41 -0800
Message-ID: <20260131194145.66286-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve two below problematic behaviors of DAMOS that makes it less
efficient when core layer filters are used.

DAMOS generates the under-quota regions prioritization-purpose access
temperature histogram [1] with only the scheme target access pattern.
The DAMOS filters are ignored on the histogram, and this can result in
the scheme not applied to eligible regions.  For working around this,
users had to use separate DAMON contexts.  The memory tiering approaches
are such examples.

DAMOS splits regions that intersect with address filters, so that only
filtered-out part of the region is skipped.  But, the implementation is
skipping the other part of the region that is not filtered out, too.  As
a result, DAMOS can work slower than expected.

Improve the two inefficient behaviors with two patches, respectively.
Read the patches for more details about the problem and how those are
fixed.

[1] "Prioritization" section of Documentation/mm/damon/design.rst

SeongJae Park (2):
  mm/damon/core: set quota-score histogram with core filters
  mm/damon/core: do non-safe region walk on kdamond_apply_schemes()

 mm/damon/core.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)


base-commit: ae5fb88b410209639b49d5d271809fdb614df91f
-- 
2.47.3
