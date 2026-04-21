Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C926ACC;
	Tue, 21 Apr 2026 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776746985; cv=none; b=A0fxDs8K9NobYc6w4rQiQXVYWfxsuGVTB6PdMIUzfZ1/D9OQbosSfcAnNvug+yAWF6XWhErQEkMhfx6hqFEFzlsniXhneDEgh3n9HD4cwaI4GFkuJ4erqHwmixbK4mDOMd6vy6IgqIJ2KEe4P3AJzcyqcU28vuiQDpi5YKFnMEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776746985; c=relaxed/simple;
	bh=/7YRpBxxWTP/yjaBm581Uag7GQgE9REjtg9mq3Bzdu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YlK40RLUpi6sU6fNr5I8a8Usz1PbMc791Lbb0ar/y/N/dDyAg10vffYub0l3+EEp+7dU3HdjRI80h/+q0eQkTms6gboy7vGrgMD4zhdGENXUwgKYoCpvqJrJdkTT4JsniCR15yMBprYOZk4oaMebPCfhAxRYDr2WPu5v9ktIk2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoN5bv5m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoN5bv5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B859C2BCB0;
	Tue, 21 Apr 2026 04:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776746984;
	bh=/7YRpBxxWTP/yjaBm581Uag7GQgE9REjtg9mq3Bzdu0=;
	h=From:To:Cc:Subject:Date:From;
	b=EoN5bv5mUda9H8D5jj2fFWRQOwMnf8esdfIh7gyJvr8yMm0hrLkf1Gymu75Lokq4M
	 4+SLnIbx8uI/5yYZNaNVouMMkY/AiMghZP4WdTxQhUPT3ObKE13O1CV7xO+CT2bkKy
	 WDhee5ZJzSv90lINkuWv+Vrqzj/tgePq1FrofnDmYzd0WU4sDfkwSMdqYegBM7S9IU
	 G5zP47aGFi2FG0weTTZUQ6dJh46E1/3F4OiHXs5DOi/OdblmbGkKSujXSvZRlHKyxt
	 YpBur7z98ZI1iHohsM2NEqOzvRg1rkLaYBkYSJxTWEGpArfAK9VEGt024w/QZSyT5L
	 YGTT200D9vKMg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [RFC PATCH 0/2] mm/damon/sysfs: document filters/ directory as deprecated
Date: Mon, 20 Apr 2026 21:49:25 -0700
Message-ID: <20260421044928.141388-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ab71d2d30121 ("mm/damon/sysfs-schemes: let
damon_sysfs_scheme_set_filters() be used for different named
directories") introduced alternatives of 'filters' directory, namely
core_filters/ and 'ops_filters/ directories.  Now the alternatives are
well stabilized and ready for all users.  All filters/ directory use
cases are expected to be able to be migrated to the alternatives.  An
LTS kernel having the alternatives, namely 6.18.y, is also released.
Existence of filters/ directory is only confusing.

It would be better not immediately removing the directory, though.
There could be users that need time before migrating to the
alternatives. There might be unexpected use cases that the alternatives
cannot support.  Doing the deprecation step by step across multiple
years like DAMON debugfs deprecation would be safer.  Start the
deprecation changes by announcing the deprecation on the documents.

Every year, one more action for completely removing the directory will
be followed, like DAMON debugfs deprecation did.  Following yearly
actions are currently expected.  In 2027, deprecation warning kernel
messages will be printed once, for use of filters/ directory.  In 2028,
filters/ directory will be renamed to filters_DEPRECATED/.  In 2029,
filters_DEPRECATED/ directory will be removed.

SeongJae Park (2):
  Docs/admin-guide/mm/damon/usage: mark scheme filters sysfs dir as
    deprecated
  Docs/ABI/damon: mark schemes/<S>/filters/ deprecated

 .../ABI/testing/sysfs-kernel-mm-damon         | 62 ++++++++++---------
 Documentation/admin-guide/mm/damon/usage.rst  |  7 ++-
 2 files changed, 38 insertions(+), 31 deletions(-)


base-commit: 68f9cad2eca9a05a70ec47a90f2ae97aa2363a9c
-- 
2.47.3
