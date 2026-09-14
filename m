Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99109481657;
	Mon, 14 Sep 2026 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397103; cv=none; b=Akil0weUOX5jeATTpKl0xlirpEuBSRElVm8uZqxDaLcO3BYXd2y2Z9VGiX6kPpRmvHj7xzY5Ud8GyjMswg7uXlp/KLF2MzFhm0W5fg00oiOjQCkIl136mH41jieUg5qeJaU523wAfBVuXF+eB7XQqHA3pD6frzzFhKc6Eb2Sh9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397103; c=relaxed/simple;
	bh=hGYrlp8BUYEplerJ3NeTyfTllMHPJtU0fdxbw3cZ6Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIFbptFWwJUwWfwqe24IPHFlMqaxMps1kbzkVCpUITqI1pJdBMu6CVN0YvmGY8iE5k+YhtU+uPks4Ekl2vFOaq4oX6SUw94UC0zhRlkRSbSUFGI2bAUpQRgVGuCydbbiWWmRCaa4Ar4+bU9PCaDeV2FtKtraTS2jV3RxTTp9OCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqRA3QNb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqRA3QNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39A71F0089C;
	Mon, 14 Sep 2026 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397097;
	bh=Gmq/rX+sVM9Hs+BxObGYka5NbSCER5H2QYTBCAxyvwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bqRA3QNbasQ8DrHsKmqlwy9wG2lT8VVfjg6LzxYxnCX3jh7ux1jsm7Q3hdxxCndDN
	 nHqVED8xcle2ZqP9x1W0BvsO4H99I+BczwrFfpyeY15TFPxR5fzQZ/kG4jwkvfTmJJ
	 k2y4X9yD0jm0BwZXav5SG0fwghFLy4HfYi+TzrjyjqQ6oxyWOMxcpX3xxZtxvOE/PQ
	 NKp47PX10hdYkq6vxLJObHV26mJD9q5gxbTW/dD5I57cCE8Qm3Ba4vb5LqzPVGyxt4
	 NPBT10OFDmsTUbebfyod0oy2e+l9ulAIrrS3XdQIJ5knAVyzeSmpcl6VBu7moGNAI/
	 CIx4KguVr5x9w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 5/8] mm/damon/sysfs: support hugepage_size probe filter
Date: Mon, 14 Sep 2026 07:44:42 -0700
Message-ID: <20260914144448.93732-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914144448.93732-1-sj@kernel.org>
References: <20260914144448.93732-1-sj@kernel.org>
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
