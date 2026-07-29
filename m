Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299AD4ADD86;
	Wed, 29 Jul 2026 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333786; cv=none; b=PhdtRLUnqeckY4Oi8Oh36VxQF/+8he2m7pYzHYYPvk+qJvg8rE96EkEgUx3kYTTK3kD21PNuxYBF92j7TB+/nJp78zQYQsPqS/Fjj/MSOeXtP3vhpjXNEHNAqmcUF/RpVTpm5Jf9Qa2pXpPmVqYIZQZd4Du8GbAHnEBAlFiN9h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333786; c=relaxed/simple;
	bh=YW9DG1nZbqz5zSzS0lvJDBQ6Z6KLAhpeL+KT/SDAr08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6eVJJ+SnrmxCpP98wXws1JgcCDDvkZOqNuI6gFS25a2SI2WQqlXtBWKWXGmDwmmB9HMyjTjqGKpsiaMpsh11SlMea/4R9OdBuxdBwp68Prw8ZrxSXon7TunoTOxERQaNijAWmF5mx3L5ppTP4voCmwBi+tQXXfZmobjYIc5YhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpIvLMu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpIvLMu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70501F00ADB;
	Wed, 29 Jul 2026 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785333784;
	bh=5RGW5tJfMQBefLVNsm8C6YsUWIxBGgWh+NafBLNk5T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HpIvLMu06HaC3elJiA6elITNOECKamcFBJpfVoSh08FOPfmpxN8xc21ZD6A3Ahxu9
	 s7LS221fZuYRTuU+Q23Wr+SqKtC75632WqH/0WeHS+kLgzlxNBoTyKv+hM3g0CGqOk
	 f6Z0e0ubybTkVIV5NPIdVEDvhHrxXt41nuL5yA/OmzqOWYhPWUW4xfV0G4CyzXVk0U
	 OU+LYVwOGgm99t/yxvA4xNMnm7vcyK2kF8M8TAt5eObBZDzmKN7NODoVvIRl1vJ6rn
	 6wQkQJvqnBbyS4W6/YXDZqjOg4upSRFgCxRRdfiqUkieelrmRja9MOdjIw0GH3y7Ur
	 MTy7MpyEGP0Dw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 05/12] mm/damon/sysfs: remove probes number validation
Date: Wed, 29 Jul 2026 07:02:45 -0700
Message-ID: <20260729140253.87753-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729140253.87753-1-sj@kernel.org>
References: <20260729140253.87753-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface is disallowing >DAMON_MAX_PROBES nr_probes input,
since DAMON_MAX_PROBES is the upper limit of probes per DAMON context.
The core layer is validating the upper limit again, though.  It is
preferred to let DAMON API callers such as sysfs interface to set
parameters in flexible ways, and do parameters validation in the core
layer.  Drop the duplicated validation in the sysfs interface.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index d02f5f8ceae5b..8abda69c98dd1 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1477,7 +1477,7 @@ static ssize_t nr_probes_store(struct kobject *kobj,
 
 	if (err)
 		return err;
-	if (nr < 0 || nr > DAMON_MAX_PROBES)
+	if (nr < 0)
 		return -EINVAL;
 
 	probes = container_of(kobj, struct damon_sysfs_probes, kobj);
-- 
2.47.3
