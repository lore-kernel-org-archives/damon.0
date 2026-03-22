Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CBA36999F;
	Sun, 22 Mar 2026 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774195060; cv=none; b=uKQoclbX6rdDYGusip+1julFU/upqQr5XV7TWhwhtBIen1zGP53kkJ9tiSXlNdWWAGFEBtl50uPy2yygZIlWDl/andZ+lBLdi3TeER9nJatvwHTn8lb7xeXrC603eUOTSmEShqsNXeJm0gUWkgyer4BUAov+3o04wumk1relTs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774195060; c=relaxed/simple;
	bh=9O26QoN+V9tNeSexEgjKx5Rwm+ySmwIIy3Pdsz7ovf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXN4xjZrzmgLvbxESnFjT72Y35BD74yJWRF8HjFLaYfXiYRyz8AYrMBhwZBCk3opw/gySP5EJ3MMn9aRrQAOz0CrPbjPQCl+KoTQNOrX13SPWUBDICVqfvhOWynPYeJUEA89fX0hyIK29ARHMG4p2QuyI1b84S/R+tUT1ta87jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/v77JDa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/v77JDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D302C19424;
	Sun, 22 Mar 2026 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774195060;
	bh=9O26QoN+V9tNeSexEgjKx5Rwm+ySmwIIy3Pdsz7ovf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/v77JDa6gOV0lKhY/HqDDAGc1NKfWFTNAZfuguz6CCxPJmvyDQVRt9oFIHTZZr/P
	 vj3HzRacvDG+drDY7jd6OZz7cb52PzTKso4PlOROx9wBAyrX9oforAuK3jXCL1+Cdq
	 G0x1Bjm0b5I8rTP3lSSVGraBs6jZQy7uFKgwldR+B/6UFwKcZKrUFlH3lAO3jpH24d
	 AE8iGXzMnZGgY3lxI3GD7GYDKAkaQ5rIQG/2E8JRWsVgRoa64+6uoi6TeEdvHUjoi8
	 Oolrva4ykbCNVDA+9HmgbaSaeFl96aqjokbB7nnK0mXs9vtwcKmTEIOf6FSUjDqG7V
	 J28pqhmX6kJpA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 08/10] selftests/damon/drgn_dump_damon_status: dump pause
Date: Sun, 22 Mar 2026 08:57:22 -0700
Message-ID: <20260322155728.81434-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322155728.81434-1-sj@kernel.org>
References: <20260322155728.81434-1-sj@kernel.org>
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
