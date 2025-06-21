Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42A266B72;
	Sat, 21 Jun 2025 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750527094; cv=none; b=M1qJiZsSD/Ozt1o+AAbIVU/UcOV9QpoQT0sSkYZwDHjRC9DXxlIhf33V44p6td1mqAOhmf69nh6CdvzGcoAASCcRAYDrj/YbNh5Bjd2ocKfnUHbNUygoAUejDeHHpbKr+oHw+ir7JDTVkt0mf5IWjD6FXXSDWhS+lBIUHhsK/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750527094; c=relaxed/simple;
	bh=LyaXlSs9RrVVKCP4JaKYe1e5Ifb30ePAg7oD3vlg6Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JcrObkKGW6QwjgAiPWvpltPilb0f036G8yQeyctaKClYodtL9o9UBWjFPH8q5cnSTbNnSRD+wE03Gi7i9NLdAFFLvqRsSqaxTpHWMnEkPhoNdPNtNGko9P+lSqikR/mBTI2IHDuQTKQkw0Ky04MH+EdRjGhaSCdOP1yDfw7wNlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdQXEJgD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdQXEJgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD52C4CEEE;
	Sat, 21 Jun 2025 17:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750527094;
	bh=LyaXlSs9RrVVKCP4JaKYe1e5Ifb30ePAg7oD3vlg6Ok=;
	h=From:To:Cc:Subject:Date:From;
	b=EdQXEJgD+JdDPQ6kkL+j6/hDhTlW/hAvrUYc1SWSVQ5bK+GbjCNmO3OnTxiDChvNH
	 9K4HYEOLxTY/A9jayD3/dhUmuiohJ1eD9o3PeBp/R95sbkfnxEB0FvGS7DlCsGXev/
	 QYD+TB11EhtH3C8jWiEIyz9Rc5ed9XHFk5N1iB2QZh1OIouXhOOnsLB3iPfEwcl4Hw
	 XYUF5VupdYwwTQGY5sB21i9UGKTsuJFhsDqxJV4HPCwd3ZymSzELUcxeDRWh68Cvbk
	 e4xCmRmkRn2WLFAq+zVqfVwfKHpGBsbTplmwQe532MX4S65FBqXHd3JPqJ606nB4Gc
	 kZ1SpYf15dlww==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/4] mm/damon: add DAMOS_MIGRATE_{HOT,COLD} destination nodes and weights
Date: Sat, 21 Jun 2025 10:31:27 -0700
Message-Id: <20250621173131.23917-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS_MIGRATE_{HOT,COLD} action can migrate pages to only single node.
It could be useful to allow it migrates pages to multiple nodes with
different weights.  A work for dynamic interleaving[1] is in progress.
We also discussed this could be useful for memory tiering, e.g., when we
want to move pages to multiple noes of same tier.

Extend the API and ABI interface for specifying the multiple destination
nodes and their weights.

Note that this RFC is a prototype of the interface change for Bijan's
interleaving work[1].  Hence this patch series is only implementing the
interface part, not the real implementation of the migration behavior.

[1] https://lore.kernel.org/20250620180458.5041-1-bijan311@gmail.com
[2] https://lore.kernel.org/20240408175228.91414-1-sj@kernel.org

SeongJae Park (4):
  mm/damon: add struct damos_migrate_dest
  mm/damon/core: add damos->migrate_dest field
  mm/damon/sysfs-schemes: implement DAMOS action destinations directory
  mm/damon/sysfs-schemes: set damos->migrate_dest

 include/linux/damon.h    |  29 ++++-
 mm/damon/core.c          |   4 +
 mm/damon/sysfs-schemes.c | 253 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 282 insertions(+), 4 deletions(-)


base-commit: 78745efafbb93197e476717385616ed57ea2df22
-- 
2.39.5
