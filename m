Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A615A94C
	for <damon@lists.linux.dev>; Tue, 10 Jan 2023 19:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBFCC433F0;
	Tue, 10 Jan 2023 19:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673377449;
	bh=CjhxKTgVu+lPp4HMYYUYnXVejaSmINVAMJdDe1Xu9yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9iw2rZ6IgCzqVQBdYfz7/bh7pKhBy1FK+wxTqUl4jmsut3RCJjFMQ1iXDcc3yG3g
	 ubQRNrcDKuML+gAAHhG/o2oIDoU0TNhHHsHQytYLNAHxwWHfHNvbtBi9ytfESI4MnH
	 jphspOWxy3DGuZw7GJ9uRW1Vge4F5VWvuzH2dw3zS4uPT/Qm6JaveOZol+/Qmximra
	 z0bItMD2PlFtwfc92SGvmZTfoLuPUjMbiUV5pdVgi64g2QU+GBFxkDLhZH8tCZZn/u
	 55l2ZlUFIEAZtEMyfMhDiv4kJAus9+cQjzHXnbUXQoiiYsN4VQZjLPdrXhoaGy9nkw
	 puw4xPVZ3JB6Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] selftests/damon/debugfs_rm_non_contexts: hide expected write error messages
Date: Tue, 10 Jan 2023 19:04:00 +0000
Message-Id: <20230110190400.119388-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110190400.119388-1-sj@kernel.org>
References: <20230110190400.119388-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A selftest case for DAMON debugfs interface has a test for expected
failure.  To make the test output clean, hide the expected failure error
message.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh b/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
index 48b7af6b022c..f3ffeb1343cf 100644
--- a/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
+++ b/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
@@ -10,7 +10,7 @@ dmesg -C
 
 for file in "$DBGFS/"*
 do
-	echo "$(basename "$f")" > "$DBGFS/rm_contexts"
+	(echo "$(basename "$f")" > "$DBGFS/rm_contexts") &> /dev/null
 	if dmesg | grep -q BUG
 	then
 		dmesg
-- 
2.25.1

