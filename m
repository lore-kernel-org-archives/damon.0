Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AC81E47DA;
	Wed,  1 Jan 2025 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735767341; cv=none; b=kMbgeHWNiKLe5hp4uPxrlO7AHTfh5Be/xC3UL5jrCbzJRUeKDLSZtjphv/qgXxY4XQpTdt98y6Vql5hSGdY2RkXeAfOVpoG5/Q8Z4pw6Ax8WhzAr3eE69nqJrIKS3JQypFK1ariO4Kzpd9ybtAjMGa7IZjXrxL92YSCv9qkFkiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735767341; c=relaxed/simple;
	bh=oYXb5ELfdFSBlBTaf0WAv5hcBOQ7eaf8Vl277fIm8X4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QjgflK+LIy30brNjWcLSGIjSWFu1wDgLxO0+O+gP5HybEvb0fcvTi9Wqd8uUtK8tOzbuS3PUsR4WkkuRO0C6JG/478K3fIoEGcOeBKgPLiK0qH71PNK9jrUrUY/FHrO1MW9ZauNgBXYn1nZW0NIz/+qcSojQZ/Ehf5kT+Jsfczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpPLu6tk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpPLu6tk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DCFC4CED1;
	Wed,  1 Jan 2025 21:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735767341;
	bh=oYXb5ELfdFSBlBTaf0WAv5hcBOQ7eaf8Vl277fIm8X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VpPLu6tk+FSwnEVbf3Juhf/zurRUyjUgEr24z5hMcl6sUkAjUmufvG4Pt01iUg3u1
	 n72VdG7VEuU1MQFiNPDDjCbstHcgpW0Yakbn/CMOQGq1gxslVTWK6q8uvS+njZjKfT
	 ZHjttutl+8CMjnYidN/xNhmnZIK1vWjqUK+PR6NlDJjiphN5lTx+VUnCSzyL4aZ8oM
	 cMRdTYqUduw6v9XnK6C06rbyZNoblNMd+w03P2gUlXwS/cJzJWvCbL+iE6o1sDSuD1
	 O88W9U3tISS2ZmJj3RgBI/M8A5gFWmEZJeCcvPzytqldSodfvO35wDLoIu9lw6s3Hv
	 4m7t3mKW87W0g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/7] kunit: configs: remove configs for DAMON debugfs interface tests
Date: Wed,  1 Jan 2025 13:35:25 -0800
Message-Id: <20250101213527.74203-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250101213527.74203-1-sj@kernel.org>
References: <20250101213527.74203-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's time to remove DAMON debugfs interface, which has deprecated long
before in February 2023.  Read the cover letter of this patch series for
more details.

Remove kernel configs for running DAMON debugfs interface kunit tests
from the kunit all_tests configuration, to prevent unnecessary noises
from tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/kunit/configs/all_tests.config | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index b3b00269a52a..b0049be00c70 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -38,9 +38,6 @@ CONFIG_IWLWIFI=y
 CONFIG_DAMON=y
 CONFIG_DAMON_VADDR=y
 CONFIG_DAMON_PADDR=y
-CONFIG_DEBUG_FS=y
-CONFIG_DAMON_DBGFS=y
-CONFIG_DAMON_DBGFS_DEPRECATED=y
 
 CONFIG_REGMAP_BUILD=y
 
-- 
2.39.5
