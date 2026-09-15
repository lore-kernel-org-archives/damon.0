Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A973921DD;
	Tue, 15 Sep 2026 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438183; cv=none; b=ubHovI53DtAn5JQ13sGq9JPqqxdH8j1TneFKJkQpc2HpHcXreuZ7vjH/av2mw04+BkakucBkTND83CXefSUb1lANQVqnp6Jh08s8Yi1d7AZ318chYX2GZSgmP+9O/zGf6ZvtdPGOegOd7a9GnteGZhgdmkJfSDMLxgxByewBGOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438183; c=relaxed/simple;
	bh=hGYrlp8BUYEplerJ3NeTyfTllMHPJtU0fdxbw3cZ6Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pz9Wf9ZAMQIWKmV8TRg35evyA8kirLT30E4Ba7J2HaLM/0vmfXj/4+EX0mfaiZt97eFZwpwDBhh7ig9D6xbOuiBxaUJFyFfM6ISHzwrk2fYAv/xc8wdDM++hZkE/O0Wn4zaQM3yFr9JnKqPYKO3oDwwJ3jj6+Z0wCyqLBSQMG78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hiyb8acw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hiyb8acw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AD51F0089A;
	Tue, 15 Sep 2026 02:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438179;
	bh=Gmq/rX+sVM9Hs+BxObGYka5NbSCER5H2QYTBCAxyvwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hiyb8acwXAgqxym9KzuWX0MDr2xlqwBXaRVpzjPy+RObadhlgphPAVk3CXx2xBKgS
	 4TocPLG1FHRPYCvsShf4QeSoF21GhvYnqDTW4HqRkOPL/2nKwZ9+krR6p2chCztSqK
	 92TUv82mRYZcUdsDm1c871fRyaUM2/PJ9xReSRwaoo8ZCM0usYTXmkuzI8PT5FV47y
	 4qJP3WMB+gkeNlQxlO98c/NgHWKFtIGSwqKcuoPQqgUjiBiiWeL13QWsU4Q/J7Cgnp
	 iNLf5R57XyJwdt8aocOMHJ1RrlWij0nDLcIqXfGj9Apu98dAw/4rpsz7QGu6BHUTHo
	 JbGkI8CgQ+eyQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 5/8] mm/damon/sysfs: support hugepage_size probe filter
Date: Mon, 14 Sep 2026 19:09:24 -0700
Message-ID: <20260915020929.102953-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915020929.102953-1-sj@kernel.org>
References: <20260915020929.102953-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs interface to support hugepage_size probe filter.
Allows hugepage_size user string input to the filter type file.  Pass
the size range argument that users set via min/max files under the probe
filter directory to the DAMON core.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 8e8d89b8ed981..43519afb9eb7f 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1007,6 +1007,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_PGIDLE_SET,
 		.name = "pgidle_set",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_HUGEPAGE_SIZE,
+		.name = "hugepage_size",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -2273,6 +2277,9 @@ static int damon_sysfs_set_filters(struct damon_probe *probe,
 				damon_destroy_filter(filter);
 				return err;
 			}
+		} else if (filter->type == DAMON_FILTER_TYPE_HUGEPAGE_SIZE) {
+			filter->range_min = sys_filter->range_min;
+			filter->range_max = sys_filter->range_max;
 		}
 		damon_add_filter(probe, filter);
 	}
-- 
2.47.3
