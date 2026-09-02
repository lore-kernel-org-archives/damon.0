Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B138E8B9;
	Wed,  2 Sep 2026 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328079; cv=none; b=lsLBfnMJzwF0yq/HRu3prc6oX+mUoaKOgPX8iOvG/d2s01Qbap50jVzTCUNxRZ39FVPJ1DvAy2+79iOSGOW3Lg1OTTJQZ2FnUOqL6naKS8WZmxrd+S2JDg2WYVY7+t0mBmT10c2MCIqcfkKCRVJXu8P/rxq+6W0Og/OxkV8/H2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328079; c=relaxed/simple;
	bh=HbRbHRXJKLR5v8dTl/LSDMwKCFClK2aYCYBJgtV6g70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tw+aqWfeAf55zWHW6CZJkTce5CwtRibE3GVa3Nrz4DHODR0KfH5/N3V7TE/5PUYISbXayVFBHtGOdu99re/IYYEwEf3qBJsyDuYOAh9ED0jcBXzse2yS/ypMv0xkDdQjCjng+K/MG+HLLLNt7UcbWysFGBo08b+V0g9r2TDM/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERR+va7v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERR+va7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFF01F00A3F;
	Wed,  2 Sep 2026 05:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328078;
	bh=jEqn658128UTd1o8tS5ZjT5LQQ6f3vfRE5EdtC108ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ERR+va7v7jV6syjvn8R/yUBvyK/UxNaRaNVakcrmAmMgw9hQqXPpDw1mb5jZ5LYx8
	 TtN4CIzctFX1QXt5wHf49T7bWKsSfUJpb/1GU34Jl1i3mRYi+WhAIFpfPz071elkku
	 C0v/ygGvwhHF23venbP+e7sMEzvp6WiC9Ns3KNDFueKGan1dYypMzz/AyXZNht+RwK
	 iVEveqQLS/Zwp4ROh3IW8ytBFCiPVqIKpLKsjjNQtB+klPSWSEHgM/B7Luzy8vybWa
	 fi/m9nROPRr6+/7KpCblcDNz8mT+iKNT89DuO3321p1eSA6pb9TPBrUkl6l2/gLfvl
	 NQH+rzise8OVg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/12] selftests/damon/sysfs.sh: test hugepage_mem_bp quota goal
Date: Tue,  1 Sep 2026 22:47:43 -0700
Message-ID: <20260902054747.99370-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902054747.99370-1-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs quota goal target_metric file now accepts 'hugepage_mem_bp'
input.  Test it is accepted in fundamental DAMON sysfs file operation
selftest.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index ddebde6edabe4..b66593c9ac471 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -210,6 +210,7 @@ test_goal()
 	ensure_write_succ "$fpath" "active_mem_bp" "valid input"
 	ensure_write_succ "$fpath" "inactive_mem_bp" "valid input"
 	ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"
+	ensure_write_succ "$fpath" "hugepage_mem_bp" "valid input"
 	ensure_write_fail "$fpath" "foo" "invalid input"
 	ensure_file "$goal_dir/nid" "exist" "600"
 	ensure_file "$goal_dir/path" "exist" "600"
-- 
2.47.3
