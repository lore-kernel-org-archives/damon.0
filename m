Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C415D12B65
	for <damon@lists.linux.dev>; Wed,  2 Aug 2023 21:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C40C433CB;
	Wed,  2 Aug 2023 21:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691011949;
	bh=T0fZGypLM6vPpWaOxwTR4DXjjDDCiOe0tcjb/Q7FYeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B8eKOqA044Ky8Eh09y4gIXYN9t2lUUZCL9kmmIy/8/wVup+Fz9JompcEKnQSE4jKf
	 rNdmcJT9xd0IfodlTlcndLvX2Na6sPx1JbT9RuOE/wx2KM4b7YbEGyLkffuSceZ+Bc
	 /l2rcKJrVQGxQRjm7e7wQ/sOIx8A2X90cgjvwQ9FEMNRdzU9EZEC7larfDkW0RmVUa
	 EFomDu/3WBUrWr6v4wEUKLbqIRHSxfQoDfMG2TqcAFphcofllNeSdaHPsefS/bArI+
	 SqYi4oXNcrkHbCEbhjQOaUDlg/0qyd4dBsqQHZEM9pIX8GCakb9VXQJvvEx/nNj81F
	 BQ+3vr2RfZiuw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] selftests/damon/sysfs: test tried_regions/total_bytes file
Date: Wed,  2 Aug 2023 21:32:19 +0000
Message-Id: <20230802213222.109841-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802213222.109841-1-sj@kernel.org>
References: <20230802213222.109841-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update sysfs.sh DAMON selftest for checking existence of 'total_bytes'
file under the 'tried_regions' directory of DAMON sysfs interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index bcd4734ca094..967e27267549 100644
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -84,6 +84,7 @@ test_tried_regions()
 {
 	tried_regions_dir=$1
 	ensure_dir "$tried_regions_dir" "exist"
+	ensure_file "$tried_regions_dir/total_bytes" "exist" "400"
 }
 
 test_stats()
-- 
2.25.1

