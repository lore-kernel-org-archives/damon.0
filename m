Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972E33B6DD;
	Sun,  1 Mar 2026 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387013; cv=none; b=h+4posCaAkqs6lqWscJ/Fhscs0MXtHLQklOGdMVE5Ah1R3P1k7dB1EwyTEDYfiIhXVZADr0msUbBpAVtD7tQVRrJUEP0p05D1FodxwOxJ2SDJLV+i4qu2MZoKdBdVM9rn3rqnqAMAJcUsUJLnLX5caS5kjTLGoXRMYrM+MsGm+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387013; c=relaxed/simple;
	bh=iYt3HJjJZ2u5nNYQJzA/aRcSczmrsEXHtQU6RM/AfoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yf1YhQH7d0XyzLfeWUoI4jAid+6midSMHReQ0RrszZHPax8eJygSKhuRW9DLnMQopr+zf5bzUVldz2L4W+wcQ6yNPf9fr1gdv4snXI4uKGKQ2+wjVL2guh0P0qBFt9ClM5gQi8VlqL0DgFpLvU+1EC/X1xk4ASWzhHZr+wKOqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFnCwPnh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFnCwPnh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8C8C2BC87;
	Sun,  1 Mar 2026 17:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772387013;
	bh=iYt3HJjJZ2u5nNYQJzA/aRcSczmrsEXHtQU6RM/AfoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rFnCwPnh++xwuWwRkrY4CeaxcG9bnQGTTsPkXqxRFt8lBulCdn2iwJDmW3m1DzqB/
	 oFsYCPGve5Z5apDfTyBNBnqBDhZYn/33mlrHakO7fXrFuN1GX16HBnAK0ZmNMf661+
	 vasUaayX06ox+vTFt+Z969t+RA8EhSzSRNoMA8dJaqzcYhSuoRQXl3oaUqGtFogb5m
	 D9ZZsE2smZ89GQIOJivP5SQFrvRmHCxk/HOY9VnNhIpr7TJfK8iAm7716scLjCnlOz
	 CYET4O54BaeyjJl6g0kzfm4mOTeVv4vpDKXoiiIx7i2KwhmMiq8X1Jof9i0rDJricX
	 atK970Ql+BjsA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 10/10] selftests/damon/config: enable DAMON_DEBUG_SANITY
Date: Sun,  1 Mar 2026 09:43:25 -0800
Message-ID: <20260301174327.76849-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260301174327.76849-1-sj@kernel.org>
References: <20260301174327.76849-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_DAMON_DEBUG_SANITY is recommended for DAMON development and test
setups.  Enable it on the build config for DAMON selftests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/config b/tools/testing/selftests/damon/config
index a68a9fead5dca..6304adacb741c 100644
--- a/tools/testing/selftests/damon/config
+++ b/tools/testing/selftests/damon/config
@@ -4,3 +4,4 @@ CONFIG_DAMON_PADDR=y
 CONFIG_DAMON_VADDR=y
 CONFIG_DAMON_RECLAIM=y
 CONFIG_DAMON_LRU_SORT=y
+CONFIG_DAMON_DEBUG_SANITY=y
-- 
2.47.3
