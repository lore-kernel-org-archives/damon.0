Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC192382369;
	Mon, 23 Mar 2026 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307744; cv=none; b=s0FvChXf5GMumEYstITZ29BB3A2FBGSGI0rPvKvHd80USRUG2GFPZFprVc2NYGAXJQBp6ekd3LUkhhUptmLrOiPuFCxILbLMRKUsy7XURngvgLTP2Kh5xVjOjG+cSY4as7VJFW8R3SKHZKZzjZaHc67uvmMqTJkLpAo9jCzh0Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307744; c=relaxed/simple;
	bh=9O26QoN+V9tNeSexEgjKx5Rwm+ySmwIIy3Pdsz7ovf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+zpK+z4Ftu+1ndkQCsa95eHc6kBCXGaV0czZhiQCoZFJyCX5K1jWGoVfJvFK3qzVSJnzqnPnvfs2RMUhXQopQanFHiJiMcftDHrF7ZwudRUOhb9nzx2HaJBtpRxrsFxmgvJK2RaiKPlKgBRqOhn7HlYFQaTxGwsy+SSI8CNLOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQ3wtS4V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQ3wtS4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B5FC4CEF7;
	Mon, 23 Mar 2026 23:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774307744;
	bh=9O26QoN+V9tNeSexEgjKx5Rwm+ySmwIIy3Pdsz7ovf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NQ3wtS4VHYPZf66jO1csQvp/LpE0Ybl8w5Hd466GHvql3tGqyF+A5aWR7fuXZgxQ1
	 ThbRkyMmVCeDuYOQzSJynT4T1Dk49A2ePSevU4ezpCk79vD3QjdVPbIMLoskqDibj6
	 15pxS4BxUZ22m77hfPXgBUV/ySrdFqNNAobvLzbmCeAzYA60umafO8Bx2Rt0Z5batU
	 gL8YysbsUrtKBJszNQ4AZMbR8fYelrEXd5LOnA+M1yx8AiAwQ5UvVQ71iyVDi0pVXr
	 yP5/R3F0jzixczBsV2atHVSqka9fnMCY59M3xMVdRobs6otmCQUlwQxBV7IpDAdQcb
	 R8bAJGnnI1HXg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 08/10] selftests/damon/drgn_dump_damon_status: dump pause
Date: Mon, 23 Mar 2026 16:15:33 -0700
Message-ID: <20260323231538.84452-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323231538.84452-1-sj@kernel.org>
References: <20260323231538.84452-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drgn_dump_damon_status is not dumping the damon_ctx->pause parameter
value, so it cannot be tested.  Dump it for future tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/drgn_dump_damon_status.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index af99b07a4f565..5b90eb8e7ef88 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -200,6 +200,7 @@ def damon_ctx_to_dict(ctx):
         ['attrs', attrs_to_dict],
         ['adaptive_targets', targets_to_list],
         ['schemes', schemes_to_list],
+        ['pause', bool],
         ])
 
 def main():
-- 
2.47.3
