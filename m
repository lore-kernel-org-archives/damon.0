Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538DF388E40;
	Thu, 21 May 2026 03:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335647; cv=none; b=WNHUCW8PSwJaIl4WdzJoBZ+RtuSAI+D+m3UEgY5y0rDxVlxAymgjLr1C9dLjz85L7Wj6bAxzGut8Ea8aMM9MC8FSTjan2iQuhu00ghxvaBBNkSW906xWxoi/YQLBLEd7kTRKT+bHIkftxuRsFTFZLvR0azV3zVLtZWRZTy//6Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335647; c=relaxed/simple;
	bh=vlSxJq/mZG/PC7FG4BVhxJBrns4C2X+9/1QoBF2tbHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njlpJNGc45M4OEkzZZtChJoNYIsKTn5Bw32wj1YAY6STJZPjmOwStr84ubkGsN5d2UmuJXdS9mwnuOTwb+e6OYS7/TicxJiu6QmV/mtxXxf040x+jNnytrGir3v9VmhkY5dFJacCFWDkl20LpZq3XzZtL2NqIOnjQIOhjG8FR5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkR1vu+3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkR1vu+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F741F00ADE;
	Thu, 21 May 2026 03:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779335645;
	bh=9Q+fxjZuCnosHblIbwlECkpSubPFTTaxfUpkwZ9ZxQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PkR1vu+3aRcBKH3ROFFcXnfnFaEUHaQnqfOb79thz1yVdKKJZS970IEJnfnJnS0Om
	 dsbNih39v3N4Ejs76zJpSpmO3bsoNfNXWVqJu11et0DoJBZL9UoN2+RysPyEMIAGfB
	 HUMAIDaI8MobvdhIPLZPJqzliNLl2TT6T2i+qdkp2ol2+w7mc/rkY5U1l98Qs/vi+I
	 VYxx9xG8FT+0ppyYjWJ/j8o5ZmYEGd4Vy6lgRinjXLJ5WxYOXxJM4znpC4JiBkVjB5
	 Xe8jEizUZ3C4EqQGepZmFNsUHV8xrvKOLA3btRC15DMfPR9j2YSMC2Nd3hOXcgIk2L
	 fAK8oO8Rd76HA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 14/14] selftests/damon/sysfs.sh: test pause file existence
Date: Wed, 20 May 2026 20:53:48 -0700
Message-ID: <20260521035349.87565-15-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521035349.87565-1-sj@kernel.org>
References: <20260521035349.87565-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs.sh DAMON selftest is not testing the existence of the 'pause'
sysfs file.  Add the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 92b44c86818af..78f4badb5bebb 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -366,6 +366,7 @@ test_context()
 	ensure_file "$context_dir/avail_operations" "exit" 400
 	ensure_file "$context_dir/operations" "exist" 600
 	ensure_file "$context_dir/addr_unit" "exist" 600
+	ensure_file "$context_dir/pause" "exist" 600
 	test_monitoring_attrs "$context_dir/monitoring_attrs"
 	test_targets "$context_dir/targets"
 	test_schemes "$context_dir/schemes"
-- 
2.47.3
