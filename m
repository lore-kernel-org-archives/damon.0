Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793553400;
	b=t/7tw/FhPwUGKtF8bOe1sxNl6cepQm8gqzVTyglGys+IL10pWrF+VPRiwoar6Ox51UuA
	 x0rXIZy05DqyAWfR2z8mXLHsdXpS+Kr5hMK65brOX6y18QAQDB1RUr51vswd6OJMoXJqf
	 sQ3WxNy1GIdqY+niTmSLcbbj4yuAWE6BxdLFkmXD4ZGkfY6hlhOeFPRXw9gb4qdTQqOby
	 uvuDFYob1CJfHlO13cgUDBMdBiXZHnE5V6K3kbHAzJ+O1EiExsr1l6WsxmiYJ/b7Rltn1
	 z4tXspcr/3PXbwbLxTQY8J1QQrl93ShFIJgWKdxobKt5MwpJ9j/ooN7Ko9qzCPFHiuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793553400;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Nl/jwuQeYoLkJzo/bhBa5SyX/AJXXbPvtIr1rgEJpfc=;
	b=A+Si53MyMYzGT9E5azM+aqNh4HhGUVsS9dq1PBsZeCLMRMjhgKaxoBmmC1WqslMO6eyx
	 /IpCKbhe6MfAlxyL3eQkv6a18aZmtwFovkGpxaNgTUhuYxuuafDcaotoPPACtegTmxTSM
	 rHdUSNjfD3xD+yiCzjrHh4q73/UqH5kmvefMNBvyWh7EEh/m4q9bFoT1msl5Hkqe348pP
	 Es3rI6l5VmtbQxoCKgElNxOn+q4jFZ0cdVL6DnxuwnVM7bAGqtCTs1XCRbnwNHFSS/lxl
	 y+X5IqaTXq5wfDvpGecopJ4c055tVgxKSjHt9q41kdiqkhxHnV5LWvjkOYNCurXCpmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdF2XExI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050DD60A2607;
	Sun,  1 Nov 2026 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdF2XExI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37B91F00A20;
	Sun,  1 Nov 2026 17:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793553399;
	bh=Nl/jwuQeYoLkJzo/bhBa5SyX/AJXXbPvtIr1rgEJpfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fdF2XExI4DFSHn3O+sv2bRhrZabBsUJQa7Q46X459ylwshC4GVgY9EGouNFGzEWxD
	 7/b0UDGTjczQ1VrCbZytoQsIsBvcAZdfq+Wb7wRv2sFGgDsEegfHuygkcIpyoimxTk
	 p7nUr6tmdkBgkXCYtic8otEvTzAWHQ6YFcroqckJe0FYPKJdFvJtRFcTJtR5y/L2XU
	 MO41HI4MHwCPsPu0htndVTEqkLX9Dd+1laq4ujto4zijNAKoVP8dtFHlR6bOxccba5
	 EY4kAgWmmOAaT+f2c2SK+ayeGvSGKxl/9aNrmA0LN1sS3Jph3ZX9tUGa3s1cOs0bhr
	 4l4FatZv41FWw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 5/6] selftests/damon/damos_apply_interval: remove unused variables
Date: Sun,  1 Nov 2026 09:16:28 -0800
Message-ID: <20261101171630.81477-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101171630.81477-1-sj@kernel.org>
References: <20261101171630.81477-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wss_collected and nr_quota_exceeds in damos_apply_interval.py are
assigned to but never used.  Remove.

The issue is found using flake8.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/damos_apply_interval.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/damon/damos_apply_interval.py b/tools/testing/selftests/damon/damos_apply_interval.py
index 0bf7768b2006a..0ad110be0fb94 100755
--- a/tools/testing/selftests/damon/damos_apply_interval.py
+++ b/tools/testing/selftests/damon/damos_apply_interval.py
@@ -42,8 +42,6 @@ def main():
         print('kdamond start failed: %s' % err)
         exit(1)
 
-    wss_collected = []
-    nr_quota_exceeds = 0
     while proc.poll() == None:
         time.sleep(0.1)
         err = kdamonds.kdamonds[0].update_schemes_stats()
-- 
2.47.3
