Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401A137FF5C;
	Wed,  4 Mar 2026 04:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772599290; cv=none; b=HCie5BilUSghJrecIvkHcKXUyMk7F7kNZPb54exvVlUSRe0KEehEI1R45IDj2D/z+kulvaI2hAQLLFxZORT1pYbT/hjW0dTh0zxNthETf9E5HN8rwuxD352CBXseOfq1jHEiUbLkoU6oDZA7u+Z5sx7diKsUPX36t3R7Kp+QdPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772599290; c=relaxed/simple;
	bh=pVuHdsiSK2hSc3Y/sliHzMztEBUolq4unjdQPlB02FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9xYz4PcePn4+4ScmuJlCa9JfHc+UTl2UWA+o3DZ7HDsq2LM1bOCRdeSOmLcsPlDalq3PuSveOIu5qYbhPgcyUagKTCsI7I6iZTZckY+G9unLatWIViJs1r/4CfEkr187jVj5cfVdJlBUI2Lx+l0xs1zMJ+H/TGWEs2MoLV+iSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fADf3l+U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fADf3l+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6A9C2BCB0;
	Wed,  4 Mar 2026 04:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772599290;
	bh=pVuHdsiSK2hSc3Y/sliHzMztEBUolq4unjdQPlB02FQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fADf3l+U3piiHRary8J43NRu2XwjdMj3+DnQaO7Rwm8yWFNEOA4fe46nuP/BIK0TS
	 CHN5r7Boc62uCRf3YKpu1nBSXZoSGv9oddF0Pu5MhD1fMct4LrPia73VErPzHrQ1r+
	 0rgE9PYDrOb7UPehZ/sB1jAnp275O14idtv3ZDFnBgyb01JySP1FsI7xebl4YKbpOC
	 WxBBAxeMHsAlRo+7JrdCKCVUPagVPZ2PFpnZhonD20KhC+EyEXCx0+ekePzje8lIJE
	 G+TMUjMwhyaWRI2RqWY2UewFbmRZf3/1KL1OXaLBQYwTU0MASUT3IUE6Kqo9BShBSp
	 RtzOVQcKjebsQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 09/10] selftests/damon/drgn_dump_damon_status: support quota goal_tuner dumping
Date: Tue,  3 Mar 2026 20:41:18 -0800
Message-ID: <20260304044122.79394-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304044122.79394-1-sj@kernel.org>
References: <20260304044122.79394-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update drgn_dump_damon_status.py, which is being used to dump the
in-kernel DAMON status for tests, to dump goal_tuner setup status.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/drgn_dump_damon_status.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index 5374d18d1fa8d..af99b07a4f565 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -110,6 +110,7 @@ def damos_quota_to_dict(quota):
         ['reset_interval', int],
         ['ms', int], ['sz', int],
         ['goals', damos_quota_goals_to_list],
+        ['goal_tuner', int],
         ['esz', int],
         ['weight_sz', int],
         ['weight_nr_accesses', int],
-- 
2.47.3
