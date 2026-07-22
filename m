Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134AD293B75
	for <damon@lists.linux.dev>; Wed, 22 Jul 2026 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727515; cv=none; b=RCHIRvGNMV60qEOGuqyIAP8VmTHajXsPNxveFLzI9qzuNs9KtAWXcZe4nVf2B2ey5GnKmiPO1x9OeYvUCGVZbQOe8RLVz/Guv+YmcfWIP3NcONYPivJllOkgTo3P01BOEbiwx/yeZFCqcKGcavpsLWZ7VZXAddDgQmd8jeOxs58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727515; c=relaxed/simple;
	bh=lCQO2iGtVXUjFvjAVUroqZpQYZ5yDcwk+Bhgv3euApo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aL8ZFYNuN5FO8j8uvDyDyAYkqfb6fbdqCkUWD7CO0cI/YT2Nnf5tUD7ltM8XeljzwTTT750MMLicPSM6Gmj2Ok53CVX1dpzsemQ7q9AMoCdf9tc0Xf62H7y7xabvjUe0pj+/FSj/J0s4C0qC69i7QypqbAKIf59yFTs9X5DZu68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dybn4hLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dybn4hLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875E21F00A3A;
	Wed, 22 Jul 2026 13:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784727513;
	bh=wgxG0hSXz8eM72e9d+/2o+/1h8HJ7KuOQW424JYhn0A=;
	h=From:To:Cc:Subject:Date;
	b=dybn4hLm6M5rNkCYTJK8xivHOrhdG+MQwIjAR7E/4sZI/3aMPsIfXjUgkQr5xhK2x
	 FYo6k8GS5BEbHjVcSS6bPfKsuZNI4qKtAm+s/NYqN+QjwoVpyEmMJBeRLk11r9/1dz
	 +pqYsxZZ2aXFwsW9nbJEFdn5p56HM3qotuF+D02gkxdpaxtfKMYk0VI4+Q1qA7RN7v
	 RzdKpKFCmjRvHYEVaRjaBTH8tSloM7fwu2ztPr27dg3qhAgsWGIk2HOw9DLq1Ovr7A
	 j8cbLulatiqN1ufbBxdrLYlZzQ8V2ZdKlkTBfoFIxdIimxIA89KijAK2oRS9QYL1z4
	 ocZhYyRkUXUIw==
From: SJ Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.kernel.org
Subject: Normal DAMON patches will stay in damon/next until 7.3-rc1
Date: Wed, 22 Jul 2026 06:38:28 -0700
Message-ID: <20260722133829.87607-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello DAMON community,


mm.git [1] will accept only urgent patches [2] until 7.3-rc1 for focusing on
stabilizing things.  To help that, I will also not additionally request merge
of DAMON patches to mm.git maintainer (Andrew), unless it looks exceptionally
urgent, until 7.3-rc1.

No real change to contributors.  Please feel free to keep posting patches.  I
will keep reviewing those and add them to the damon/next [1] tree.  And same to
our previous workflow, I will ask Andrew to merge that into mm.git unless he
does that first.  Just one change is that, I was giving time for Andrew to pick
that himself first for a few days.  I will give the time until 7.3-rc1 from
now. The time window will go back to a few days after 7.3-rc1 is released.

If you think your changes need to be merged into 7.2 rather than 7.3, please
feel free to let me know or escalate to Andrew if I'm not useful.

[1] https://docs.kernel.org/mm/damon/maintainer-profile.html#scm-trees
[2] https://lore.kernel.org/20260721225139.fd654a3a40e755d3e621899d@linux-foundation.org


Thanks,
SJ
