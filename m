Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA012F8E9F;
	Sat, 25 Jul 2026 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013356; cv=none; b=kS/G4crIEc/oO72y8avrZ72wVgoFDwxPLsVlVFbzqYS/QK+FjV/6WcwfVBW+ESma8Wbhcy4pU8FKEGS8T4VY0CiVQMtAlc/kv4+bEc0ezvjhsq5pOF0Z3sJASNQJoTZS75w5gYwMJwvtkmdc0rAKr4lkLt29JPbia6zhNWe3XJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013356; c=relaxed/simple;
	bh=o3hI53B8za+nhkok//HqpRTOEsjaqqLqJHmMQj9SDvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qx3iAQFpaoNg9jlA/BxckSMD9XOP+kU6PSqVDQaGp9g5hutS9D8Z0QlPkAZ2wJ/U2ZnJQm6qyjfss3tbKjr/7lQxbL0ABzzKi46iYCVjSPRQawGeqwQu51iARkxvQzcHpSOIT76i/KvLWN6UYErGvbSERZk+N+PV4K6FR8VzqMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr+4WRP7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr+4WRP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB3C1F00A3A;
	Sat, 25 Jul 2026 21:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013355;
	bh=cAfIlLPcU4sckuDrbS7eOEg3BQtpmGkcQ7Y936FLtiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nr+4WRP71qblrm2lUWmqWW6UfL4uqUQ9c9EYhLUD1KyCnVt8pOPocsx9HC2bczb0Z
	 Kmbd5y0UPGxL3ojDrR8JUOWuLRiklD7zy9xCqX6ub/x2Q5uuw1b7iC4LbnSznxllUN
	 Jqv6hcWl95eki2RbEvsWHw7nuHPOQv2MMROMTRJm41CQg3H2EwzEp9l2YhXdQ4RxvJ
	 EB1SyWGhEWbLwyWMch0lyTPelWTaoN6wuvpVJEI3/ShoAOgTjqprtz26eChSKZmCIE
	 elHeYXdGjMcDS7gUri6wRcuLins0HFaTKJcxAH3wejzKrDSe8ufHmjOb2f1WfZWLgI
	 xgyPVHx87kSqg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 03/17] mm/damon/sysfs: support pgidle_unset probe filter type
Date: Sat, 25 Jul 2026 14:02:07 -0700
Message-ID: <20260725210225.129944-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210225.129944-1-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs interface to allow users to set
DAMON_FILTER_TYPE_PGIDLE_UNSET by writing 'pgidle_unset' to the probe
filter type file.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 053ba2e53b969..376c6ecbd4bf3 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -782,6 +782,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_MEMCG,
 		.name = "memcg",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_PGIDLE_UNSET,
+		.name = "pgidle_unset",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
-- 
2.47.3
