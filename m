Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798461BB2D
	for <damon@lists.linux.dev>; Fri, 28 Jul 2023 20:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C1FC433C7;
	Fri, 28 Jul 2023 20:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690576495;
	bh=MiKQzUem1fzoQJpnZETahxS4bhAx7AKf5JO3KUUBnl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EECfAg33GG9SqqlWc+wrfsEImXkF6d6ycMp0inrJhToqWOJS5w+mziQY6qM1+VzOW
	 yJAIbvcLzdspQMARFZjzy3AmCo6BqmfM3NWAvL0pkpWx7Yt6sRBXwoVkE5fusXqmub
	 w5oLIoINT3xsuDNIolN8nJBcIRzbtGocgGMwepvXDhuG2FYfsA9T8hDMGzLkIvm22b
	 FoyimEg865ElGcknEIKuhd5UsKo6vGoFtEtm1IFw/No6ZJIxShh4HmDL7Oe645TXVZ
	 Lrkivg25m27CUtgTcmVblB1UPsAmTCbpO+ItKQ5IVNkZpQ7/X7HRuBHnbgzbf/ZajY
	 NNTeUXrLf0J4w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 10/13] selftests/damon/sysfs: test damon_target filter
Date: Fri, 28 Jul 2023 20:34:41 +0000
Message-Id: <20230728203444.70703-11-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728203444.70703-1-sj@kernel.org>
References: <20230728203444.70703-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test existence of files and validity of input keyword for DAMON
monitoring target based DAMOS filter on DAMON sysfs interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 5677cfd342fc..60a9a305aef0 100644
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -104,11 +104,13 @@ test_filter()
 	ensure_write_succ "$filter_dir/type" "anon" "valid input"
 	ensure_write_succ "$filter_dir/type" "memcg" "valid input"
 	ensure_write_succ "$filter_dir/type" "addr" "valid input"
+	ensure_write_succ "$filter_dir/type" "target" "valid input"
 	ensure_write_fail "$filter_dir/type" "foo" "invalid input"
 	ensure_file "$filter_dir/matching" "exist" "600"
 	ensure_file "$filter_dir/memcg_path" "exist" "600"
 	ensure_file "$filter_dir/addr_start" "exist" "600"
 	ensure_file "$filter_dir/addr_end" "exist" "600"
+	ensure_file "$filter_dir/damon_target_idx" "exist" "600"
 }
 
 test_filters()
-- 
2.25.1

