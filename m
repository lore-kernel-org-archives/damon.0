Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10732135BB;
	Thu, 20 Feb 2025 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080114; cv=none; b=gATHT3EVrjhB4k9V1+YJOj+9nrKmURs+dWqzZQGQoHP2em7CFWj+0oekYAKPrArz/m1mNVW7OnnXsJ7h8I9WmZxI3VEXP6rrSloZGgWduxvlkpsR86jqZEhHGhyTb+NpFCTdhXumAtqrG8rQvEB13gpqsOmInX5naLmLYilR/Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080114; c=relaxed/simple;
	bh=yi3O8IIfMq3Lsu5eEmUuglusvyN/6eeaRwtU83MpkKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g12rn7ufRln6LFpd3J/HZe83EXPjF+O3o/6FkE0PYIbm2LHiKx4xeMs7P7IWIlkI7ZYLrGWuVHUrLTaUmYiqRXJl5lbxhbMxoPTjgdAd2mlSr8Z7QzImg8AQwxymakZsTM3rZMg3zRsP0OQLwk/ZP8Z9JgAKU0U7x8kDj1oMxzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFb75Kn8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFb75Kn8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0A7C4CED1;
	Thu, 20 Feb 2025 19:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080114;
	bh=yi3O8IIfMq3Lsu5eEmUuglusvyN/6eeaRwtU83MpkKs=;
	h=From:To:Cc:Subject:Date:From;
	b=XFb75Kn8ByovWtzTkt2RAWuqxhlOEd8p4kzabpZXtM8AnGswfeQ5XhucPLLGOiRFZ
	 gwaoqSr2szYfURtJWDFJtJJFbjmGFJqOaKJS1sRSt21O4os3Jmo8G0DjQqKwyY6d7k
	 8uvqkNsPKahsi9bSAah2MHxqhiMyIjzfDAU04xZg3ePC5iUP3q3uWGjgbExdhXoJJe
	 2XG9471u/hcCBoGxFm1dutOz0DcFP/6QQgr7JiHCreF7iOZbScRz5JdOkNGn5ZrmLV
	 1EHrMYNm0lmZN3A1je/OvL0Obea+iWEKGVUAwHDbldg/eoRrusqZvBuO8mvw9Pi9TL
	 u+Xgcwy0Rf4VA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/9] mm/damon: make allow filters after reject filters useful and intuitive
Date: Thu, 20 Feb 2025 11:35:00 -0800
Message-Id: <20250220193509.36379-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filters do allow or reject elements of memory for given DAMOS
action only if those match the filter criterias.  For elements that
don't match any DAMOS filter, 'allowing' is the default behavior.  This
makes 'allow DAMOS filters' that don't have any 'reject DAMOS filter'
after them meaningless sources of overhead.  The decision was made to
keep the behavior consistent with before-allow filter behavior.  This,
however, only makes usage of DAMOS filters confusing and inefficient.
There is an apparently more intuitive behavior for the case.  If there
is no filter at all or the last filter is a reject filter, allowing by
default.

Update the filtering logic to work in the way.  Decide the default
behavior as the opposite of the last isntalled filter.  If it is an
allow filter, reject by default.  If it is a reject filter or no filter
is installed at all, allow by default.

Note that this is changing the old behavior.  But the old behavior for
the problematic filter installation was definitely confusing,
inefficient and anyway useless.  Also, the behavior has relatively
recently introduced.  It is difficult to anticipate any user that
depends on the behavior.  Hence this is not a user-breaking behavior
change but an obvious improvement.

SeongJae Park (9):
  mm/damon/core: introduce damos->ops_filters
  mm/damon/paddr: support ops_filters
  mm/damon/core: support committing ops_filters
  mm/damon/core: put ops-handled filters to damos->ops_filters
  mm/damon/paddr: support only ops_filters
  mm/damon: add default allow/reject behavior fields to struct damos
  mm/damon/core: set damos_filter default allowance behavior based on
    installed filters
  mm/damon/paddr: respect ops_filters_default_reject
  Docs/mm/damon/design: update for changed filter-default behavior

 Documentation/mm/damon/design.rst | 10 ++--
 include/linux/damon.h             | 11 ++++
 mm/damon/core.c                   | 87 +++++++++++++++++++++++++++++--
 mm/damon/paddr.c                  |  8 +--
 4 files changed, 102 insertions(+), 14 deletions(-)


base-commit: 3fb99e5d512f03963c91926628fcc08a96ee07f0
-- 
2.39.5
